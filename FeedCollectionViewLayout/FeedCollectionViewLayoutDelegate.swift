//
//  FeedCollectionViewLayoutDelegate.swift
//  FeedCollectionViewLayout
//
//  Created by Devran Uenal on 12.12.16.
//  Copyright © 2016 Devran Uenal. All rights reserved.
//

import UIKit

public protocol FeedCollectionViewLayoutDelegate {
    func insetsForSection(_ section: Int) -> UIEdgeInsets
    func lineSpacingForSection(_ section: Int) -> CGFloat
    func interItemSpacingForSection(_ section: Int) -> CGFloat
    func heightForItem(at indexPath: IndexPath) -> CGFloat
    func numberOfColumns(inSection section: Int) -> Int
}
