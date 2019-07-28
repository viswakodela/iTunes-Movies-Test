//
//  MainController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/24/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import SystemConfiguration

extension Notification.Name {
    static let networkAvailabilityNotification = Notification.Name("networkAvailabilityNotification")
}

class MainController: UICollectionViewController {
    
    // MARK:- Init
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    
    // MARK: - Properties
    let mainCellID = "mainCellID"
    var groups = [MovieGroup]()
    
    private var dispatchGroup: DispatchGroup!
    
    private var offset = 0
    private var limit = 20
    
    
    // MARK:-  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(obserNetworkAvailableOrNot), name: .networkAvailabilityNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(obserNetworkAvailableOrNot), name: .networkAvailabilityNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if connectedToNetworkorNot() {
            NotificationCenter.default.post(name: .networkAvailabilityNotification, object: self, userInfo: ["networkAvailability" : true])
        } else {
            NotificationCenter.default.post(name: .networkAvailabilityNotification, object: self, userInfo: ["networkAvailability" : false])
        }
    }
    
    // MARK:- Helper Methods
    func configureLayout() {
        
        view.backgroundColor = .white
        
        let networkLabel = UILabel()
        networkLabel.translatesAutoresizingMaskIntoConstraints = false
        networkLabel.text = "Network not Available..."
        networkLabel.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        networkLabel.numberOfLines = 0
        
        view.insertSubview(networkLabel, belowSubview: collectionView)
        
        if connectedToNetworkorNot() {
            collectionView.isHidden = false
            networkLabel.isHidden = true
        } else {
            collectionView.isHidden = true
            networkLabel.isHidden = false
        }
        
        networkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        networkLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        collectionView.allowsSelection = false
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: mainCellID)
        
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /** Call this method to fetch the different groups of Movies eg: Documentary, Action..
     */
    func fetchGroupedMovies() {
        
        self.dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIService.shared.fetchGroupedMovies(withUrl: NetworkURLs.groupedDocumentaryURL.rawValue) { [weak self] (movieGroups, err) in
            guard let self = self else {return}
            self.dispatchGroup.leave()
            if let error = err {
                // TODO:- Show Error
                print(error.localizedDescription)
                return
            }
            guard let documentryGroup = movieGroups else {return}
            self.groups.append(documentryGroup)
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchGroupedMovies(withUrl: NetworkURLs.groupedActionandAdventureMovieURL.rawValue) { [weak self] (actionGroup, err) in
            guard let self = self else {return}
            self.dispatchGroup.leave()
            if let error = err {
                // TODO:- Show Alert
                print(error.localizedDescription)
                return
            }
            guard let actionGroup = actionGroup else {return}
            self.groups.append(actionGroup)
        }
        
        dispatchGroup.enter()
        APIService.shared.fetchGroupedMovies(withUrl: NetworkURLs.groupedTVShowsURL.rawValue) { [weak self] (tvShows, err) in
            guard let self = self else {return}
            self.dispatchGroup.leave()
            if let error = err {
                // TODO:- Show Alert
                print(error.localizedDescription)
                return
            }
            guard let tvShows = tvShows else {return}
            self.groups.append(tvShows)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- Used this reference --> https://stackoverflow.com/questions/25623272/how-to-use-scnetworkreachability-in-swift
    func connectedToNetworkorNot() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        
        return (isReachable && !needsConnection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK:- CollectionView Delegate and DataSource Methods
extension MainController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellID, for: indexPath) as! MainViewCell
        let genre = self.groups[indexPath.row].feed.results.first?.genres.first?.name
        cell.titleLabel.text = "\(genre ?? "")"
        cell.groupedCollectionView.movieGroup = self.groups[indexPath.row]
        cell.groupedCollectionView.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 300
        let width = view.frame.width - 10
        return CGSize(width: width, height: height)
    }
}

// MARK:- Action Methods
extension MainController {
    @objc func obserNetworkAvailableOrNot(notification: Notification) {
        let userInfo = notification.userInfo as! [String : Any]
        let isNetworkAvailable = userInfo["networkAvailability"] as! Bool
        
        self.groups.removeAll()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        if isNetworkAvailable {
            configureLayout()
            configureNavigationBar()
            fetchGroupedMovies()
        } else {
            configureLayout()
            configureNavigationBar()
            print("Wi-Fi not Available...")
        }
    }
}

