//
//  ViewController.swift
//  CollectionViewPagination
//
//  Created by dos Santos, Diego on 05/12/18.
//  Copyright © 2018 Diego. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private var layout: CustomPaginationLayout {
        return collectionView.collectionViewLayout as! CustomPaginationLayout
    }
    private let itemsInSection = 5
    private let sections = 4

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsInSection
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseCell", for: indexPath)
        cell.backgroundColor = .random()
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    @objc(collectionView:layout:insetForSectionAtIndex:)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let frameWidth = collectionView.frame.size.width
        let cellWidth = layout.itemSize.width
        let lineSpacing = layout.minimumLineSpacing
        let totalItensWidth = (Double(itemsInSection) * Double(cellWidth)) + (Double(itemsInSection - 1) * Double(lineSpacing))
        let totalInsetAvailable = Double(frameWidth) - totalItensWidth
        let inset = CGFloat(totalInsetAvailable / 2)
        let insetBetweenSection = max(inset, CGFloat(lineSpacing / 2))

        return UIEdgeInsets(top: 0, left: insetBetweenSection, bottom: 0, right: insetBetweenSection)
    }
}
