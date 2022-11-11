//
//  UserDefaultsHandler.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 03.11.22.
//

import Foundation


let defaults = UserDefaults()

struct DefaultsKeys {
    static let ModelDataKey = "ModelData"
}

func saveInUserDefaults(data:ModelData, key:String){
    defaults.set(data, forKey: key)
}

func retrieveUserDefaults(key:String) -> Any? {
    if let data = defaults.object(forKey: key) {
        return data
    }
    return nil
}


