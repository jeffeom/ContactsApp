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
    layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 10)
    layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 10)
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
    if indexPath.item == 0 || indexPath.item % 3 == 0 {
      //0, 3, 6, 9, 12, 14
      cell.contentView.backgroundColor = .lightTeal()
      cell.titleLabel.textColor = CardThemeType.lightTeal.titleLabelColor()
      cell.subTitleLabel.textColor = CardThemeType.lightTeal.subtitleColor()
      cell.numberOfPeopleLabel.textColor = CardThemeType.lightTeal.numberLabelColor()
    }else if indexPath.item % 3 == 1 {
      //1, 4, 7,
      cell.contentView.backgroundColor = .charcoalGrey()
      cell.titleLabel.textColor = CardThemeType.charcoalGrey.titleLabelColor()
      cell.subTitleLabel.textColor = CardThemeType.charcoalGrey.subtitleColor()
      cell.numberOfPeopleLabel.textColor = CardThemeType.charcoalGrey.numberLabelColor()
    }else if indexPath.item % 3 == 2 {
      cell.contentView.backgroundColor = .blueyGrey()
      cell.titleLabel.textColor = CardThemeType.blueyGrey.titleLabelColor()
      cell.subTitleLabel.textColor = CardThemeType.blueyGrey.subtitleColor()
      cell.numberOfPeopleLabel.textColor = CardThemeType.blueyGrey.numberLabelColor()
    }
    cell.titleLabel.text = contactsArray[indexPath.row]
    cell.subTitleLabel.text = "Pikachu"
    cell.numberOfPeopleLabel.text = "20"
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width - 32, height: CardCollectionViewCell.cellCustomHeight)
  }
}
