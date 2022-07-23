//
//  HomeView.swift
//  FoodApp
//
//  Created by Kannan on 23/03/22.
//

import UIKit

class HomeView: UIView {

    let backBtn = UIButton()
    let lblTitle = UILabel()
    let homeBtn = UIButton()
    let imgGreeting = UIImageView()

    let userDetailsView = UIView()
    let lblName = UILabel()
    let lblAddress = UILabel()
    let lblPin = UILabel()
    let detailsBtn = UIButton()
    
    var subCategoryCV: UICollectionView!

    
    var layoutDict = [String: AnyObject]()
    
    var top: NSLayoutAnchor<NSLayoutYAxisAnchor>!
    var bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>!
    
    func setupViews(Base baseView: UIView, controller: UIViewController) {
        baseView.backgroundColor = .white
        
        backBtn.tintColor = .appThemeColor
        backBtn.contentMode = .scaleAspectFit
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["backBtn"] = backBtn
        baseView.addSubview(backBtn)
        
        lblTitle.textAlignment = .center
        lblTitle.textColor = .appThemeColor
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["lblTitle"] = lblTitle
        baseView.addSubview(lblTitle)
        
        homeBtn.tintColor = .appThemeColor
        homeBtn.contentMode = .scaleAspectFit
        homeBtn.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["homeBtn"] = homeBtn
        baseView.addSubview(homeBtn)
        
        imgGreeting.layer.masksToBounds = true
        imgGreeting.contentMode = .scaleAspectFill
        layoutDict["imgGreeting"] = imgGreeting
        imgGreeting.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(imgGreeting)
        
//        userDetailsView.layer.cornerRadius = 5
        userDetailsView.layer.borderColor = UIColor.lightGray.cgColor
        userDetailsView.backgroundColor = .white
        layoutDict["userDetailsView"] = userDetailsView
        userDetailsView.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(userDetailsView)
        
        lblName.textAlignment = .left
        lblName.textColor = .appThemeColor
        lblName.font = UIFont.boldSystemFont(ofSize: 13)
        lblName.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["lblName"] = lblName
        userDetailsView.addSubview(lblName)
        
        lblAddress.textAlignment = .left
        lblAddress.textColor = .black
        lblAddress.numberOfLines = 0
        lblAddress.lineBreakMode = .byWordWrapping
        lblAddress.font = UIFont.systemFont(ofSize: 12)
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["lblAddress"] = lblAddress
        userDetailsView.addSubview(lblAddress)
        
        lblPin.textAlignment = .left
        lblPin.textColor = .black
        lblPin.font = UIFont.systemFont(ofSize: 12)
        lblPin.translatesAutoresizingMaskIntoConstraints = false
        layoutDict["lblPin"] = lblPin
        userDetailsView.addSubview(lblPin)
        
        detailsBtn.layer.cornerRadius = 5
        detailsBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        detailsBtn.setTitleColor(.white, for: .normal)
        detailsBtn.backgroundColor = .appThemeColor
        layoutDict["detailsBtn"] = detailsBtn
        detailsBtn.translatesAutoresizingMaskIntoConstraints = false
        userDetailsView.addSubview(detailsBtn)
        
        let layoutw = UICollectionViewFlowLayout()
        layoutw.scrollDirection = .vertical
        subCategoryCV = UICollectionView(frame: .zero, collectionViewLayout: layoutw)
        subCategoryCV.backgroundColor = .white
        subCategoryCV.alwaysBounceVertical = false
        subCategoryCV.showsVerticalScrollIndicator = false
        subCategoryCV.showsHorizontalScrollIndicator = false
        layoutDict["subCategoryCV"] = subCategoryCV
        subCategoryCV.translatesAutoresizingMaskIntoConstraints = false
        baseView.addSubview(subCategoryCV)
        
        
        if #available(iOS 11.0, *) {
            self.top = baseView.safeAreaLayoutGuide.topAnchor
            self.bottom = baseView.safeAreaLayoutGuide.bottomAnchor
        } else {
            self.top = controller.topLayoutGuide.bottomAnchor
            self.bottom = controller.bottomLayoutGuide.topAnchor
        }
        
        backBtn.topAnchor.constraint(equalTo: self.top, constant: 10).isActive = true
        subCategoryCV.bottomAnchor.constraint(equalTo: self.bottom, constant: 0).isActive = true

        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[backBtn(20)]-10-[lblTitle]-10-[homeBtn(20)]-16-|", options: [.alignAllTop,.alignAllBottom], metrics: nil, views: layoutDict))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[backBtn(20)]-10-[imgGreeting(180)]", options: [], metrics: nil, views: layoutDict))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imgGreeting]|", options: [], metrics: nil, views: layoutDict))
        userDetailsView.bottomAnchor.constraint(equalTo: imgGreeting.bottomAnchor,constant: 0).isActive = true
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-18-[userDetailsView]-18-|", options: [], metrics: nil, views: layoutDict))
        userDetailsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[lblName(16)]-3-[lblAddress(>=16)]-3-[lblPin(14)]-5-|", options: [.alignAllLeading], metrics: nil, views: layoutDict))

        userDetailsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[lblName]-10-[detailsBtn]-10-|", options: [], metrics: nil, views: layoutDict))
        userDetailsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[lblAddress]-10-[detailsBtn(60)]-10-|", options: [], metrics: nil, views: layoutDict))
        userDetailsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[lblPin]-10-[detailsBtn]-10-|", options: [], metrics: nil, views: layoutDict))
        detailsBtn.centerYAnchor.constraint(equalTo: userDetailsView.centerYAnchor).isActive = true
        detailsBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imgGreeting]-10-[subCategoryCV]", options: [], metrics: nil, views: layoutDict))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[subCategoryCV]-10-|", options: [], metrics: nil, views: layoutDict))

        
    }
 
}
