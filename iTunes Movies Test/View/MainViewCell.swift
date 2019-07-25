//
//  MainViewCell.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    // MARK:- Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    // MARK:- Properties
    var groupedCollectionView: GroupedCollectionView!
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    // MARK:- Helper Methods
    func configureLayout() {
        groupedCollectionView = GroupedCollectionView()
        guard let horizontalGroupedView = groupedCollectionView.view else {return}
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, horizontalGroupedView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
