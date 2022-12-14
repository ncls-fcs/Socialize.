//
//  AddNewPersonView.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 10.10.22.
//

#warning("TODO: Add Priority-Option to newPerson")

import SwiftUI
import Combine




let datesUntilNow = ...Date.now

struct AddNewPersonView: View {
    
    @ObservedObject var newPerson: NewPerson
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("New Name", text: $newPerson.newPersonName)
                }
                Section(header: Text("Time of last Meeting")) {
                    DatePicker(selection: $newPerson.date, in: datesUntilNow ,label: {Text("Date of last meeting:") })
                        .datePickerStyle(.graphical)
                }
                Picker(selection: $newPerson.priority, label: Text("Priority")) {
                    Text("Low").tag(0)
                    Text("Medium").tag(1)
                    Text("High").tag(2)
                }
                
            }
            
            
        }
    }
}

struct AddNewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPersonView(newPerson: NewPerson())
    }
}
