//
//  views.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 10.10.22.
//

import Foundation
import SwiftUI

struct FriendRow: View {
    var friend: Person
    @State var showAlert: Bool = false
    
    @EnvironmentObject var modelData: ModelData
    
    func setLastContactToNow(id: UUID) {
        var tempPerson:Person?
        
        tempPerson = modelData.friends.remove(at: modelData.friends.firstIndex(where: {$0.id == id})!)
        tempPerson?.lastContact = Date.now
        modelData.friends.append(tempPerson!)
        modelData.friends.sort {
            $0.lastContact < $1.lastContact
        }
    }
    
    var body: some View {
        Button(action: {showAlert = true}){
            HStack{
                VStack(alignment: .leading) {
                    Text(friend.name)
                        .font(.headline)
                    Text(formatDate(date:friend.lastContact))
                        .font(.subheadline)
                }
                Spacer()
                if (DateInterval(start: friend.lastContact, end: Date.now) > DateInterval(start: friend.lastContact, duration: 604800)) {
                    Image(systemName: "clock.badge.exclamationmark")
                        .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.2, opacity: 1.0))
                }
            }
        }
        .accentColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .alert("Reset timer?", isPresented: $showAlert) {
            Button("No"){
                
            }
            Button("Yes"){
                setLastContactToNow(id: friend.id)
            }
        }

    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: friendsSamples[1])
    }
}
