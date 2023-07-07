//
//  HomeInteractor.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getCategories() -> Observable<[CategoryModel]>
}

class HomeInteractor: HomeUseCase {
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories() -> Observable<[CategoryModel]> {
        repository.getCategories()
    }
}
