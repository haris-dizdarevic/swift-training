//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Haris Dizdarevic on 26/02/2018.
//  Copyright © 2018 Haris Dizdarevic. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
  func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist)
  func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate {
  
  @IBOutlet weak var checklistTextField: UITextField!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!
  @IBOutlet weak var iconImageView: UIImageView!
  
  weak var delegate: ListDetailViewControllerDelegate?
  
  var checklistToEdit: Checklist?
  var iconName = "Folder"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let checklist = checklistToEdit {
      title = "Edit Checklist"
      checklistTextField.text = checklist.name
      doneBarButton.isEnabled = true
      iconName = checklist.iconName
      iconImageView.image = UIImage(named: iconName)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // By making text field to become first responder we are showing keyboard when view renders
    checklistTextField.becomeFirstResponder()
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if indexPath.section == 1 {
      return indexPath
    } else {
      return nil
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "PickIcon" {
      let controller = segue.destination as! IconPickerViewController
      controller.delegate = self
    }
  }
  
  // MARK: text field
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = checklistTextField.text! as NSString
    let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
    doneBarButton.isEnabled = newText.length > 0
    return true
  }
  
  @IBAction func cancel() {
    delegate?.listDetailViewControllerDidCancel(self)
  }
  
  @IBAction func done() {
    if let checklist = checklistToEdit {
      checklist.name = checklistTextField.text!
      checklist.iconName = iconName
      delegate?.listDetailViewController(self, didFinishEditing: checklist)
    } else {
      let checklist = Checklist(name: checklistTextField.text!, iconName: iconName)
      delegate?.listDetailViewController(self, didFinishAdding: checklist)
    }
  }
  
  func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
    self.iconName = iconName
    iconImageView.image = UIImage(named: iconName)
    let _ = navigationController?.popViewController(animated: true)
  }
}
