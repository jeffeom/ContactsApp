//
//  ContactsRoomViewController.swift
//  ContactsApp
//
//  Created by Jeff Eom on 2018-11-29.
//  Copyright © 2018 Jeff Eom. All rights reserved.
//

import UIKit

class ContactsRoomViewController: UIViewController {
  static let identifier = "ContactsRoomViewController"
  var roomName = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    title = roomName
    view.backgroundColor = .white
  }
}
