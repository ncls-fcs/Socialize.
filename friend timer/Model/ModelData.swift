//
//  data.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

import Foundation
import SwiftUI
import Combine

struct Person: Identifiable {
    let id = UUID()
    var name: String = ""
    var lastContact: Date = Date.now
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

