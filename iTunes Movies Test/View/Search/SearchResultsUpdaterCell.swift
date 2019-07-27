//
//  SearchResultsUpdaterCell.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class SearchResultsUpdaterCell: UICollectionViewCell {
    
    // MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    // MARK:- Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradiantLayer.frame = self.bounds
    }
    
    // MARK:- Properties
    var gradiantLayer: CAGradientLayer!
    var movie: Movie? {
        didSet {
            moviewName.text = movie?.trackName
            let dateFormatter = DateFormatter()
            if let releaseYear = movie?.releaseDate {
                if let date = dateFormatter.getRealDate(date: releaseYear) {
                    self.movieReleaseYear.text = date
                }
            }
            
            if let imageURL = URL(string: movie?.artworkUrl100 ?? "") {
                movieImageView.sd_setImage(with: imageURL)
//                movieImageView.sd_setImage(with: imageURL) { (image, err, _, _) in
//                    let image = self.resizeImageWithAspect(image: image ?? UIImage(), scaledToMaxWidth: self.bounds.width, maxHeight: 200)
//                    self.movieImageView.image = image
//                }
            }
        }
    }
    
    private let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let moviewName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private let movieReleaseYear: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    // MARK:- Helper Methods
    private func configureLayout() {
        
        
        addSubview(movieImageView)
        movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
        setupGradiant()
        
        let overAllStackView = UIStackView(arrangedSubviews: [moviewName,
                                                              movieReleaseYear,
                                                              UIView()])
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        overAllStackView.spacing = 5
        overAllStackView.axis = .vertical
        
        movieImageView.addSubview(overAllStackView)
        overAllStackView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor).isActive = true
        overAllStackView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 4).isActive = true
        overAllStackView.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -2).isActive = true
        
    }
    
    private func setupGradiant() {
        
        self.gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradiantLayer.locations = [0.5, 1]
        self.movieImageView.layer.addSublayer(gradiantLayer)
    }
    
    func resizeImageWithAspect(image: UIImage,scaledToMaxWidth width:CGFloat,maxHeight height :CGFloat)->UIImage? {
        let oldWidth = image.size.width;
        let oldHeight = image.size.height;
        
        let scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
        
        let newHeight = oldHeight * scaleFactor;
        let newWidth = oldWidth * scaleFactor;
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize,false,UIScreen.main.scale);
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DateFormatter {
    func getRealDate(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        newDateFormatter.dateFormat = "MMM d, yyyy"
        if let date = dateFormatter.date(from: date) {
            let realDate = newDateFormatter.string(from: date)
            return realDate
        } else {
            return nil
        }
    }
}
