//
//  SnapToNearestCellLayout.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 05/10/22.
//

import UIKit
//https://stackoverflow.com/a/43637969/10771606
class SnapToNearestCellLayout: UICollectionViewFlowLayout {
    
    var defaultThresholdVelocity: CGFloat = 0.4
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let cv = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)}
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + cv.contentInset.left
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: cv.bounds.size.width, height: cv.bounds.size.height)
        
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
        
        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })
        
        /* TODO: Make more generalised and clean; assuming there are just two elements in targetRect */
        
        if abs(velocity.x) > defaultThresholdVelocity {
            if velocity.x > 0 {
                return CGPoint(x: layoutAttributesArray?.last?.frame.origin.x ?? .zero, y: proposedContentOffset.y)
            } else {
                return CGPoint(x: layoutAttributesArray?.first?.frame.origin.x ?? .zero, y: proposedContentOffset.y)
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
