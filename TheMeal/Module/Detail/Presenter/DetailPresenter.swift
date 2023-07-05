//
//  DetailPresenter.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.category = detailUseCase.getCategory()
    }
}
