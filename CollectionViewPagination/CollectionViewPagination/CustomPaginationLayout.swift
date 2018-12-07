//
//  CustomPaginationLayout.swift
//  CollectionViewPagination
//
//  Created by dos Santos, Diego on 06/12/18.
//  Copyright © 2018 Diego. All rights reserved.
//

import UIKit

class CustomPaginationLayout: UICollectionViewFlowLayout {
    private let itemWidth = CGFloat(60)
    private let lineSpacing = CGFloat(8)

    override func awakeFromNib() {
        super.awakeFromNib()
        itemSize = CGSize(width: itemWidth, height: itemWidth)
        minimumLineSpacing = lineSpacing

        scrollDirection = .horizontal
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView?.isPagingEnabled = false
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offset = collectionView!.contentOffset
        let sections = collectionView?.numberOfSections
        let itemsOnFirstSection = collectionView!.numberOfItems(inSection: 0)
        let pageMinWidth = CGFloat((itemsOnFirstSection * Int(itemWidth + lineSpacing)))
        let pageMaxWidth = collectionView!.contentSize.width / CGFloat(sections!)
        let pageWidth = max(pageMinWidth, pageMaxWidth)
        let frameMidX = collectionView!.frame.width / 2
        let pagesOnProposedOffset = ((offset.x + frameMidX) / pageWidth).rounded(.down)

        if velocity.x > 0 {
            // Swipping To Right
            offset.x = pageWidth * (pagesOnProposedOffset + 1)
        } else if velocity.x < 0 {
            // Swipping To left
            offset.x = pageWidth * (pagesOnProposedOffset - 1)
        } else {
            // Dragging
            offset.x = pageWidth * pagesOnProposedOffset
        }

        return offset
    }
}
