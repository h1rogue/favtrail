//
//  RatingStarBarView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 20/04/23.
//

import UIKit

class RatingStarBarView: UIView {
    
    let defaultNumberOfStars: Int = 5
    let defaultImageWidth: Double = 15.0
    
    @IBOutlet weak private var stackView: UIStackView!
    
    let unFilledStarImageName: String = "star"
    let halfFillStarImageName: String = "star.leadinghalf.filled"
    let filledStarImageName: String = "star.fill"
    
    func configure(rating: Double) {
        stackView.removeAllSubviews()
        
        //add image view
        let totalFilledStars: Int = Int(rating)
        let halfFilledStars: Int = rating.rounded() == rating ? 0 : 1
        let unFilledStars: Int = defaultNumberOfStars - (totalFilledStars + halfFilledStars)
        
        addStars(count: totalFilledStars, imageName: filledStarImageName, stackView: stackView)
        addStars(count: halfFilledStars, imageName: halfFillStarImageName, stackView: stackView)
        addStars(count: unFilledStars, imageName: unFilledStarImageName, stackView: stackView)
    }
    
   private func addStars(count: Int, imageName: String, stackView: UIStackView) {
        for _ in 0..<count {
            let image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
            let imageView = UIImageView(image: image)
            imageView.tintColor = Theme.light.backGroundColor
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: defaultImageWidth).isActive = true
            
            stackView.addArrangedSubview(imageView)
        }
    }
}
