//
//  ComixListCollectionViewCell.swift
//  ComiX
//
//  Created by Alexis on 11/20/16.
//  Copyright © 2016 Alexis. All rights reserved.
//

import UIKit

class ComixListCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = NSStringFromClass(ComixListCollectionViewCell.self)
    
    var title : UILabel!
    var cover : UIImageView!
    
    
    override init(frame : CGRect)
    {
        super.init(frame: frame)
        addTitleLabel()
        addCoverImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

fileprivate extension ComixListCollectionViewCell {
    
    func addTitleLabel() {
        title = UILabel()
        title.text = "Unnamed"
        title.clipsToBounds = true
        addSubview(title)
        title.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.width.equalTo(self.snp.width).inset(10)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(30)
        }
    }
    
    func addCoverImage() {
        cover = UIImageView()
        cover.clipsToBounds = true
        addSubview(cover)
        cover.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(title.snp.bottom)
            make.left.equalTo(self.snp.left).offset(5)
            make.right.equalTo(self.snp.right).inset(5)
            make.bottom.equalTo(self.snp.bottom).inset(5)
        }
    }
}
