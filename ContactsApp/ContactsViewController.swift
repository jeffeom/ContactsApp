//
//  ViewController.swift
//  ContactsApp
//
//  Created by Jeff Eom on 2018-09-13.
//  Copyright © 2018 Jeff Eom. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
  var contactsCollectionView: UICollectionView?
  var contactsArray = ["Jeff", "Joon", "Peter"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.translatesAutoresizingMaskIntoConstraints = false
    title = "Contacts"
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressedAddButton))
    navigationItem.rightBarButtonItem = addButton
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .vertical
    contactsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64), collectionViewLayout: layout)
    contactsCollectionView?.delegate = self
    contactsCollectionView?.dataSource = self
    contactsCollectionView?.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
    contactsCollectionView?.backgroundColor = .white
    view.addSubview(contactsCollectionView!)
  }
}

//MARK: UIButton
extension ContactsViewController {
  @objc func pressedAddButton() {
    contactsArray.append("Pikachu")
    contactsCollectionView?.reloadData()
  }
}

//MARK: UITableView
extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return contactsArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
    // 0 3 6
    // 1 4 7
    // 2 5 8
    if indexPath.item == 0 || indexPath.item % 3 == 0 {
      cell.cellType = .lightTeal
    }else if indexPath.item % 2 == 1 {
      cell.cellType = .charcoalGrey
    }else if indexPath.item % 3 == 1 {
      cell.cellType = .blueyGrey
    }
    cell.title = contactsArray[indexPath.row]
    cell.subtitle = "Pikachu"
    cell.numberOfPeople = "20"
    return cell
  }
}
