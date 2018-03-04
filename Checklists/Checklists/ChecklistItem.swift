//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Haris Dizdarevic on 21/01/2018.
//  Copyright © 2018 Haris Dizdarevic. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding {
  var text = ""
  var checked = false
  var dueDate = Date()
  var shouldRemind = false
  var itemID: Int
  
  func toggleChecked() {
    checked = !checked
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(text, forKey: "Text")
    aCoder.encode(checked, forKey: "Checked")
    aCoder.encode(dueDate, forKey: "DueDate")
    aCoder.encode(shouldRemind, forKey: "ShouldRemind")
    aCoder.encode(itemID, forKey: "ItemID")
  }
  
  required init?(coder aDecoder: NSCoder) {
    dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
    shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
    itemID = aDecoder.decodeInteger(forKey: "ItemID")
    text = aDecoder.decodeObject(forKey: "Text") as! String
    checked = aDecoder.decodeBool(forKey: "Checked")
    super.init()
  }
  
  override init() {
    itemID = DataModel.nextChecklistItemID()
    super.init()
  }
  
  deinit {
    removeNotification()
  }
  
  func scheduleNotification() {
    removeNotification()
    if shouldRemind && dueDate > Date() {
      let content = UNMutableNotificationContent()
      content.title = "Reminder:"
      content.body = text
      content.sound = UNNotificationSound.default()
      
      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
      
      let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
      
      let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
      
      let center = UNUserNotificationCenter.current()
      center.add(request)
          }
  }
  
  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
  }
}
