//
//  Checklist.swift
//  Checklists
//
//  Created by Haris Dizdarevic on 26/02/2018.
//  Copyright © 2018 Haris Dizdarevic. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
  var name = ""
  var iconName: String
  var items = [ChecklistItem]()
  
  convenience init(name: String) {
    self.init(name: name, iconName: "No Icon")
  }
  
  init(name: String, iconName: String) {
    self.name = name
    self.iconName = iconName
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "Name") as! String
    items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
    iconName = aDecoder.decodeObject(forKey: "IconName") as! String
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "Name")
    aCoder.encode(items, forKey: "Items")
    aCoder.encode(iconName, forKey: "IconName")
  }
  
  func countUncheckedItems() -> Int {
    return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1)}
  }
}
