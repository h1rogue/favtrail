//
//  RecentUpdatesTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 28/08/22.
//

import UIKit

class RecentUpdatesTVC: UITableViewCell {
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
        
        collectionView.register(UINib(nibName: RecentUpdatesCVC.identifier, bundle: .main), forCellWithReuseIdentifier: RecentUpdatesCVC.identifier)
        
    }
    
    func configure(model: HomeGenericObjectModel) {
        self.model = model
        self.title.attributedText = model.title.getAttributedString()
        self.title.font = UIFont.poppinsMedium(size: 15)
        collectionViewHeightConstraint.constant = 160
        collectionView.reloadData()
    }
}

extension RecentUpdatesTVC: CollectionViewMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemInSection indexPath: Int) -> Int {
        return model?.objects.count ?? 0
    }
}

extension RecentUpdatesTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width*0.35, height: collectionViewHeightConstraint.constant)
    }
}

extension RecentUpdatesTVC: UICollectionViewDataSource, UICollectionViewDelegate {
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
        
        guard let model = model, let cellModel = model.objects[indexPath.row] as? RecentUpdateContentModel, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentUpdatesCVC.identifier, for: indexPath) as? RecentUpdatesCVC else { return UICollectionViewCell() }
        cell.configureCell(model: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = model?.objects[indexPath.row] as? RecentUpdateContentModel else { return }
        delegate?.onCardClick(blogId: cellModel.id)
    }
}
