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
    
    var body: some View {
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
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: friendsSamples[1])
    }
}
