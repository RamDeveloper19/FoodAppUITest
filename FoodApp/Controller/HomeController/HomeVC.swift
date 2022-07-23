//
//  HomeVC.swift
//  FoodApp
//
//  Created by Kannan on 23/03/22.
//

import UIKit
import Foundation
import Alamofire
import Kingfisher
import NVActivityIndicatorView

class HomeVC: UIViewController {

    let homeView = HomeView()
    
    var categoryList: SubCategory?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCategoryListAPI()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        homeView.userDetailsView.dropShadow()

    }
    
    func setupViews() {
        self.homeView.setupViews(Base: self.view, controller: self)
        self.setupTextImages()
        self.setuptarget()

    }
    
    func setupTextImages() {
        homeView.backBtn.setImage(UIImage(named: "BackImg")?.withRenderingMode(.alwaysTemplate), for: .normal)
        homeView.homeBtn.setImage(UIImage(named: "HomeImg")?.withRenderingMode(.alwaysTemplate), for: .normal)
        homeView.imgGreeting.image = UIImage(named: "HomeStaticImg")

        homeView.lblTitle.text = "Menu".uppercased()
        homeView.lblName.text = "PXLAB"
        homeView.lblAddress.text = "74 Bridge st,Newton"
        homeView.lblPin.text = "US-02458"
        homeView.detailsBtn.setTitle("Details", for: .normal)
    }
    
    func setuptarget() {
        homeView.backBtn.addTarget(self, action: #selector(backBtnPressed(_ :)), for: .touchUpInside)
        homeView.homeBtn.addTarget(self, action: #selector(btnHomePressed(_ :)), for: .touchUpInside)
        homeView.detailsBtn.addTarget(self, action: #selector(btnDetailsPressed(_ :)), for: .touchUpInside)

        homeView.subCategoryCV.delegate = self
        homeView.subCategoryCV.dataSource = self
        homeView.subCategoryCV.register(SubCategoryCell.self, forCellWithReuseIdentifier: "SubCategoryCell")

    }
}

extension HomeVC {
    @objc func backBtnPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnHomePressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func btnDetailsPressed(_ sender: UIButton) {
        print("User Details Pushed")
    }
}

extension HomeVC {
    func getCategoryListAPI() {
        if ConnectionCheck.isConnectedToNetwork() {
            
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(APIHelper.shared.activityData)
            
            let url = APIHelper.shared.BASEURL + APIHelper.shared.getSubCategory
            var paramDict = Dictionary<String, Any>()
            
            paramDict["include_combo"] = "true"
            paramDict["key"] = "6d6bf06a4f653a54da8d88715a736a4ca6071ffb"
            print("SubategoryList Param: ",url,paramDict)
            
            Alamofire.request(url, method: .post, parameters: paramDict, headers: APIHelper.shared.header).responseJSON {  response in
                print("response for SubategoryList = ",response.result.value as AnyObject)
            }.responseData { (response) in
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.categoryList = try? decoder.decode(SubCategory.self, from: data)
                        self.homeView.subCategoryCV.reloadData()
                    }
                case .failure(_):
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    print("failure")
                    self.showAlert(APIHelper.shared.appName, message: "Something went wrong")
                }
            }
        } else {
            self.showAlert(APIHelper.shared.appName, message: "Please check your internet connection")
        }
    }
}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2) - 10, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList?.subCategoryList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCell", for: indexPath) as? SubCategoryCell ?? SubCategoryCell()
        
        cell.categoryLbl.text = self.categoryList?.subCategoryList[indexPath.item].name
        
        if let urlStr = self.categoryList?.subCategoryList[indexPath.item].image, let url = URL(string:urlStr) {
            cell.categoryImg.kf.indicatorType = .activity
            let resource = ImageResource(downloadURL: url)
            cell.categoryImg.kf.setImage(with: resource, placeholder: UIImage(named: "FoodPlaceHolder"), options: nil, progressBlock: nil, completionHandler: nil)
        } else {
            cell.categoryImg.image = UIImage(named: "FoodPlaceHolder")
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let name = self.categoryList?.subCategoryList[indexPath.item].name {
            print("Your select category ",name)
        }
    }
}
