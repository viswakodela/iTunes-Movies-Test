//
//  TabBarController.swift
//  iTunes Movies Test
//
//  Created by Viswa Kodela on 7/26/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK:- Init
    
    
    
    // MARK:- Properies
    
    
    // MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK:- Helper Methods
    private func configureTabBar() {
        let mainController = self.setNavBar(for: MainController(), withTitle: "Movies", withTabBarImage: UIImage(systemName: "film"))
        let searchController = self.setNavBar(for: SearchViewController(searchResultsUpdater: SearchResultsUpdater()), withTitle: "Search", withTabBarImage: UIImage(systemName: "magnifyingglass"))
        
        viewControllers = [mainController, searchController]
    }
    
    private func setNavBar(for viewController: UIViewController, withTitle title: String, withTabBarImage image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = title
        
        return navController
    }
    
}
