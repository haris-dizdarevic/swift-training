//
//  Meal.swift
//  FoodTracker
//
//  Created by Haris Dizdarevic on 09/02/2018.
//  Copyright © 2018 Haris Dizdarevic. All rights reserved.
//

import UIKit

class Meal {
  //MARK: Properties
  
  var name: String
  var photo: UIImage?
  var rating: Int
  
  //MARK: Initialization
  
  init?(name: String, photo: UIImage?, rating: Int) {
    // Initialization should fail if there is no name or if the rating is negative
    
    guard !name.isEmpty else {
      return nil
    }
    guard (rating >= 0) && (rating <= 5) else {
      return nil
    }
    
    // Initialize stored properties
    self.name = name
    self.photo = photo
    self.rating = rating
  }
}
