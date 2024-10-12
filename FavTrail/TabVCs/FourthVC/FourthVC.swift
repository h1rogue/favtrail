//
//  FourthVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import UIKit

class FourthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
    }
    
    func setupTabBarItem() {
        self.tabBarItem = UITabBarItem(title: MainTabBarControllerItems.fourth.rawValue, image: nil, selectedImage: nil)
    }
}
