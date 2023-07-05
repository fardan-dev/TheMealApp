//
//  MealRepository.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import Foundation

protocol MealRepositoryProtocol {
    func getCategories(result: @escaping(Result<[CategoryModel], Error>) -> Void)
}

final class MealRepository: NSObject {
    typealias MealInstance = (RemoteDataSource) -> MealRepository
    fileprivate let remote: RemoteDataSource
    
    static let sharedInstance: MealInstance = { remoteRepo in
        return MealRepository(remote: remoteRepo)
    }
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
}

extension MealRepository: MealRepositoryProtocol {
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void) {
        self.remote.getCategories { remoteResponse in
            switch remoteResponse {
            case .success(let categoryResponses):
                let resultList = CategoryMapper.mapCategoryResponsesToDomains(input: categoryResponses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
