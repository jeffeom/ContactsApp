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
  static let cellCustomHeight: CGFloat = 128
  static let identifier = "CardCollectionViewCell"
  
  var cellType: CardThemeType = .blueyGrey
  
  let titleLabel = UILabel()
  let subTitleLabel = UILabel()
  let numberOfPeopleLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCellView()
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
    
    contentView.layer.cornerRadius = 20
    contentView.clipsToBounds = true
    
    titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
    titleLabel.textColor = cellType.titleLabelColor()
    
    subTitleLabel.font = UIFont.systemFont(ofSize: 18.0, weight: .medium)
    subTitleLabel.textColor = cellType.subtitleColor()
    
    let titleStackView = UIStackView()
    titleStackView.translatesAutoresizingMaskIntoConstraints = false
    titleStackView.addArrangedSubview(titleLabel)
    titleStackView.addArrangedSubview(subTitleLabel)
    titleStackView.alignment = .leading
    titleStackView.distribution = .equalSpacing
    titleStackView.axis = .vertical
    
    let numberLabelStackView = UIStackView()
    let personImageView = UIImageView(image: UIImage(named: "user_icon_black"))
    numberOfPeopleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    numberOfPeopleLabel.textColor = cellType.numberLabelColor()

    numberLabelStackView.addArrangedSubview(personImageView)
    numberLabelStackView.addArrangedSubview(numberOfPeopleLabel)
    numberLabelStackView.alignment = .center
    numberLabelStackView.distribution = .equalSpacing
    numberLabelStackView.axis = .horizontal
    numberLabelStackView.spacing = 5
    
    let cellStackView = UIStackView()
    cellStackView.translatesAutoresizingMaskIntoConstraints = false
    cellStackView.addArrangedSubview(titleStackView)
    cellStackView.addArrangedSubview(numberLabelStackView)
    cellStackView.alignment = .trailing
    cellStackView.distribution = .equalSpacing
    cellStackView.axis = .vertical
    
    titleStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 1.0).isActive = true
    
    contentView.addSubview(cellStackView)
    cellStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    cellStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    cellStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.0, constant: -50).isActive = true
    cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21.0).isActive = true
    cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13.0).isActive = true
  }
}
