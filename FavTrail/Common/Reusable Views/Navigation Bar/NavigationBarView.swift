//
//  NavigationBarView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 02/08/22.
//

import UIKit

protocol NavigationBarViewDelegate: AnyObject {
    func seachButtonTap()
}

class NavigationBarView: XibReusableViews {

    @IBOutlet weak private var navView: UIView!
    @IBOutlet weak private var navigationTitle: UILabel!
    @IBOutlet weak private var searchIcon: UIImageView!
    
    weak var delegate: NavigationBarViewDelegate?
    
    override func prepareForInterfaceBuilder() {
    }
    
    func configure(with delegate: NavigationBarViewDelegate) {
        self.delegate = delegate
    }
    
    func setupView() {
        navView.backgroundColor = Theme.light.backGroundColor
        navigationTitle.text = "FavTrail"
        navigationTitle.font = UIFont.poppinsSemiBold(size: 25)
        
        searchIcon.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onSearchTapped))
        searchIcon.addGestureRecognizer(gesture)
    }
    
    @objc private func onSearchTapped() {
        delegate?.seachButtonTap()
    }
    
    override func customInit() {
        super.customInit()
        setupView()
    }
}
