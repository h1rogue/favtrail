//
//  ViewController.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        UITabBar.appearance().tintColor = Theme.light.tabItemColor
        UITabBar.appearance().unselectedItemTintColor = Theme.light.tabItemColor
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
            
            appearance.stackedLayoutAppearance.normal.iconColor =  Theme.light.tabItemColor
            appearance.stackedLayoutAppearance.selected.iconColor = Theme.light.tabItemColor
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setupViewControllers() {
        let homeVC = getHomeVC()
        homeVC.setupTabBarItem()
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeNavController.navigationBar.isHidden = true
        
        let secondVC = SecondVC()
        secondVC.setupTabBarItem()
        
        let addPostVC = getAddPostVC()
        addPostVC.setupTabBarItem()
        let addPostNavController = UINavigationController(rootViewController: addPostVC)
        
        let fourthVC = FourthVC()
        fourthVC.setupTabBarItem()
        
        let fifthVC = FifthVC()
        fifthVC.setupTabBarItem()
        
        self.viewControllers = [homeNavController, secondVC, addPostNavController, fourthVC, fifthVC]
    }
    
    private func getHomeVC() -> HomeVC {
        let vc = HomeWireFrame.createHomeViewModule() as! HomeVC 
        return vc
    }
    
    private func getAddPostVC() -> AddPostVC {
        let storyBord = UIStoryboard.init(name: "Main", bundle: .main)
        let view = storyBord.instantiateViewController(withIdentifier: "AddPostVC") as! AddPostVC
        
        let vm = AddPostVM()
        view.initVM(viewModel: vm)
        return view
    }
    
    private func getPackageDetailVC() -> PackageDetailViewController {
        let vc = PackageDetailWireFrame.createPackageDetailModule() as! PackageDetailViewController
        return vc
    }
}

