//
//  RemoteDataSource.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol {
    func getCategories(result: @escaping(Result<[CategoryResponse], URLError>) -> Void)
}

final class RemoteDataSource: NSObject {
    private override init() {}
    static let sharedInstance = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.categories.url) else { return }
        AF.request(url)
            .validate()
            .responseDecodable(of: CategoriesResponse.self) { response in
                switch response.result {
                case .success(let value):
                    result(.success(value.categories))
                case .failure:
                    result(.failure(.invalidResponse))
                }
            }
    }
}
