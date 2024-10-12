//
//  CollectionViewMosaicLayout.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 08/08/22.
//

import UIKit

protocol CollectionViewMosaicLayoutDelegate: AnyObject {
      func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemInSection indexPath: Int) -> Int
}

class CollectionViewMosaicLayout: UICollectionViewLayout {

    weak var delegate: CollectionViewMosaicLayoutDelegate?
    var cache: [UICollectionViewLayoutAttributes] = []
    
    var columnSpacing: CGFloat = 5
    var rowSpacing: CGFloat = 5
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat = 260 // height of
    
    var currRow: Int = 0
    
    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        
        let count = delegate?.collectionView(collectionView, numberOfItemInSection: 0) ?? 0
        var currIndex = 0
        var xOffset: [CGFloat] = [0,0]
        let yOffset: [CGFloat] = [0, collectionView.frame.height/2 + rowSpacing/2]
        
        while currIndex < count {
            let indexPath = IndexPath(item: currIndex, section: 0)
            if currIndex == 0 {
                let cellFrame = CGRect(x: 0, y: 0, width: collectionView.frame.width*0.4, height: collectionView.frame.height)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = cellFrame
                cache.append(attribute)
                xOffset[0] = cellFrame.width + columnSpacing
                xOffset[1] = cellFrame.width + columnSpacing
                contentWidth += xOffset[currRow]
            } else {
                //mark: todo change width properly
                let cellFrame = CGRect(x: xOffset[currRow], y: yOffset[currRow], width: collectionView.frame.height/2 - rowSpacing/2, height: collectionView.frame.height/2 - rowSpacing/2)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = cellFrame
                cache.append(attribute)
                xOffset[currRow] += cellFrame.width + columnSpacing
                currRow = currRow == 0 ? 1 : 0
                if currRow == 0 {
                    contentWidth = cellFrame.maxX
                }
            }
            currIndex += 1
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
          if attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
          }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if indexPath.item >= cache.count {
            return UICollectionViewLayoutAttributes()
        }
        return cache[indexPath.item]
    }
}
