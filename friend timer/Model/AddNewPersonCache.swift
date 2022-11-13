//
//  AddNewPersonCache.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 13.10.22.
//

import Foundation

class NewPerson: ObservableObject {
    @Published var newPersonName: String = ""
    @Published var date: Date = Date.now
    @Published var priority: Int = 0
    
    func clear() {
        self.newPersonName = ""
        self.date = Date.now
        self.priority = 0
    }
}
