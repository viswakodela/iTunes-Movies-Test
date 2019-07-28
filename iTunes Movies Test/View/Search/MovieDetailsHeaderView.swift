//
//  MovieDetailscell.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/27/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class MovieDetailsHeaderView: UICollectionReusableView {
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    // MARK:- Properties
    var movie: Movie? {
        didSet {
            movieName.text = movie?.trackName
            directorNameLabel.text = movie?.artistName
            priceLabel.text = "$\(movie?.trackPrice ?? 0.0)"
            genereLable.text = movie?.primaryGenreName
            if let imageURL = movie?.artworkUrl100, let url = URL(string: imageURL) {
                movieImageView.sd_setImage(with: url)
            }
        }
    }
    
    let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    let directorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 6
        return iv
    }()
    
    let genereLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Documentry"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    // MARK:- Helper Methods
    fileprivate func configureLayout() {
        let detailsStackView = UIStackView(arrangedSubviews: [movieName,
                                                              UIView(),
                                                              directorNameLabel,
                                                              UIView(),
                                                              genereLable,
                                                              UIView(),
                                                              priceLabel,
                                                              UIView()])
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 2
        
        let overallStackView = UIStackView(arrangedSubviews: [movieImageView, detailsStackView])
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.axis = .horizontal
        overallStackView.spacing = 10
        
        movieImageView.widthAnchor.constraint(equalTo: overallStackView.widthAnchor, multiplier: 0.4).isActive = true
        
        addSubview(overallStackView)
        overallStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        overallStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        overallStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        overallStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
