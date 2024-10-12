//
//  TrendingTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/08/22.
//

import UIKit

protocol GenericHomeFullCardClickDelegate: AnyObject {
    func onCardClick(blogId: String)
}

class NearbyTravelTVC: UITableViewCell {
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var model: HomeGenericObjectModel?
    weak var delegate: GenericHomeFullCardClickDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        
        collectionView.register(UINib(nibName: HomeFeedNearbyCVC.identifier, bundle: .main), forCellWithReuseIdentifier: HomeFeedNearbyCVC.identifier)
        
    }
    
    func configure(model: HomeGenericObjectModel) {
        self.model = model
        self.title.attributedText = model.title.getAttributedString()
        self.title.font = UIFont.poppinsMedium(size: 15)
        collectionViewHeightConstraint.constant = 160
        collectionView.reloadData()
    }
}

extension NearbyTravelTVC: CollectionViewMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemInSection indexPath: Int) -> Int {
        return model?.objects.count ?? 0
    }
}

extension NearbyTravelTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionViewHeightConstraint.constant)
    }
}

extension NearbyTravelTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.objects.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = model else { return UICollectionViewCell() }
        
        guard let cellModel = model.objects[indexPath.row] as? NearbyTravelContentModel, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedNearbyCVC.identifier, for: indexPath) as? HomeFeedNearbyCVC else { return UICollectionViewCell() }
        cell.configureCell(model: cellModel)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = model?.objects[indexPath.row] as? NearbyTravelContentModel else { return }
        delegate?.onCardClick(blogId: cellModel.id)
    }
}

