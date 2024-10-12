//
//  PTDItineraryCabView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/01/23.
//

import UIKit

class PTDItineraryCabView: UIView {
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var subtitle: UILabel!
    @IBOutlet weak private var otherDetailTitle: UILabel!
    @IBOutlet weak private var otherDetailSubtitle: UILabel!
    
    private func setupView() {
        self.title.font = UIFont.poppinsMedium(size: 14)
        self.subtitle.font = UIFont.poppinsMedium(size: 12)
        self.otherDetailTitle.font = UIFont.poppinsMedium(size: 10)
        self.otherDetailSubtitle.font = UIFont.poppinsMedium(size: 10)
    }
    
    func configure(model: CabItineraryDataModel) {
        setupView()
        
        self.title.attributedText = model.dateTime.getAttributedString()
        self.subtitle.attributedText = model.subtitle.getAttributedString()
        self.otherDetailTitle.attributedText = model.vehicleTypeText.getAttributedString()
        self.otherDetailSubtitle.attributedText = model.vehicleType?.getAttributedString()
    }
}
