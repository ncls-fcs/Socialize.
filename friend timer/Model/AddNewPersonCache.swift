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
    
    func clear() {
        self.newPersonName = ""
        self.date = Date.now
    }
}
