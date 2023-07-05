//
//  DetailView.swift
//  TheMeal
//
//  Created by telkom on 04/07/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageCategory
                        spacer
                        description
                        spacer
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle(
            Text(presenter.category.title),
            displayMode: .large
        )
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ProgressView()
        }
    }
    
    var imageCategory: some View {
        AsyncImage(url: URL(string: presenter.category.image)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .scaledToFit()
        .frame(
            width: 250,
            height: 250,
            alignment: .center
        )
    }
    
    var description: some View {
        Text(presenter.category.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = CategoryModel(
            id: "1",
            title: "Beef",
            image: "https://www.themealdb.com/images/category/beef.png",
            description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle.")
        
        DetailView(presenter: DetailPresenter(detailUseCase: Injection().provideDetail(category: meal)))
    }
}
