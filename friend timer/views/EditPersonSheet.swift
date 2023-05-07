//
//  EditPersonSheet.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 27.03.23.
//

import SwiftUI

struct EditPersonSheet: View {
    @ObservedObject var personToBeEdited: Person
    
    var body: some View {
        NavigationView {
            AddNewPersonView(newPerson: newPerson)
                .navigationTitle($newPerson.name)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingAddView.wrappedValue = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            addNewPerson(name: newPerson.name, lastContact: newPerson.lastContact, priority: newPerson.priority)    //Übergibt Daten aus newPerson ("Cache" für die neu angelegte Person in AddNewPersonView) an ModelData
                            
                            scheduleNotification(Person: newPerson)
                            isPresentingAddView.wrappedValue = false
                        }
                    }
                }
        }
    }
}

struct EditPersonSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditPersonSheet()
    }
}
