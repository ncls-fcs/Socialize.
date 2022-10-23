//
//  data.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

#warning("TODO: Add Data Persistence (JSON)")
#warning("TODO: Add Priority to Friends")

import Foundation
import SwiftUI
import Combine

struct Person: Identifiable, Codable {
    let id: UUID
    var name: String
    var lastContact: Date
    
    init(id: UUID = UUID(), name: String = "", lastContact: Date = Date.now) {
        self.id = id
        self.name = name
        self.lastContact = lastContact
    }
}

final class ModelData: ObservableObject {
    @Published var friends: [Person] = []
}


func formatDate(date:Date) -> String {
    let formatStyle = Date.RelativeFormatStyle(
                presentation: .named,
                unitsStyle: .spellOut,
                locale: Locale(identifier: "en_GB"),
                calendar: Calendar.current,
                capitalizationContext: .beginningOfSentence)
    
    return formatStyle.format(date)
}

