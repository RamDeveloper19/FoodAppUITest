//
//  PhoneNumberAlreadyRegVC.swift
//  Cabture Driver
//
//  Created by spmac002 on 25/06/19.
//  Copyright © 2019 nPlus. All rights reserved.
//

import UIKit

class PhoneNumberAlreadyRegVC: UIViewController {

    var layoutDic = [String:AnyObject]()
    let sideBackBtn = UIButton(type: .custom)
    
    var textLbl1 = UILabel()
    var termslbl2 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.view.backgroundColor = .white
        SetupView()
    }
    
    func SetupView() {
        
        
        
        textLbl1.font = UIFont.appBoldFont(ofSize: 25)
        textLbl1.text = "Phone number Already Registered"
//                textLbl1.setLineHeight(lineHeight: 0.8)
        textLbl1.textAlignment = .center
        textLbl1.textColor = UIColor(red: 0.92, green: 0.16, blue: 0.16, alpha: 1)
        //        textLbl1.numberOfLines = 0
        //        textLbl1.lineBreakMode = .byWordWrapping
        textLbl1.adjustsFontSizeToFitWidth = true
        textLbl1.translatesAutoresizingMaskIntoConstraints=false
        layoutDic["textLbl1"] = textLbl1
        self.view.addSubview(textLbl1)
        
//        textLbl2.font = UIFont.appTitleFont(ofSize: 18)
//        textLbl2.text = "This phone number is already registered with another account.Login into view your account.If you've forgotten your password you can reset here."
//        textLbl2.textAlignment = .center
//        textLbl2.setLineHeight(lineHeight: 0.8)
//        textLbl2.numberOfLines = 0
//        textLbl2.lineBreakMode = .byWordWrapping
//        textLbl2.translatesAutoresizingMaskIntoConstraints=false
//        layoutDic["textLbl2"] = textLbl2
//        self.view.addSubview(textLbl2)
        
        
        termslbl2.isUserInteractionEnabled = true
        termslbl2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
        termslbl2.minimumScaleFactor = 0.5
        termslbl2.textAlignment = .center
        termslbl2.numberOfLines = 0
        termslbl2.lineBreakMode = NSLineBreakMode.byWordWrapping
        termslbl2.font = UIFont.systemFont(ofSize: 18)
        termslbl2.translatesAutoresizingMaskIntoConstraints = false
        layoutDic["termslbl2"] = termslbl2
        self.view.addSubview(termslbl2)

        
        let strings = NSMutableAttributedString(string: "This phone number is already registered with another account. Login into view your account.If you've forgotten your password you can reset here.")
        strings.setColorForText(" Login ", with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        strings.setColorForText("reset here.", with: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        termslbl2.attributedText = strings

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[textLbl1]-10-[termslbl2]", options: [], metrics: nil, views: layoutDic))
        textLbl1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
        textLbl1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[textLbl1]-10-|", options: [APIHelper.appLanguageDirection], metrics: nil, views: layoutDic))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[termslbl2]-20-|", options: [APIHelper.appLanguageDirection], metrics: nil, views: layoutDic))
        
    }
    
    
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
    
        guard let text = termslbl2.attributedText?.string else {
            return
        }
    
        if let range = text.range(of: NSLocalizedString("This phone number is already registered with another account. Login into view your account.", comment: "Login")),
            recognizer.didTapAttributedTextInLabel(label: termslbl2, inRange: NSRange(range, in: text)) {
//            self.navigationController?.pushViewController(LoginVC(), animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            print("Login")
        }
        else if let range = text.range(of: NSLocalizedString("reset here.", comment: "reset here.")),
            recognizer.didTapAttributedTextInLabel(label: termslbl2, inRange: NSRange(range, in: text)) {
            self.navigationController?.pushViewController(EnterMobVC(), animated: true)
            print("Enter Mob No")
        }
    }
}
extension NSMutableAttributedString{
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
}
}
