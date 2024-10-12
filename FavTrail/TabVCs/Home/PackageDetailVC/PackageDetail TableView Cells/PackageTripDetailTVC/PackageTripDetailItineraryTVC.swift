//
//  PackageTripDetailItineraryTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/01/23.
//

import UIKit

protocol PackageTripDetailItineraryTVCDelegate: AnyObject {
    func reloadTableViewCell(indexPath: IndexPath)
}
class PackageTripDetailItineraryTVC: UITableViewCell {

    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var stackVIew: UIStackView!
    
    private var indexPath: IndexPath!
    weak var delegate: PackageTripDetailItineraryTVCDelegate?
    
    private var model: HomeGenericObjectModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackVIew.removeAllSubviews()
    }
    
    private func setupViews() {
        self.title.font = UIFont.poppinsMedium(size: 12)
    }
    
    func configure(model: HomeGenericObjectModel, indexPath: IndexPath) {
        self.title.attributedText = model.title.getAttributedString()
        self.model = model
        self.indexPath = indexPath
        setupStackViewItems()
    }
    
    private func setupStackViewItems() {
        stackVIew.removeAllSubviews()
        if let objects = model?.objects as? [TripItineraryCardModel] {
            for index in 0..<objects.count {
                let itineraryView = PTDItineraryExpandedTVC.instantiateFromNib(.main)
                itineraryView.configure(model: objects[index], delegate: self, index: index)
                stackVIew.addArrangedSubview(itineraryView)
            }
        }
    }
}

extension PackageTripDetailItineraryTVC: PTDItineraryExpandedTVCDelegate {
    func onClickExpandableView(index: Int) {
        delegate?.reloadTableViewCell(indexPath: indexPath)
    }
}
