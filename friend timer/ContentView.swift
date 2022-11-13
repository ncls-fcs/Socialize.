//
//  ContentView.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

#warning("Implementation of refresher for time intervall of 'lastContact' needs to be changed to one where the original Person object gets altered and not deleted and a new one with the date set to now inserted")

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @ObservedObject var newPerson: NewPerson = NewPerson()
    
    @State private var isPresentingAddView = false
    
    @Environment(\.scenePhase) private var scenePhase   //operational State of the app gets saved to scenePhase from @Environment Property
    
    let saveAction: () -> Void
    
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
                    .navigationTitle("Last met")
                    .toolbar {
                    EditButton()
                    Spacer()
                    Button(action: {
                        isPresentingAddView = true
                    }){
                        Image(systemName: "plus")
                    }
                    Spacer()
                }
                
                
                .sheet(isPresented: $isPresentingAddView) {
                    NavigationView {
                        AddNewPersonView(newPerson: newPerson)
                            .navigationTitle($newPerson.newPersonName)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        newPerson.clear()
                                        isPresentingAddView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Add") {
                                        addNewPerson(name: newPerson.newPersonName, lastContact: newPerson.date, priority: newPerson.priority)    //Übergibt Daten aus newPerson ("Cache" für die neu angelegte Person in AddNewPersonView) an ModelData
                                        
                                        isPresentingAddView = false
                                        
                                        //Requesting notification permission
                                        let center = UNUserNotificationCenter.current()
                                        center.requestAuthorization(options: [.alert, .badge, .sound]) {granted, error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                            }
                                        }
                                        
                                        //getting notification permissions and settings
                                        center.getNotificationSettings { settings in
                                            guard settings.authorizationStatus == .authorized else {
                                                return
                                            }
                                            var notificationTimeInterval: Double
                                            switch newPerson.priority {
                                            case 0: notificationTimeInterval = 302400
                                            case 1: notificationTimeInterval = 604800
                                            case 2: notificationTimeInterval = 907200
                                            default:
                                                notificationTimeInterval = 20
                                            }
                                            //Notification scheduling
                                            addNotification(title: newPerson.newPersonName, body: "Go meet with your mate, it´s been \(Int(notificationTimeInterval/604800)) weeks", timeInterval: notificationTimeInterval)
                                        }
  
                                        newPerson.clear()   //Gibt das Modell newPerson frei
                                    }
                                }
                            }
                    }
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {
                    saveAction()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(saveAction:{})
            .environmentObject(ModelData())
    }
}
