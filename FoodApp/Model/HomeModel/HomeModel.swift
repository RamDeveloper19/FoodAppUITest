//
//  HomeModel.swift
//  FoodApp
//
//  Created by Kannan on 23/03/22.
//

import Foundation

struct SubCategory: Codable {
    var subCategoryList: [SubCategoryValue]
    
    enum CodingKeys: String, CodingKey {
        case subCategoryList = "hierarchy"
    }
}

struct SubCategoryValue: Codable {
    var image: String?
    var name: String?
}
