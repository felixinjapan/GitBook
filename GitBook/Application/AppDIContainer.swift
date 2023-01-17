//
//  AppDIContainer.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/10.
//

import Foundation

// MARK: - DIContainer

protocol DIContainer: ObservableObject {
    var repositoryContainer: RepositoryContainer { get }
}

// MARK: - AppDIContainer

final class AppDIContainer: DIContainer {
    let repositoryContainer: RepositoryContainer
    init (respositoryContainer: RepositoryContainer = DefaultRepositoryContainer()) {
        self.repositoryContainer = respositoryContainer
    }

    // use cases
    lazy var fetchDataUsecase: FetchDataUseCase = DefaultFetchDataUseCase(repositoryContainer: repositoryContainer)
    lazy var storeDataUsecase: StoreDataUseCase = DefaultStoreDataUseCase(repositoryContainer: repositoryContainer)
}
