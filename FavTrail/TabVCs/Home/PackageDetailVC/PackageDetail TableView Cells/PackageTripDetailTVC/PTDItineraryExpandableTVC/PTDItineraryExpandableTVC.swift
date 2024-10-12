//
//  PTDItineraryExpandedTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/01/23.
//

import UIKit

protocol PTDItineraryExpandedTVCDelegate: AnyObject {
    func onClickExpandableView(index: Int)
}

class PTDItineraryExpandedTVC: UIView {
    
    @IBOutlet weak private var verticalStackView: UIStackView!
    @IBOutlet weak private var topIconImage: UIImageView!
    @IBOutlet weak private var topHeaderLabel: UILabel!
    @IBOutlet weak private var topView: UIView!
    @IBOutlet weak private var bottomView: UIView!
    @IBOutlet weak private var bottomParentView: UIView!
    
    private var model: TripItineraryCardModel?
    weak var delegate: PTDItineraryExpandedTVCDelegate?
    private var index: Int = 0
    private var expandableView: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topView.addDefaultCornerRadius()
        self.bottomView.addShadowToView()
    }
    
    private func setupViews() {
        self.topHeaderLabel.font = UIFont.poppinsMedium(size: 14)
        topView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(topBarClicked))
        topView.addGestureRecognizer(gesture)
    }
    
    @objc private func topBarClicked() {

            let isViewExpanded = model?.data?.isViewExpanded ?? false
            model?.data?.isViewExpanded = !isViewExpanded
            delegate?.onClickExpandableView(index: index)

    }
    
    func configure(model: TripItineraryCardModel, delegate: PTDItineraryExpandedTVCDelegate, index: Int) {
        self.model = model
        self.delegate = delegate
        self.index = index
        self.topHeaderLabel.attributedText = model.title.getAttributedString()
        
        setupViews()
        
        switch model.type {
        case .cab:
            if let model = model.data as? CabItineraryDataModel {
                setupBottomCabView(with: model)
            }
        case .flight, .hotel:
            break
        }
        
    }
    
    private func setupBottomCabView(with itemModel: CabItineraryDataModel) {
        
        if let expandableView = expandableView as? PTDItineraryCabView {
            expandableView.configure(model: itemModel)
        } else {
            let view = PTDItineraryCabView.instantiateFromNib(.main)
            bottomView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
                view.topAnchor.constraint(equalTo: bottomView.topAnchor),
                view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
            ])
            
            view.configure(model: itemModel)
        }
        self.bottomView.layer.masksToBounds = false
        self.bottomView.isHidden = !itemModel.isViewExpanded
        self.bottomParentView.isHidden = !itemModel.isViewExpanded
    }
}
