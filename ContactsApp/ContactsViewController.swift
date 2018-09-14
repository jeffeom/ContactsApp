//
//  ViewController.swift
//  ContactsApp
//
//  Created by Jeff Eom on 2018-09-13.
//  Copyright © 2018 Jeff Eom. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
  var contactsTableView: UITableView?
  var contactsArray = ["Jeff", "Joon", "Peter"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Contacts"
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressedAddButton))
    navigationItem.rightBarButtonItem = addButton
    contactsTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
    contactsTableView?.delegate = self
    contactsTableView?.dataSource = self
    contactsTableView?.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
    view.addSubview(contactsTableView!)
  }
}

//MARK: UIButton
extension ContactsViewController {
  @objc func pressedAddButton() {
    
  }
}

//MARK: UITableView
extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contactsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier) as! ContactsTableViewCell
    cell.textLabel?.text = contactsArray[indexPath.row]
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}
