//
//  SecondViewController.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import UIKit

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = PackageDetailWireFrame.createPackageDetailModule() as! PackageDetailViewController
        self.present(vc, animated: true)
    }
    
    func setupTabBarItem() {
        let unselectedImage = UIImage(systemName: "map")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(systemName: "map.fill")?.withRenderingMode(.alwaysTemplate)
        self.tabBarItem = UITabBarItem(title: MainTabBarControllerItems.explore.rawValue, image: unselectedImage, selectedImage: selectedImage)
    }
}
