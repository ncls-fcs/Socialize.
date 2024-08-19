//
//  friend_timerApp.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

import SwiftUI

@main
struct friend_timerApp: App {
    @State private var modelData = ModelData()
       
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
                .onAppear(perform: {
                    ModelData.loadFromDisk { result in
                        switch result {
                        case .failure(let error):
                            fatalError("Error in loading modelData Array from file: "+error.localizedDescription)
                        case .success(let personArrayFromFile):
                            
                            print("Loading completed: ")
                            for person in personArrayFromFile {
                                print(person.name)
                            }
                            
                            modelData.friends = personArrayFromFile
                        }
                    }
                })
        }
    }
}
