//
//  FeedViewController.swift
//  FeedCollectionViewLayout-Example
//
//  Created by Devran Uenal on 11.12.16.
//  Copyright © 2016 Devran Uenal. All rights reserved.
//

import UIKit
import FeedCollectionViewLayout

public class FeedDelegate: FeedCollectionViewLayoutDelegate {
    public func lineSpacingForSection(_ section: Int) -> CGFloat {
        return 10.0
    }

    public func insetsForSection(_ section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    }
    
    public func interItemSpacingForSection(_ section: Int) -> CGFloat {
        return 10.0
    }
    
    public func heightForItem(at indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    public func numberOfColumns(inSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 2
        }
    }
}

class FeedViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = FeedCollectionViewLayout()
        // collectionViewLayout.estimatedItemHeight = 20.0
        // collectionViewLayout.itemHeight = FeedCollectionViewLayoutAutomaticHeight
        collectionViewLayout.delegate = FeedDelegate()
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }()
    
    var dataSource: UICollectionViewDataSource = {
        let dataSource = VideosDataSource()
        return dataSource
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.title = "Feed"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.collectionView.contentInset = UIEdgeInsets(top: 5.0, left: 0, bottom: 5.0, right: 0)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.dataSource = self.dataSource
        self.collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "default")
        self.view.addSubview(self.collectionView)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
}
