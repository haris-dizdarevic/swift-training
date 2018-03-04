//
//  ViewController.swift
//  Checklists
//
//  Created by Haris Dizdarevic on 21/01/2018.
//  Copyright © 2018 Haris Dizdarevic. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
  
  // MARK: Properties
  var checklist: Checklist!

  override func viewDidLoad() {
    super.viewDidLoad()
    title = checklist.name
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // 1
    if segue.identifier == "AddItem" {
      // 2
      let navigationController = segue.destination as! UINavigationController
      
      // 3
      let controller = navigationController.topViewController as! ItemDetailViewController
      
      //4
      controller.delegate = self
    } else if segue.identifier == "EditItem" {
      let navigationController = segue.destination as! UINavigationController
      
      let controller = navigationController.topViewController as! ItemDetailViewController
      
      controller.delegate = self
      
      if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
        controller.itemToEdit = checklist.items[indexPath.row]
      }
    }
  }
  
  // MARK: Table view interface
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checklist.items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    let item = checklist.items[indexPath.row]
   
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = checklist.items[indexPath.row]
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    // first remove item from array of items
    checklist.items.remove(at: indexPath.row)
    
    // second, delete rows from table view
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  // MARK: ItemDetailViewController protocol implementations
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
    let newRowIndex = checklist.items.count
    checklist.items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
    dismiss(animated: true, completion: nil)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
    if let index = checklist.items.index(of: item) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: Helper methods
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1001) as! UILabel
    
    if item.checked {
      label.text = "√"
    } else {
      label.text = ""
    }
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let label = cell.viewWithTag(1000) as! UILabel
//    label.text = item.text
    label.text = "\(item.itemID): \(item.text)"
  }
  
//  func documentsDirectory() -> URL {
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//    return paths[0]
//  }
//
//  func dataFilePath() -> URL {
//    return documentsDirectory().appendingPathComponent("Checklists.plist")
//  }
//
//  func saveChecklistItems() {
//    let data = NSMutableData()
//    let archiver = NSKeyedArchiver(forWritingWith: data)
//    archiver.encode(checklist.items, forKey: "ChecklistItems")
//    archiver.finishEncoding()
//    data.write(to: dataFilePath(), atomically: true)
//  }
//
//  func loadChecklistItems() {
//    // 1
//    let path = dataFilePath()
//    // 2
//    if let data = try? Data(contentsOf: path) {
//      // 3
//      let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
//      checklist.items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem]
//      unarchiver.finishDecoding()
//    }
//  }
}
