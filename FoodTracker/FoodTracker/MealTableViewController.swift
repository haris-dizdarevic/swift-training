//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Haris Dizdarevic on 09/02/2018.
//  Copyright © 2018 Haris Dizdarevic. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
  
  // MARK: Properties
  
  var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

      // Load the sample data.
      loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // Table view cells are reused and should be dequeued using a cell identifier.
      let cellIdentifier = "MealTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
        fatalError("The dequeued cell is not an instance of MealTableViewCell.")
      }
      
      // Fetches the appropriate meal for the data source layout.
      let meal = meals[indexPath.row]
      
      cell.nameLabel.text = meal.name
      cell.photoImageView.image = meal.photo
      cell.ratingControl.rating = meal.rating

      return cell
    }

  // MARK: Actions
  
  @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    if let sourceViewController = sender.source as? MealViewController,
      let meal = sourceViewController.meal {
      // Add new meal
      let newIndexPath = IndexPath(row: meals.count, section: 0)
      meals.append(meal)
      tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
  }
  
  // MARK: Private Methods
  
  private func loadSampleMeals() {
    let photo1 = UIImage(named: "meal1")
    let photo2 = UIImage(named: "meal2")
    let photo3 = UIImage(named: "meal3")
    
    guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
      fatalError("Unable to instantiate meal1")
    }
    
    guard let meal2 = Meal(name: "Chicken and Patatoes", photo: photo2, rating: 5) else {
      fatalError("Unable to instantiate meal2")
    }
    
    guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
      fatalError("Unable to instantiate meal2")
    }
    
    meals += [meal1, meal2, meal3]
  }
}
