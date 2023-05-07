//
//  AddNewPersonSheet.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 27.03.23.
//

import SwiftUI

struct AddNewPersonSheet: View {
    @EnvironmentObject var modelData: ModelData
    
    @ObservedObject var newPerson: Person = Person()

    @State var isPresentingAddView: Binding<Bool>   //the value of isPresentingAddView is collected as a Binding when calling this view. Thats why we need to unwrap it first before using (.wrappedValue)
    
    func addNewPerson(name:String, lastContact:Date = Date.now, priority:Int) {
        //add a new friend struct with a given name and given date; if no date is provided it uses the current date
        modelData.friends.append(Person(name:name, lastContact:lastContact, priority:priority))
        modelData.friends.sort {
            $0.lastContact < $1.lastContact
        }
    }
    
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

/*
 struct AddNewPersonSheet_Previews: PreviewProvider {
 static var previews: some View {
 AddNewPersonSheet(isPresentingAddView: )
 }
 }
 */
