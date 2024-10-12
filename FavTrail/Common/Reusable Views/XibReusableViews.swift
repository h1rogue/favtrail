//
//  XibReusableViews.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 06/08/22.
//

import UIKit

class XibReusableViews: UIView {
    
    @IBOutlet weak private var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        Bundle.main.loadNibNamed(Self.identifier, owner: self)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
