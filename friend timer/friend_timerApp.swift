//
//  friend_timerApp.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//
#warning("TODO: Add NotificationHandler Caller for overdue meetings")

import SwiftUI

@main
struct friend_timerApp: App {
    @StateObject private var modelData = ModelData()
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(){
                ModelData.save(friends: modelData.friends) { result in
                    switch result {
                    case .failure(let error):
                        fatalError("Error while saving friends Array in ModelData to file "+error.localizedDescription)
                    case .success(let savedPersonCount):
                        print("Saved "+String(savedPersonCount)+" Entities to file")
                    }
                }
            }
                .environmentObject(modelData)
                .onAppear{
                    ModelData.load { result in
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
                }
        }
    }
}
