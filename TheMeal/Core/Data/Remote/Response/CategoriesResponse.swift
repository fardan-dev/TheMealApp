//
//  CategoriesResponse.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import Foundation

struct CategoriesResponse: Decodable {
    let categories: [CategoryResponse]
}

struct CategoryResponse: Decodable {
    let id: String?
    let title: String?
    let image: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case title = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
