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
        HStack {
            Text(friend.name)
            Spacer()
            Text(formatDate(date:friend.lastContact)).bold()
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: ModelData().friends[0])
    }
}
