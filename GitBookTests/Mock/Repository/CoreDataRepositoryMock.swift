//
//  CoreDataRepositoryMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation
import CoreData

class CoreDataRepositoryMock: CoreDataRepository {
    func insertOwner(username: String) -> Owner {
        return OwnerMock()
    }

    func updateOwner(res: OwnerResponse, owner: Owner) { }

    var container: NSPersistentContainer = NSPersistentContainer(name: "")

    func fetchRepoLists(owner: Owner) -> [Repo] {
        [RepoMock()]
    }

    func fetchOwner(username: String) -> Owner? {
        return OwnerMock()
    }

    func fetchAllOwnerList() -> [Owner] {
        return [OwnerMock()]
    }

    func insertOwner(ownerResponse: OwnerResponse) -> Owner {
        return OwnerMock()
    }

    func insertRepo(res: RepoResponse, owner: Owner) -> Repo {
        return RepoMock()
    }

    func deleteOwner(_ username: String) {}

    func deleteRepos(_ owner: Owner) {}

    func saveData() {}
}
