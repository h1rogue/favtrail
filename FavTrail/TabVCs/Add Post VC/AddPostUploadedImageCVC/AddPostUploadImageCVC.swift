//
//  AddPostUploadImageCVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 10/10/22.
//

import UIKit

protocol AddPostUploadImageCVCDelegate: AnyObject {
    func crossButtonClicked(indexPath: IndexPath)
}

class AddPostUploadImageCVC: UICollectionViewCell {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var crossButtonView: UIView!
    @IBOutlet weak private var shadowView: UIView!
    
    weak var delegate: AddPostUploadImageCVCDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.crossButtonView.addDefaultCornerRadius(crossButtonView.frame.width/2.0)
        self.imageView.addDefaultCornerRadius(8)
        self.shadowView.addDefaultCornerRadius(8)
    }
    
    @IBAction func onCrossButtonClicked(_ sender: Any) {
        if let indexPath = indexPath {
            delegate?.crossButtonClicked(indexPath: indexPath)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.indexPath = nil
    }
    
    func configureView(imgView: UIImage, indexPath: IndexPath) {
        self.imageView.image = imgView
        self.indexPath = indexPath
    }
}
