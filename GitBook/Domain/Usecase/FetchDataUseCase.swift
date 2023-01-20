//
//  FetchDataUseCase.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/12.
//

import Foundation
import os
import Combine

// MARK: Fetch Data Usecase
protocol FetchDataUseCase {
    var repositoryContainer: RepositoryContainer { get }
    func getOwnerFromCoreData(with username: String) -> Owner?
    func getOwnerListFromCoreData() -> [Owner]
    func getReposFromCoreData(with owner: Owner) ->  [Repo]
    func getOwnerFromAPI(with username: String, completion: @escaping (OwnerResponse) -> Void)
    func getRepoFromAPI(with username: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void)
    func getRepoFromAPI(page: Int, query: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void)
}

final class DefaultFetchDataUseCase: FetchDataUseCase {

    private var cancelBag = CancelBag()
    private let logger = Logger(subsystem: Constants.Logging.subsystem.rawValue, category: String(describing: DefaultFetchDataUseCase.self))

    let repositoryContainer: RepositoryContainer
    init(repositoryContainer: RepositoryContainer) {
        self.repositoryContainer = repositoryContainer
    }
}

// MARK: Fetch Data Usecase Impl
extension DefaultFetchDataUseCase {
    
    func getOwnerFromAPI(with username: String, completion: @escaping (OwnerResponse) -> Void) {
        return repositoryContainer.apiRepository.getOwner(with: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] in
                if case let .failure(error) = $0 {
                    self.logger.warning("Failed API call for GET owner. \(String(describing: error))")
                }
            }, receiveValue: { res in
                completion(res)
            })
            .store(in: cancelBag)
    }

    func getRepoFromAPI(with username: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void) {
        repositoryContainer.apiRepository.getRepo(with: username)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] in
                if case let .failure(error) = $0 {
                    state.isRepoListLoaded = true
                    self.logger.warning("Failed API call for GET repo. \(String(describing: error))")
                }
            }, receiveValue: { res in
                completion(res)
            })
            .store(in: cancelBag)
    }

    func getRepoFromAPI(page: Int, query: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void) {
        var queryParam = [URLQueryItem]()
        queryParam.append(URLQueryItem(name: "q", value: query))
        queryParam.append(URLQueryItem(name: "page", value: String(page)))
        queryParam.append(URLQueryItem(name: "per_page", value: "15"))

        repositoryContainer.apiRepository.getRepo(queryParam: queryParam)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [unowned self] in
                if case let .failure(error) = $0 {
                    state.isRepoListLoaded = true
                    self.logger.warning("Failed API call for GET repo. \(String(describing: error))")
                }
            }, receiveValue: { res in
                completion(res.items)
            })
            .store(in: cancelBag)
    }

    func getOwnerFromCoreData(with username: String) ->  Owner? {
        return repositoryContainer.coreDataRepository.fetchOwner(username: username)
    }

    func getReposFromCoreData(with owner: Owner) ->  [Repo] {
        return repositoryContainer.coreDataRepository.fetchRepoLists(owner: owner)
    }

    func getOwnerListFromCoreData() -> [Owner] {
        return repositoryContainer.coreDataRepository.fetchAllOwnerList()
    }
    
}
