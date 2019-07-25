//
//  GroupedCollectionViewCell.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit


class GroupedCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    // MARK:- Properties
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    // MARK:- Helper Methods
    func configureUI() {
        let stackView = UIStackView(arrangedSubviews: [movieImageView, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
