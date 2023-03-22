//
//  AddNewPersonCache.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 13.10.22.
//

import Foundation

class NewPerson: Person {
    //@Published var name: String = ""
    //@Published var lastContact: Date = Date.now
    //@Published var priority: Int = 0
    
    func clear() {
        self.name = ""
        self.lastContact = Date.now
        self.priority = 0
    }
}
