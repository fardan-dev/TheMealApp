//
//  CategoryMapper.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import Foundation

final class CategoryMapper {
    static func mapCategoryResponsesToDomains(input categoryResponses: [CategoryResponse]) -> [CategoryModel] {
        return categoryResponses.map { result in
            return CategoryModel(
                id: result.id ?? "",
                title: result.title ?? "Unknow",
                image: result.image ?? "Unknow",
                description: result.description ?? "Unknow"
            )
        }
    }
}
