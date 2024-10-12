//
//  BlogPostView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 06/08/22.
//

import UIKit

protocol BlogPostViewDelegate: AnyObject {
    func didTapView(itemIndex: Int)
}

class BlogPostView: UIView {
    @IBOutlet weak private var blogDetailStackView: UIStackView!
    @IBOutlet weak private var blogBodyText: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var cvHeightConstraint: NSLayoutConstraint!
    var model: UserFeedDataModel?
    var sizeDict: [Int:CGSize] = [:]
    
    weak var delegate: BlogPostViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //setup collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ImageContentCVC.identifier, bundle: .main), forCellWithReuseIdentifier: ImageContentCVC.identifier)
    }
    
    private func configureVisualContent(_ images: [String]) {
        let count = min(3,images.count)
        for index in 0..<count {
            switch index {
            case 0:
                if count > 1 {
                    sizeDict[0] = CGSize(width: collectionView.frame.width/2, height: cvHeightConstraint.constant)
                } else {
                    sizeDict[0] = CGSize(width: collectionView.frame.width, height: cvHeightConstraint.constant)
                }
            case 1:
                if count > 2 {
                    sizeDict[1] = CGSize(width: collectionView.frame.width/2, height: cvHeightConstraint.constant/2 - 1)
                } else {
                    sizeDict[1] = CGSize(width: collectionView.frame.width/2, height: cvHeightConstraint.constant)
                }
            case 2:
                sizeDict[2] = CGSize(width: collectionView.frame.width/2, height: cvHeightConstraint.constant/2 - 1)
            default:
                break
            }
        }
    }
    
    func getCollectionViewFrame() -> CGRect {
        return collectionView.frame
    }
    
    private func addTitleSubtitleView(_ model: UserFeedDataModel) {
        guard let view = ReusableView.titleSubtitleView.instantiateView() as? TitleSubTitleView else { return }
        view.configureView(title: model.title, subTitle: model.subTitle)
        blogDetailStackView.removeAllArrangedStackView()
        blogDetailStackView.addArrangedSubview(view)
    }
    
    func configureView(model: UserFeedDataModel) {
        addTitleSubtitleView(model)
        self.model = model
        self.blogBodyText.attributedText = model.body?.getAttributedString()
        if model.images == nil {
            cvHeightConstraint.constant = 0
            layoutIfNeeded()
        }
    }
}

extension BlogPostView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeDict[indexPath.row] ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

extension BlogPostView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        configureVisualContent(model?.images ?? [])
        return min(3, model?.images?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageContentCVC.identifier, for: indexPath) as? ImageContentCVC, let imageUrl = model?.images?[indexPath.row], let imageCount = model?.images?.count {
            if indexPath.row == 2 && imageCount > 3 {
                cell.configure(imageUrl: imageUrl, showImageCount: imageCount-3)
            } else {
                cell.configure(imageUrl: imageUrl)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapView(itemIndex: indexPath.row)
    }
}
