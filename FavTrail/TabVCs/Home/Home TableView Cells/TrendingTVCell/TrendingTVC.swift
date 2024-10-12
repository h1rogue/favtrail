//
//  TrendingTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/08/22.
//

import UIKit

class TrendingTVC: UITableViewCell {
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
        
        collectionView.register(UINib(nibName: HomeFeedImagesCVC.identifier, bundle: .main), forCellWithReuseIdentifier: HomeFeedImagesCVC.identifier)
    }
    
    func configure(model: HomeGenericObjectModel) {
        self.model = model
        self.title.attributedText = model.title.getAttributedString()
        self.title.font = UIFont.poppinsMedium(size: 15)
        collectionViewHeightConstraint.constant = 220
        collectionView.reloadData()
    }
}

extension TrendingTVC: CollectionViewMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemInSection indexPath: Int) -> Int {
        return model?.objects.count ?? 0
    }
}

extension TrendingTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width*0.4, height: collectionViewHeightConstraint.constant)
        } else {
            let rowSpacing: CGFloat = 5.0
            let cellDimension: CGFloat = collectionViewHeightConstraint.constant/2 - rowSpacing/2
            return CGSize(width: cellDimension, height: cellDimension)
        }
        
    }
}

extension TrendingTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.objects.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = model else { return UICollectionViewCell() }
        
        guard let cellModel = model.objects[indexPath.row] as? TrendingContentModel, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedImagesCVC.identifier, for: indexPath) as? HomeFeedImagesCVC else { return UICollectionViewCell() }
        cell.configureCell(model: cellModel)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = model?.objects[indexPath.row] as? TrendingContentModel else { return }
        delegate?.onCardClick(blogId: cellModel.id)
    }
}
