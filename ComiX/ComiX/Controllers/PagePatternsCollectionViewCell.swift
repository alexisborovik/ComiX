//
//  PagePatternsCollectionViewCell.swift
//  ComiX
//
//  Created by Alexis on 11/24/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class PagePatternsCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = NSStringFromClass(PagePatternsCollectionViewCell.self)

    override init(frame : CGRect)
    {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
