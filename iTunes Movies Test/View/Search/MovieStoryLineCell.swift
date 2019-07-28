//
//  MovieStoryLineCell.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/27/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MovieStoryLineCell: UICollectionViewCell {
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    // MARK:- Properties
    var movie: Movie? {
        didSet {
            storyLineDescriptionLabel.text = movie?.shortDescription ?? "N/A"
            detailedDescriptionLabel.text = movie?.longDescription
        }
    }
    
    let storyLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Story line"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let storyLineDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detailed Description"
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    let detailedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK:- Helper Methods
    fileprivate func configureLayout() {
        let storyLineStackView = UIStackView(arrangedSubviews: [storyLineLabel, storyLineDescriptionLabel])
        storyLineStackView.axis = .vertical
        storyLineStackView.spacing = 20
        
        let detailStackView = UIStackView(arrangedSubviews: [descriptionLabel, detailedDescriptionLabel])
        detailStackView.axis = .vertical
        detailStackView.spacing = 20
        
        let overallStackView = UIStackView(arrangedSubviews: [storyLineStackView, detailStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .vertical
        overallStackView.spacing = 20
        
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
