//
//  CountryFactsTableViewCell.swift
//  KnowYourCountry
//
//  Created by Deepti Gupta on 13/10/20.
//  Copyright © 2020 Deepti Gupta. All rights reserved.
//

import UIKit

class CountryFactsTableViewCell: UITableViewCell {
    
    let cellImageView:UIImageView = {
        let imgageView = UIImageView()
        imgageView.contentMode = .scaleAspectFill
        imgageView.translatesAutoresizingMaskIntoConstraints = false
        imgageView.clipsToBounds = true
        return imgageView
    }()

    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: CountryFactsTableViewCellContants.titleLabelFontSize)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = CountryFactsContants.zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CountryFactsTableViewCellContants.descriptionLabelFontSize)
        label.textColor =  .black
        label.clipsToBounds = true
        label.numberOfLines = CountryFactsContants.zero
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        cellImageView.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor).isActive = true
        cellImageView.topAnchor.constraint(greaterThanOrEqualTo: marginGuide.topAnchor).isActive = true
        cellImageView.centerYAnchor.constraint(equalTo:marginGuide.centerYAnchor).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant:CountryFactsTableViewCellContants.cellImageSize).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant:CountryFactsTableViewCellContants.cellImageSize).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: CountryFactsTableViewCellContants.padding).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: CountryFactsTableViewCellContants.padding).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
