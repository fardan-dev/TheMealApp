//
//  Injection.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    private func provideRepository() -> MealRepositoryProtocol {
        let realm = try? Realm()
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        
        return MealRepository.sharedInstance(remote, locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(category: CategoryModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, category: category)
    }
}
