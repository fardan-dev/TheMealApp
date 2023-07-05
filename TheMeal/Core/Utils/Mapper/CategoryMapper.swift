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
    
    static func mapCategoryResponsesToEntities(input categoryResponses: [CategoryResponse]) -> [CategoryEntity] {
        return categoryResponses.map { result in
            let newCategory = CategoryEntity()
            newCategory.id = result.id ?? ""
            newCategory.title = result.title ?? "Unknown"
            newCategory.image = result.image ?? "Unknown"
            newCategory.desc = result.description ?? "Unknown"
            return newCategory
        }
    }
    
    static func mapCategoryEntitiesToDomains(input categoryEntites: [CategoryEntity]) -> [CategoryModel] {
        return categoryEntites.map { result in
            return CategoryModel(
                id: result.id,
                title: result.title,
                image: result.image,
                description: result.desc
            )
        }
    }
}
