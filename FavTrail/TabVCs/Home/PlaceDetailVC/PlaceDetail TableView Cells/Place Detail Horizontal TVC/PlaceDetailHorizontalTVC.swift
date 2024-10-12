//
//  PlaceDetailHorizontalTVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import UIKit

class PlaceDetailHorizontalTVC: UITableViewCell {

    @IBOutlet weak private var headerLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var cvHeightConstraint: NSLayoutConstraint!
    
    var model: HomeGenericObjectModel?
    weak var delegate: GenericHomeFullCardClickDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headerLabel.font = UIFont.poppinsMedium(size: 15)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        
        collectionView.register(UINib(nibName: PlaceDetailHorizontalCVC.identifier, bundle: .main), forCellWithReuseIdentifier: PlaceDetailHorizontalCVC.identifier)
    }
    
    func configure(model: HomeGenericObjectModel) {
        self.model = model
        self.headerLabel.attributedText = model.title.getAttributedString()
        cvHeightConstraint.constant = 160
        collectionView.reloadData()
    }
    
}

extension PlaceDetailHorizontalTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.objects.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = model, let cellModel = getCellModel(model: model, indexPath: indexPath), let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceDetailHorizontalCVC.identifier, for: indexPath) as? PlaceDetailHorizontalCVC else { return UICollectionViewCell() }
        cell.configure(model: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: cvHeightConstraint.constant)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    private func getCellModel(model: HomeGenericObjectModel, indexPath: IndexPath) -> PDHorizontalCardModel? {
        switch model.type {
        case .cafePDCard:
            if let cellModel = model.objects[indexPath.row] as? PDCafeModel {
                return PDHorizontalCardModel(title: cellModel.title, subtitle: cellModel.subtitle, image: cellModel.imgUrl)
            }
        case .resortStay:
            if let cellModel = model.objects[indexPath.row] as? PDResortStayModel {
                return PDHorizontalCardModel(title: cellModel.title, subtitle: cellModel.subtitle, image: cellModel.imgUrl)
            }
        case .similarTripModel:
            if let cellModel = model.objects[indexPath.row] as? SimilarTripModel {
                return PDHorizontalCardModel(title: cellModel.title, subtitle: cellModel.subtitle, image: cellModel.image)
            }
        default:
            break
        }
        return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellModel = model?.objects[indexPath.row] as? ContentModelObject else { return }
        delegate?.onCardClick(blogId: cellModel.id)
    }
}
