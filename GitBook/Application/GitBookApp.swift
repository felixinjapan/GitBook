//
//  GitBookApp.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import SwiftUI

@main
struct GitBookApp: App {

    // Initialize dependcies
    var gitBookState = GitBookState()
    var appDIContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(gitBookState)
                .environmentObject(appDIContainer)
                .onAppear {
                    // cache setting
                    URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
                    URLCache.shared.diskCapacity = 100_000_000 // ~100 MB disk cache space
                }
        }
    }
}
