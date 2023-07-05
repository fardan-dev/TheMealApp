//
//  TheMealApp.swift
//  TheMeal
//
//  Created by telkom on 03/07/23.
//

import SwiftUI

@main
struct TheMealApp: App {
    let homePresenter = HomePresenter(homeUseCase: Injection().provideHome())
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
        }
    }
}
