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
    typealias MealInstance = (RemoteDataSource, LocaleDataSource) -> MealRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    static let sharedInstance: MealInstance = { remoteRepo, localeRepo in
        return MealRepository(remote: remoteRepo, locale: localeRepo)
    }
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
}

extension MealRepository: MealRepositoryProtocol {
    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> Void) {
        locale.getCategories { localeResponse in
            switch localeResponse {
            case .success(let categoryEntity):
                let categoryList = CategoryMapper.mapCategoryEntitiesToDomains(input: categoryEntity)
                
                if categoryList.isEmpty {
                    self.remote.getCategories { remoteResponse in
                        switch remoteResponse {
                        case .success(let categoryResponses):
                            let categoryEntities = CategoryMapper.mapCategoryResponsesToEntities(input: categoryResponses)
                            self.locale.addCategories(categories: categoryEntities) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.locale.getCategories { localeResponses in
                                            switch localeResponses {
                                            case .success(let categoryEntity):
                                                let resultList = CategoryMapper.mapCategoryEntitiesToDomains(input: categoryEntity)
                                                result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
//                            result(.success(resultList))
                            
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(categoryList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
