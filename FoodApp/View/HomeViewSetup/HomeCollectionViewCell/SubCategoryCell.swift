//
//  SubCategoryCell.swift
//  FoodApp
//
//  Created by Kannan on 23/03/22.
//

import UIKit
import Foundation

class SubCategoryCell: UICollectionViewCell {
    
    var backView = UIView()
    var categoryImg = UIImageView()
    var categoryLbl = UILabel()
    
    var layoutDict = [String:AnyObject]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        
        backView.layer.cornerRadius = 3
        backView.layer.borderWidth = 0.2
        backView.layer.borderColor = UIColor.lightGray.cgColor
        backView.backgroundColor = .white
        layoutDict["backView"] = backView
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backView)

        categoryImg.contentMode = .scaleAspectFit
        layoutDict["categoryImg"] = categoryImg
        categoryImg.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(categoryImg)
        
        categoryLbl.textColor = .black
        categoryLbl.font = UIFont.systemFont(ofSize: 13)
        categoryLbl.textAlignment = .center
        layoutDict["categoryLbl"] = categoryLbl
        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(categoryLbl)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backView]|", options: [], metrics: nil, views: layoutDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backView]|", options: [], metrics: nil, views: layoutDict))
        backView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[categoryImg(100)]-10-[categoryLbl(30)]-5-|", options: [], metrics: nil, views: layoutDict))
        backView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[categoryLbl]-5-|", options: [], metrics: nil, views: layoutDict))
        backView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[categoryImg]|", options: [], metrics: nil, views: layoutDict))

        backView.dropShadow()

    }
    
}

