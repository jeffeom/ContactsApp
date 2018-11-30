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
  var contactsArray = [ContactRoom]()
  var filteredContactsArray = [ContactRoom]()
  
  private var finishedLoadingInitialTableCells = false
  
  var lastIndexPath: IndexPath?
  
  var isFiltering = false
  
  var addBarButton: UIBarButtonItem?
  var settingBarButton: UIBarButtonItem?
  var undoBarButton: UIBarButtonItem?
  var doneButton: UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Contacts"
    let addButton = UIButton(type: .custom)
    addButton.setImage(UIImage(named: "addPlus"), for: .normal)
    addButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
    addButton.addTarget(self, action: #selector(pressedAddButton), for: .touchUpInside)
    let addBarButton = UIBarButtonItem(customView: addButton)
    
    let settingButton = UIButton(type: .custom)
    settingButton.setImage(UIImage(named: "settingGear"), for: .normal)
    settingButton.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
    settingButton.addTarget(self, action: #selector(pressedSettingButton), for: .touchUpInside)
    let settingBarButton = UIBarButtonItem(customView: settingButton)
    
    navigationItem.rightBarButtonItems = [addBarButton, settingBarButton]
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .vertical
    layout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 10)
    layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 10)
    contactsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    contactsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
    contactsCollectionView?.delegate = self
    contactsCollectionView?.dataSource = self
    contactsCollectionView?.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
    contactsCollectionView?.backgroundColor = .white
    view.addSubview(contactsCollectionView!)
    contactsCollectionView?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    contactsCollectionView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//    contactsCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    contactsCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
    
    let search = UISearchController(searchResultsController: nil)
    search.searchResultsUpdater = self
    search.obscuresBackgroundDuringPresentation = false
//    search.hidesNavigationBarDuringPresentation = false
    search.searchBar.placeholder = "Search Room"
    navigationItem.searchController = search
    navigationItem.hidesSearchBarWhenScrolling = false
    definesPresentationContext = true
  }
}

//MARK: UISearchResultsUpdating
extension ContactsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    if (searchController.searchBar.text?.isEmpty ?? true) {
      isFiltering = false
      contactsCollectionView?.reloadData()
    }else {
      isFiltering = true
      filteredContactsArray = contactsArray.filter({ $0.title!.lowercased().range(of: searchController.searchBar.text?.lowercased() ?? "") != nil })
      contactsCollectionView?.reloadData()
    }
  }
}

//MARK: UIButton
extension ContactsViewController {
  @objc func pressedAddButton() {
    finishedLoadingInitialTableCells = false
    let aRoom = ContactRoom()
    aRoom.title = "Urban One"
    aRoom.subTitle = "Pikachu"
    contactsArray.append(aRoom)
    lastIndexPath = IndexPath(item: contactsArray.count - 1, section: 0)
    contactsCollectionView?.reloadData()
  }
  
  @objc func pressedSettingButton() {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction) in
      self.pressedToEdit()
    }))
    alert.addAction(UIAlertAction(title: "Settings", style: .destructive , handler:{ (UIAlertAction) in
      print("User click Settings button")
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction) in
      print("User click Cancel button")
    }))
    self.present(alert, animated: true)
  }
  
  func pressedToEdit() {
    title = "Edit"
    
  }
}

//MARK: UITableView
extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if isFiltering {
      return filteredContactsArray.count
    }else {
      return contactsArray.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as! CardCollectionViewCell
    if indexPath.item == 0 || indexPath.item % 3 == 0 {
      //0, 3, 6, 9, 12, 14
      cell.contentView.backgroundColor = .lightTeal()
      cell.cellType = .lightTeal
      cell.titleLabel.textColor = CardThemeType.lightTeal.titleLabelColor()
      cell.subTitleLabel.textColor = CardThemeType.lightTeal.subtitleColor()
      cell.numberOfPeopleLabel.textColor = CardThemeType.lightTeal.numberLabelColor()
      cell.personImageView.image = UIImage(named: "user_icon_black")
    }else if indexPath.item % 3 == 1 {
      //1, 4, 7,
      cell.contentView.backgroundColor = .charcoalGrey()
      cell.cellType = .charcoalGrey
      cell.titleLabel.textColor = CardThemeType.charcoalGrey.titleLabelColor()
      cell.subTitleLabel.textColor = CardThemeType.charcoalGrey.subtitleColor()
      cell.numberOfPeopleLabel.textColor = CardThemeType.charcoalGrey.numberLabelColor()
      cell.personImageView.image = UIImage(named: "user_icon_white")
    }else if indexPath.item % 3 == 2 {
      cell.contentView.backgroundColor = .blueyGrey()
      cell.cellType = .blueyGrey
      cell.titleLabel.textColor = CardThemeType.blueyGrey.titleLabelColor()
      cell.subTitleLabel.textColor = CardThemeType.blueyGrey.subtitleColor()
      cell.numberOfPeopleLabel.textColor = CardThemeType.blueyGrey.numberLabelColor()
      cell.personImageView.image = UIImage(named: "user_icon_black")
    }
    if isFiltering {
      cell.titleLabel.text = filteredContactsArray[indexPath.row].title
      cell.subTitleLabel.text = filteredContactsArray[indexPath.row].subTitle
    }else {
      cell.titleLabel.text = contactsArray[indexPath.row].title
      cell.subTitleLabel.text = contactsArray[indexPath.row].subTitle
    }
    cell.numberOfPeopleLabel.text = "20"
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width - 32, height: CardCollectionViewCell.cellCustomHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    var lastInitialDisplayableCell = false
    //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
    if isFiltering {
      if filteredContactsArray.count > 0 && !finishedLoadingInitialTableCells {
        lastIndexPath = IndexPath(item: filteredContactsArray.count - 1, section: 0)
        if let lastIndexPath = lastIndexPath {
          if lastIndexPath.item == indexPath.item {
            lastInitialDisplayableCell = true
          }
        }
      }
    }else {
      if contactsArray.count > 0 && !finishedLoadingInitialTableCells {
        lastIndexPath = IndexPath(item: contactsArray.count - 1, section: 0)
        if let lastIndexPath = lastIndexPath {
          if lastIndexPath.item == indexPath.item {
            lastInitialDisplayableCell = true
          }
        }
      }
    }

    if !finishedLoadingInitialTableCells {
      if lastInitialDisplayableCell {
        finishedLoadingInitialTableCells = true
      }
      //animates the cell as it is being displayed for the first time
      cell.transform = CGAffineTransform(translationX: 0, y: 128 / 2)
      cell.alpha = 0
      
      UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.item), options: [.curveEaseInOut], animations: {
        cell.transform = CGAffineTransform(translationX: 0, y: 0)
        cell.alpha = 1
      }, completion: nil)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let contactsRoomVC = ContactsRoomViewController()
    if isFiltering {
      contactsRoomVC.roomName = self.filteredContactsArray[indexPath.item].title!
    }else {
      contactsRoomVC.roomName = self.contactsArray[indexPath.item].title!
    }
    navigationController?.pushViewController(contactsRoomVC, animated: true)
  }
}
