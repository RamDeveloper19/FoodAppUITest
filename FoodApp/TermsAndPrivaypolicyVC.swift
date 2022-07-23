//
//  TermsAndPrivaypolicyVC.swift
//  Cabture Driver
//
//  Created by spmac002 on 11/06/19.
//  Copyright © 2019 nPlus. All rights reserved.
//

import UIKit
import WebKit

class TermsAndPrivaypolicyVC: UIViewController {

    var layoutDic = [String:AnyObject]()
    let sideBackBtn = UIButton(type: .custom)
    
    var headerlbl = UILabel()
    var terms = UILabel()
    var termsImg = UIImageView()
    var acceptBtn = UIButton()
    
    var termText = "Tap Accept to let us Know you agree to our Terms of Services and Privacy Policy"
    var term = "Terms of Services"
    var policy = "Privacy Policy"
    
    var userDetails: UserDetails?
    var callback : ((UserDetails) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

            print (userDetails)
            
            self.navigationItem.setHidesBackButton(true, animated: false)
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            
            let sideBackBtn = UIButton(type: .custom)
            sideBackBtn.setImage(UIImage(named: "sidebackbtn"), for: .normal)
            sideBackBtn.translatesAutoresizingMaskIntoConstraints = false
            layoutDic["sideBackBtn"] = sideBackBtn
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sideBackBtn)
            sideBackBtn.addTarget(self, action: #selector(sideBackBtnAction(_:)), for: .touchUpInside)
            
            self.view.backgroundColor = .white

            let formattedText = String.format(strings: [term, policy],
                                          boldFont: UIFont.boldSystemFont(ofSize: 18),
                                          boldColor: UIColor.blue,
                                          inString: termText,
                                          font: UIFont.systemFont(ofSize: 17),
                                          color: UIColor.black)

            terms.attributedText = formattedText

            SetUpViews()
        }
        
        @objc func sideBackBtnAction(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
    
        func SetUpViews() {
            
            self.headerlbl.font = UIFont.appBoldFont(ofSize: 18)
            self.headerlbl.text = "Review our Terms  and Conditons"
            self.headerlbl.textAlignment = APIHelper.appTextAlignment
            headerlbl.translatesAutoresizingMaskIntoConstraints=false
            layoutDic["headerlbl"] = headerlbl
            self.view.addSubview(headerlbl)
            
            terms.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
            terms.text = termText
            terms.numberOfLines = 0
            terms.lineBreakMode = .byWordWrapping
            terms.isUserInteractionEnabled = true
            terms.textAlignment = .left
            terms.translatesAutoresizingMaskIntoConstraints = false
            layoutDic["terms"] = terms
            self.view.addSubview(terms)
            
            termsImg.image = UIImage (named:"termsimg")
            termsImg.contentMode = .scaleAspectFit
            termsImg.translatesAutoresizingMaskIntoConstraints = false
            layoutDic["termsImg"] = termsImg
            self.view.addSubview(termsImg)
            
            acceptBtn.addTarget(self, action: #selector(acceptBtnAction(_:)), for: .touchUpInside)
            acceptBtn.setTitle("text_accept".localize(), for: .normal)
            acceptBtn.backgroundColor = .themeColor
            acceptBtn.setTitleColor(.secondaryColor, for: .normal)
            acceptBtn.translatesAutoresizingMaskIntoConstraints = false
            layoutDic["acceptBtn"] = acceptBtn
            self.view.addSubview(acceptBtn)
            
            
            let strings = NSMutableAttributedString(string: termText)
            strings.setColorForText(term, with: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
            strings.setColorForText(policy, with: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
            terms.attributedText = strings
            
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[headerlbl(30)]-20-[terms(90)]-30-[termsImg(120)]", options: [], metrics: nil, views: layoutDic))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[headerlbl]-20-|", options: [APIHelper.appLanguageDirection], metrics: nil, views: layoutDic))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[terms]-20-|", options: [APIHelper.appLanguageDirection], metrics: nil, views: layoutDic))
            
            termsImg.widthAnchor.constraint(equalToConstant: 240).isActive = true
            termsImg.heightAnchor.constraint(equalToConstant: 120).isActive = true
            termsImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.view.addConstraint(NSLayoutConstraint.init(item: termsImg, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.6, constant: 0))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[acceptBtn]|", options: [APIHelper.appLanguageDirection], metrics: nil, views: layoutDic))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[acceptBtn(50)]|", options: [APIHelper.appLanguageDirection], metrics: nil, views: layoutDic))
        }
        @objc func acceptBtnAction(_ sender: UIButton) {
            let viewController = CabTypeVC()
            viewController.userDetails = self.userDetails
            viewController.callback = { [unowned self] userDetails in
                self.userDetails = userDetails
                print(userDetails)
            }
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    
        @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
            guard let text = terms.attributedText?.string else {
                return
            }
            
            if let range = text.range(of: NSLocalizedString(termText, comment: "Terms of Services")),
                recognizer.didTapAttributedTextInLabel(label: terms, inRange: NSRange(range, in: text)) {
                handleViewTermOfUse()
            } else if let range = text.range(of: NSLocalizedString(termText, comment: "Privacy Policy")),
                recognizer.didTapAttributedTextInLabel(label: terms, inRange: NSRange(range, in: text)) {
                handleViewTermOfUse()
            }
        }
    
        func handleViewTermOfUse() {
            self.navigationController?.pushViewController(WebVC(), animated: true)
        }
}
extension String {
    static func format(strings: [String],
                       boldFont: UIFont = UIFont.boldSystemFont(ofSize: 18),
                       boldColor: UIColor = UIColor.blue,
                       inString string: String,
                       font: UIFont = UIFont.systemFont(ofSize: 17),
                       color: UIColor = UIColor.black) -> NSAttributedString {
        let attributedString =
            NSMutableAttributedString(string: string,
                                      attributes: [
                                        NSAttributedStringKey.font: font,
                                        NSAttributedStringKey.foregroundColor: color])
        let boldFontAttribute = [NSAttributedStringKey.font: boldFont, NSAttributedStringKey.foregroundColor: boldColor]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        return attributedString
    }
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = label.attributedText else {
            return false
        }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
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
