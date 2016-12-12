//
//  TextCollectionViewCell.swift
//  FeedCollectionViewLayout
//
//  Created by Devran Uenal on 11.12.16.
//  Copyright © 2016 Devran Uenal. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {
    open lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.textLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        self.textLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.textLabel)
        
        self.contentView.backgroundColor = UIColor(hue: CGFloat(Float(arc4random()) / Float(UINT32_MAX)), saturation: 1, brightness: 1, alpha: 0.3)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.textLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.textLabel.bottomAnchor).isActive = true
    }
}
