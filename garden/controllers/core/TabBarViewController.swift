//
//  TabBarViewController.swift
//  template
//
//  Created by Михаил Исаченко on 23.05.2021.
//

import UIKit


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = ProfileViewController()
        
        
        vc1.title = "Афиша"
        vc2.title = "Мои команды"
        vc3.title = "Авторизация"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nc1 = UINavigationController(rootViewController: vc1)
        let nc2 = UINavigationController(rootViewController: vc2)
        let nc3 = UINavigationController(rootViewController: vc3)

        nc1.navigationBar.prefersLargeTitles = true
        nc2.navigationBar.prefersLargeTitles = true
        nc3.navigationBar.prefersLargeTitles = true
        
        
        
        nc2.tabBarItem = UITabBarItem(title: "Команды", image: UIImage(systemName: "person.3.fill"), tag: 1)
        nc1.tabBarItem = UITabBarItem(title: "Афиша", image: UIImage(systemName: "star.fill"), tag: 1)
        nc3.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 1)
        self.tabBar.tintColor = .black
        
        self.setViewControllers([nc1,nc2,nc3], animated: false)
        
    }


}
