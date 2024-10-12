//
//  MainTabBar.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 05/01/23.
//

import UIKit

class MainTabBar: UITabBar {
    
    private let parentView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        parentView.roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.addSubview(parentView)
        parentView.backgroundColor = Theme.light.backGroundColor
        parentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            parentView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        tabViewConfig()
    }
    
    private func tabViewConfig() {
        if #available(iOS 10.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.shadowImage = nil
            tabBarAppearance.shadowColor = nil
            tabBarAppearance.backgroundColor = .clear
            UITabBar.appearance().standardAppearance = tabBarAppearance

            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
}
