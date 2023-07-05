//
//  HomeView.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(presenter.categories, id: \.id) { category in
                        ZStack {
                            presenter.linkBuilder(for: category) {
                                CategoryRow(category: category)
                            }.buttonStyle(PlainButtonStyle())
                        }.padding(8)
                    }
                }
            }
        }.onAppear {
            if presenter.categories.count == 0 {
                presenter.getCategories()
            }
        }.navigationBarTitle(
            Text("Meals Apps"),
            displayMode: .automatic
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(presenter: HomePresenter(homeUseCase: Injection.init().provideHome()))
    }
}
