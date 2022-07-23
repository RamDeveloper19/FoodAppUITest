//
//  UIKitExtension.swift
//  FoodApp
//
//  Created by Kannan on 23/03/22.
//

import Foundation
import UIKit


extension UIColor {
    
    class var appThemeColor: UIColor {
        return UIColor.hexToColor("#ff6633")
    }
    
    static func hexToColor (_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 0.5
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UIViewController {
    
    func showAlert(_ title :String? = nil , message: String? = nil) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if let title = title {
            let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let titleAttrString = NSAttributedString(string: title, attributes: titleFont)
            alert.setValue(titleAttrString, forKey: "attributedTitle")
        }
        if let message = message {
            let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            let messageAttrString = NSAttributedString(string: message, attributes: messageFont)
            alert.setValue(messageAttrString, forKey: "attributedMessage")
        }
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


