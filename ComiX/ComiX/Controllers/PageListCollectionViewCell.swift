//
//  PageListCollectionViewCell.swift
//  ComiX
//
//  Created by Alexis on 11/22/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class PageListCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = NSStringFromClass(PageListCollectionViewCell.self)
    
    var pagenumber  : UILabel!
    var pageIndex  = 0
    
    override init(frame : CGRect)
    {
        super.init(frame: frame)
        addPaggeNumberLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate extension PageListCollectionViewCell {
    
    func addPaggeNumberLabel(){
        pagenumber = UILabel()
        addSubview(pagenumber)
        pagenumber.snp.makeConstraints{ (make) -> Void in
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.bottom.equalTo(self.snp.bottom).inset(5)
            make.right.equalTo(self.snp.right).inset(5)
        }
        pagenumber.backgroundColor = UIColor(colorLiteralRed: 255, green: 255, blue: 255, alpha: 0.5)
        pagenumber.layer.masksToBounds = true
        pagenumber.layer.cornerRadius = 12
        pagenumber.textAlignment = .center
        pagenumber.font = UIFont.boldSystemFont(ofSize: 9.0)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = pagenumber.bounds
        pagenumber.text = String(pageIndex)
    }
    
}
