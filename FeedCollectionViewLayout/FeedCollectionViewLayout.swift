//
//  FeedCollectionViewLayout.swift
//  FeedCollectionViewLayout
//
//  Created by Devran Uenal on 11.12.16.
//  Copyright © 2016 Devran Uenal. All rights reserved.
//

import UIKit

public let FeedCollectionViewLayoutAutomaticHeight: CGFloat = -1.0

open class FeedCollectionViewLayout: UICollectionViewLayout {
    private var itemAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    private var preferredItemHeight = [IndexPath: CGFloat]()
    private var maxY: CGFloat = 0.0
    
    open var delegate: FeedCollectionViewLayoutDelegate?
    
    open var itemHeight: CGFloat = 44.0
    open var estimatedItemHeight: CGFloat = 44.0
    
    open var sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    open var numberOfColumns: Int = 0
    open var lineSpacing: CGFloat = 0 // Top and Bottom
    open var interItemSpacing: CGFloat = 0 // Left and Right
    
    open override func prepare() {
        super.prepare()
        
        maxY = 0
        var rowPositionY: CGFloat = 0.0
        var columnPositionX: CGFloat = 0.0
        
        for section in 0..<collectionView!.numberOfSections {
            let sectionInsets = self.insetsForSection(section)
            let interItemSpacing = self.interItemSpacingForSection(section)
            maxY = maxY + sectionInsets.top
            for item in 0..<collectionView!.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let row = item / numberOfColumns(inSection: indexPath.section)
                
                if columnIndexForItem(at: indexPath) == 0 {
                    rowPositionY = maxY
                    columnPositionX = 0
                }
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let width = widthForItem(in: indexPath.section)
                var height: CGFloat
                
                if itemHeight == FeedCollectionViewLayoutAutomaticHeight {
                    height = preferredItemHeight[indexPath] ?? 100.0
                } else {
                    height = delegate?.heightForItem(at: indexPath) ?? itemHeight
                }
                
                let x = sectionInsets.left + columnPositionX
                let y = rowPositionY + (row == 0 ? 0 : lineSpacingForSection(section))
                
                let frame = CGRect(
                    origin: CGPoint(x: x, y: y),
                    size: CGSize(width: width, height: height))
                attributes.frame = frame
                itemAttributes[indexPath] = attributes
                
                maxY = max(maxY, frame.maxY)
                columnPositionX = columnPositionX + width + interItemSpacing
            }
            maxY = maxY + sectionInsets.bottom
        }
    }
    
    open override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width, height: maxY)
    }
    
    open override func invalidateLayout() {
        maxY = 0.0
        itemAttributes.removeAll()
        preferredItemHeight.removeAll()
        super.invalidateLayout()
    }
    
    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath]
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return itemAttributes.values.filter { $0.frame.intersects(rect) }
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView!.frame.size != newBounds.size
    }
    
    open override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        if originalAttributes.representedElementCategory == .cell && preferredItemHeight[originalAttributes.indexPath] == nil {
            preferredItemHeight[originalAttributes.indexPath] = preferredAttributes.size.height
            return (originalAttributes.size.height != preferredAttributes.size.height)
        }
        return false
    }
}

extension FeedCollectionViewLayout {
    func numberOfColumns(inSection section: Int) -> Int {
        return delegate?.numberOfColumns(inSection: section) ?? numberOfColumns
    }
    
    func lineSpacingForSection(_ section: Int) -> CGFloat {
        return delegate?.lineSpacingForSection(section) ?? lineSpacing
    }
    
    func interItemSpacingForSection(_ section: Int) -> CGFloat {
        return delegate?.interItemSpacingForSection(section) ?? interItemSpacing
    }
    
    func insetsForSection(_ section: Int) -> UIEdgeInsets {
        return delegate?.insetsForSection(section) ?? sectionInsets
    }
    
    func widthForSection(_ section: Int) -> CGFloat {
        let sectionInsets = insetsForSection(section)
        let contentInsets = collectionView!.contentInset
        let width = self.collectionView!.bounds.width
        return floor(width - contentInsets.left - contentInsets.right - sectionInsets.left - sectionInsets.right)
    }
    
    func widthForItem(in section: Int) -> CGFloat {
        let sectionWidth = widthForSection(section)
        let columns = CGFloat(numberOfColumns(inSection: section))
        let totalSpacing = self.interItemSpacingForSection(section) * max(0, columns-1)
        return (sectionWidth - totalSpacing) / columns
    }
    
    func columnIndexForItem(at indexPath: IndexPath) -> Int {
        return indexPath.row % numberOfColumns(inSection: indexPath.section)
    }
}
