//
//  data.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 09.10.22.
//

#warning("TODO: Add Priority to Friends")

import Foundation
import SwiftUI
import Combine

class Person: Identifiable, Codable, ObservableObject {
    let id: UUID
    var name: String
    var lastContact: Date
    var priority: Int
    
    init(id: UUID = UUID(), name: String = "", lastContact: Date = Date.now, priority: Int = 0) {
        self.id = id
        self.name = name
        self.lastContact = lastContact
        self.priority = priority
    }
}

final class ModelData: ObservableObject {
    @Published var friends: [Person] = []
    
    //function for generating URL for "friends.data"
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("friends.data")
    }
    
    //function for loading data
    static func load(completion: @escaping (Result<[Person], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let friendsArray = try JSONDecoder().decode([Person].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(friendsArray))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //function for saving data through a completion handler
    static func save(friends: [Person], completion: @escaping (Result<Int, Error>)->Void){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(friends)
                let fileURL = try fileURL()
                try data.write(to: fileURL)
                DispatchQueue.main.async {
                    completion(.success(friends.count))
                }
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


func formatDate(date:Date) -> String {
    let formatStyle = Date.RelativeFormatStyle(
                presentation: .named,
                unitsStyle: .spellOut,
                locale: Locale(identifier: "en_GB"),
                calendar: Calendar.current,
                capitalizationContext: .beginningOfSentence)
    #warning("TODO: if relative time is under one minute display 'now' instead of seconds")
    return formatStyle.format(date)
}

