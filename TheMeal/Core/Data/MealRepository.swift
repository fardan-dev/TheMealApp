//
//  MealRepository.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import Foundation
import RxSwift

protocol MealRepositoryProtocol {
    func getCategories() -> Observable<[CategoryModel]>
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
    func getCategories() -> Observable<[CategoryModel]> {
        return locale
            .getCategories()
            .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getCategories()
                .map { CategoryMapper.mapCategoryResponsesToEntities(input: $0) }
                .flatMap { self.locale.addCategories(categories: $0) }
                .filter { $0 }
                .flatMap { _ in self.locale.getCategories()
                        .map { CategoryMapper.mapCategoryEntitiesToDomains(input: $0) }
                }
            )
    }
}
