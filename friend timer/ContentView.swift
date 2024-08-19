//
//  ContentView.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(ModelData.self) private var modelData
    
    @ObservedObject var newPerson: NewPerson = NewPerson()
    
    @State private var isPresentingAddView = false
    @State private var importing = false
    @State private var errorOccured = false
    @State private var details: Error?
    
    @Environment(\.scenePhase) private var scenePhase   //operational State of the app gets saved to scenePhase from @Environment Property
    
    func delete(at offsets: IndexSet) {
        modelData.friends.remove(atOffsets: offsets)
    }
    
    func addNewPerson(name:String, lastContact:Date = Date.now, priority:Int) {
        //add a new friend struct with a given name and given date; if no date is provided it uses the current date
        modelData.friends.append(Person(name:name, lastContact:lastContact, priority:priority))
        modelData.friends.sort {
            $0.lastContact < $1.lastContact
        }
    }
    
    func loadFromDisk() {
        ModelData.loadFromDisk { result in
            switch result {
            case .failure(let error):
                fatalError("Error in loading modelData Array from file: "+error.localizedDescription)
            case .success(let personArrayFromFile):
                
                print("Loading completed: ")
                for person in personArrayFromFile {
                    print(person.name)
                }
                DispatchQueue.main.async {
                    self.modelData.friends = personArrayFromFile
                }
            }
        }
    }
    
    func saveToDisk() {
        ModelData.save(friends: modelData.friends) { result in
            switch result {
            case .failure(let error):
                fatalError("Error while saving friends Array in ModelData to file "+error.localizedDescription)
            case .success(let savedPersonCount):
                print("Saved "+String(savedPersonCount)+" Entities to file")
            }
        }
    }

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Shows the friend you visited last on top, go text them now!")
                    .foregroundColor(Color.gray)
                    .padding([.top, .leading], 20.0)
                List {
                    ForEach(modelData.friends) {
                        friend in FriendRow(friend: friend)
                    }
                    .onDelete(perform: delete)
                }
                .refreshable {
                    loadFromDisk()
                }
                    .navigationTitle("Last met")
                    .toolbar {
                        // Import Data
                        Button(action: {
                            importing = true
                        }){
                            Image(systemName: "square.and.arrow.down")
                        }
                        .fileImporter(
                            isPresented: $importing,
                            allowedContentTypes: [.json]
                        ) { result in
                            switch result {
                            case .success(let files):
                                ModelData.load(fileURL: files) { result in
                                    switch result {
                                    case .failure(let error):
                                        details = error
                                        errorOccured = true
                                    case .success(let personArrayFromFile):
                                        modelData.friends = personArrayFromFile
                                    }
                                }
                            case .failure(let error):
                                details = error
                                errorOccured = true
                            }
                        }
                        .alert(
                            "Failure Importing",
                            isPresented: $errorOccured,
                            presenting: details
                        ) { details in }
                        message: { details in
                            Text(details.localizedDescription)
                        }
                        
                        // Export Data
                        ShareLink(item: modelData.friends, preview: SharePreview("Backup Data"))
                        Spacer()
                        EditButton()
                        Spacer()
                        
                        // Add new Friend to List
                        Button(action: {
                            isPresentingAddView = true
                        }){
                            Image(systemName: "plus")
                        }
                        Spacer()
                    }
                }
                .sheet(isPresented: $isPresentingAddView) {
                    NavigationView {
                        AddNewPersonView(newPerson: newPerson)
                            .navigationTitle($newPerson.name)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        newPerson.clear()
                                        isPresentingAddView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Add") {
                                        addNewPerson(name: newPerson.name, lastContact: newPerson.lastContact, priority: newPerson.priority)    //Übergibt Daten aus newPerson ("Cache" für die neu angelegte Person in AddNewPersonView) an ModelData
                                        
                                        isPresentingAddView = false
                                        
                                        scheduleNotification(Person: newPerson)
      
                                        newPerson.clear()   //Gibt das Modell newPerson frei
                                        
                                        saveToDisk()
                                    }
                                }
                            }
                    }
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {
                    saveToDisk()
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
