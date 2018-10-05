//
//  CardCollectionViewCell.swift
//  ContactsApp
//
//  Created by Jeff Eom on 2018-10-04.
//  Copyright © 2018 Jeff Eom. All rights reserved.
//

import UIKit

enum CardThemeType {
  case lightTeal
  case charcoalGrey
  case blueyGrey
  
  func backgroundColor() -> UIColor {
    switch self {
    case .lightTeal:
      return .lightTeal()
    case .charcoalGrey:
      return .charcoalGrey()
    case .blueyGrey:
      return .blueyGrey()
    }
  }
  
  func titleLabelColor() -> UIColor {
    switch self {
    case .lightTeal:
      return .white
    case .charcoalGrey:
      return .lightTeal()
    case .blueyGrey:
      return .charcoalGrey()
    }
  }
  
  func subtitleColor() -> UIColor {
    switch self {
    case .lightTeal:
      return .charcoalGrey()
    case .charcoalGrey:
      return .white
    case .blueyGrey:
      return .white
    }
  }
  
  func numberLabelColor() -> UIColor {
    switch self {
    case .lightTeal:
      return .charcoalGrey()
    case .charcoalGrey:
      return .white
    case .blueyGrey:
      return .white
    }
  }
}

class CardCollectionViewCell: UICollectionViewCell {
  static let cellCustomHeight = 128
  static let identifier = "CardCollectionViewCell"
  
  var cellType: CardThemeType = .blueyGrey
  var title = ""
  var subtitle = ""
  var numberOfPeople = ""
  
  override func awakeFromNib() {
    super.awakeFromNib()
    translatesAutoresizingMaskIntoConstraints = false
    setupCellView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARK: Setup
extension CardCollectionViewCell {
  func setupCellView() {
    backgroundColor = .clear
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 0)
    layer.shadowOpacity = 0.25
    layer.shadowRadius = 2
    
    let cellView = UIView(frame: self.frame)
    cellView.backgroundColor = cellType.backgroundColor()
    cellView.layer.cornerRadius = 20
    cellView.clipsToBounds = true
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width * 0.9, height: 35))
    titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
    titleLabel.textColor = cellType.titleLabelColor()
    titleLabel.text = title
    
    let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width * 0.9, height: 21))
    subTitleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    subTitleLabel.textColor = cellType.subtitleColor()
    subTitleLabel.text = subtitle
    
    let titleStackView = UIStackView(frame:  CGRect(x: 0, y: 0, width: self.bounds.width * 0.9, height: 60))
    titleStackView.addArrangedSubview(titleLabel)
    titleStackView.addArrangedSubview(subTitleLabel)
    titleStackView.alignment = .center
    titleStackView.distribution = .equalSpacing
    titleStackView.axis = .vertical
    
    let numberLabelStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 40, height: 35))
    let personImageView = UIImageView(image: UIImage(named: "user_icon_black"))
    let numberOfPeopleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 23, height: 21))
    numberOfPeopleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    numberOfPeopleLabel.textColor = cellType.numberLabelColor()
    numberOfPeopleLabel.text = numberOfPeople
    numberLabelStackView.addArrangedSubview(personImageView)
    numberLabelStackView.addArrangedSubview(numberOfPeopleLabel)
    numberLabelStackView.alignment = .center
    numberLabelStackView.distribution = .equalSpacing
    numberLabelStackView.axis = .horizontal
    
    let cellStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.bounds.width - 50, height: self.bounds.height - 33))
    cellStackView.addArrangedSubview(titleStackView)
    cellStackView.addArrangedSubview(numberLabelStackView)
    cellStackView.alignment = .center
    cellStackView.distribution = .equalSpacing
    cellStackView.axis = .vertical
    
    cellView.addSubview(cellStackView)
    cellStackView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor)
    cellStackView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
    self.addSubview(cellView)
  }
}
