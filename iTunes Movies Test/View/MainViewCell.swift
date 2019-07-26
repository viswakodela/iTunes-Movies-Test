//
//  MainViewCell.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MainViewCell: UICollectionViewCell {
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    // MARK:- Properties
    var groupedCollectionView: GroupedCollectionView!
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    // MARK:- Helper Methods
    func configureLayout() {
        groupedCollectionView = GroupedCollectionView()
        guard let horizontalGroupedView = groupedCollectionView.view else {return}
        horizontalGroupedView.translatesAutoresizingMaskIntoConstraints = false
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(white: 0.9, alpha: 0.7)
        
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, horizontalGroupedView, seperatorView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
