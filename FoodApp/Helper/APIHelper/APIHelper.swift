//
//  APIHelper.swift
//  FoodApp
//
//  Created by Kannan on 23/03/22.
//

import UIKit
import NVActivityIndicatorView

class APIHelper: NSObject {

    static let shared = APIHelper()

    var appName = Bundle.main.infoDictionary?["CFBundleName"] as? String

    let activityData = ActivityData(type: .ballClipRotate, color: .orange)

    var header: [String: String] {
        return ["Accept": "application/json", "Content-Language": "en"]
    }
    
        
    let BASEURL = "https://opendining.net/api/"

    let getSubCategory                 = "v1/merchant/60019/restaurants/PXLAB/menu/tier"

}
