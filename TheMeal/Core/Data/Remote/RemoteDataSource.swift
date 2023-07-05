//
//  RemoteDataSource.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import Foundation

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
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let categories =  try decoder.decode(CategoriesResponse.self, from: data).categories
                    result(.success(categories))
                } catch {
                    result(.failure(.invalidResponse))
                }
            }
        }
        
        task.resume()
    }
}
