//
//  HomePresenter.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import SwiftUI

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var categories: [CategoryModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getCategories() {
        loadingState = true
        homeUseCase.getCategories { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.categories = categories
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func linkBuilder<Content: View>(for category: CategoryModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(for: category)) { content() }
    }
}
