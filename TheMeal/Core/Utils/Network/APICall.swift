//
//  APICall.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import Foundation

struct APICall {
    static let baseURL = "https://www.themealdb.com/api/json/v1/1/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case categories
        case meals
        case meal
        case search
        
        public var url: String {
            switch self {
            case .categories: return "\(APICall.baseURL)categories.php"
            case .meals: return "\(APICall.baseURL)filter.php?c="
            case .meal: return "\(APICall.baseURL)lookup.php?i="
            case .search: return "\(APICall.baseURL)search.php?s="
            }
        }
    }
}
