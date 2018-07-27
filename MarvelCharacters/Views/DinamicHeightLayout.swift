//
//  DinamicHeightLayout.swift
//  POCView
//
//  Created by Cicero on 23/10/16.
//  Copyright © 2016 ciceroduarte. All rights reserved.
//

import UIKit

protocol DynamicHeightLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView,
                        heightForItemAtIndexPath indexPath: IndexPath,
                        withWidth: CGFloat) -> CGFloat
}

class DynamicHeightLayout: UICollectionViewLayout {

    weak var delegate: DynamicHeightLayoutDelegate?

    var numberOfColumns = 2
    var cellPadding: CGFloat = 6.0

    private var cache = [UICollectionViewLayoutAttributes]()

    private var contentHeight: CGFloat  = 0.0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override func prepare() {
        
        guard let collectionView = collectionView,
            let delegate = delegate else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth )
        }
        var column = 0
        
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let width = columnWidth - cellPadding * CGFloat(numberOfColumns)
            
            let itemHeight = delegate.collectionView(collectionView: collectionView,
                                                     heightForItemAtIndexPath: indexPath,
                                                     withWidth: width)
            
            let height = itemHeight + cellPadding * 2
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column >= (numberOfColumns - 1) ? 0 : column + 1
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
}
