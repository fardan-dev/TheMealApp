//
//  HomeRouter.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for categoryModel: CategoryModel) -> some View {
        let detailPresenter = DetailPresenter(detailUseCase: Injection().provideDetail(category: categoryModel))
        return DetailView(presenter: detailPresenter)
    }
}
