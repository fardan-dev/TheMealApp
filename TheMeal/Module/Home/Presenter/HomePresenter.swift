//
//  HomePresenter.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import SwiftUI
import RxSwift

class HomePresenter: ObservableObject {
    let disposebag = DisposeBag()
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
        homeUseCase.getCategories()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.categories = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposebag)
    }
    
    func linkBuilder<Content: View>(for category: CategoryModel, @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(for: category)) { content() }
    }
}
