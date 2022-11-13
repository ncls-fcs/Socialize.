//
//  NotificationHandler.swift
//  friend timer
//
//  Created by Nicolas Fuchs on 23.10.22.
//

import Foundation
import UserNotifications

func addNotification(title:String, body:String, timeInterval:Double){
    //Create Content of notification
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    
    //create trigger
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    
    //Create Notification request
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
    
    //Schedule request with the system
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request)
}
    
