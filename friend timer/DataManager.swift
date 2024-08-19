//
//  DataManager.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 19.08.24.
//

import Foundation


class DataManager {
    private var modelData: ModelData

    init(modelData: ModelData) {
        self.modelData = modelData
    }

    func saveData() {
        // Implement your save logic here
    }
    
    func loadFromDisk() {
        ModelData.loadFromDisk { result in
            switch result {
            case .failure(let error):
                fatalError("Error in loading modelData Array from file: "+error.localizedDescription)
            case .success(let personArrayFromFile):
                
                print("Loading completed: ")
                for person in personArrayFromFile {
                    print(person.name)
                }
                DispatchQueue.main.async {
                    self.modelData.friends = personArrayFromFile
                }
            }
        }
    }
}
