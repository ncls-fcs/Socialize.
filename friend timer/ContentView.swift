//
//  ContentView.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
        
    @State private var isPresentingAddView = false
    
    @Environment(\.scenePhase) private var scenePhase   //operational State of the app gets saved to scenePhase from @Environment Property
    @Environment(\.editMode) var editMode   //
    
    let saveAction: () -> Void
    
    func delete(at offsets: IndexSet) {
        modelData.friends.remove(atOffsets: offsets)
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
                            .environment(editMode)
                    }
                    .onDelete(perform: delete)
                    
                }
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
                .navigationTitle("Last met")

                
                .sheet(isPresented: $isPresentingAddView) {
                    AddNewPersonSheet(isPresentingAddView: $isPresentingAddView)
                }
                #warning("TODO: Need to be able to edit Persons in List. Currently generalising AddNewPersonSheet and AddNewPersonView to be able to handle adding new Person AND editing existing Person. Then if in editMode and user clicks on Person in List, AddNewPersonSheet must be displayed with clicked on Person loaded")
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
