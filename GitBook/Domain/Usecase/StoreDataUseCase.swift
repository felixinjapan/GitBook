//
//  StoreDataUseCase.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//

import Foundation
import os

// MARK: Store Data Usecase
protocol StoreDataUseCase {
    var repositoryContainer: RepositoryContainer { get }
    func saveOwner(res: OwnerResponse) -> Owner
    func saveRepo(resList: [RepoResponse], owner: Owner) -> [Repo]
    func deleteRepo(_ owner:Owner)
    func deleteOwner(_ username:String)
    func updateOwner(_ owner: Owner, res: OwnerResponse)
}

final class DefaultStoreDataUseCase: StoreDataUseCase {
    private var cancelBag = CancelBag()
    private let logger = Logger(subsystem: Constants.Logging.subsystem.rawValue, category: String(describing: DefaultStoreDataUseCase.self))

    let repositoryContainer: RepositoryContainer
    init(repositoryContainer: RepositoryContainer) {
        self.repositoryContainer = repositoryContainer
    }
}

// MARK: Store Data Usecase - Implementation
extension DefaultStoreDataUseCase {

    func saveOwner(res: OwnerResponse) -> Owner {
        let owner = repositoryContainer.coreDataRepository.insertOwner(ownerResponse: res)
        repositoryContainer.coreDataRepository.saveData()
        return owner
    }

    func saveRepo(resList: [RepoResponse], owner: Owner) -> [Repo] {
        var repoList = [Repo]()
        for res in resList {
            let repo = repositoryContainer.coreDataRepository.insertRepo(res: res, owner: owner)
            repoList.append(repo)
        }
        repositoryContainer.coreDataRepository.saveData()
        return repoList
    }

    func deleteRepo(_ owner: Owner){
        repositoryContainer.coreDataRepository.deleteRepos(owner)
        repositoryContainer.coreDataRepository.saveData()
    }

    func updateOwner(_ owner:Owner, res: OwnerResponse){
        repositoryContainer.coreDataRepository.updateOwner(res: res, owner: owner)
        repositoryContainer.coreDataRepository.saveData()
    }

    func deleteOwner(_ username:String){
        repositoryContainer.coreDataRepository.deleteOwner(username)
        repositoryContainer.coreDataRepository.saveData()
    }
}
