//
//  FunnyViewController.swift
//  DouYuApp
//
//  Created by mamini on 2021/1/14.
//

import UIKit
private let kTopMargin :CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    
}

extension FunnyViewController{
    override func setupUI() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}
