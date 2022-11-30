//
//  StoreDataUseCaseMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation
import XCTest
// MARK: Store Data UseCase Mock - First Time Launch
final class StoreDataUseCaseMock_FirstTimeLaunch: StoreDataUseCase {
    var ownerExpectation: XCTestExpectation?
    var repoExpectation: XCTestExpectation?
    var repositoryContainer: RepositoryContainer = RepositoryMock()

    func deleteRepo(_ owner: Owner) { }

    func deleteOwner(_ username: String) { }

    func updateOwner(_ owner: Owner, res: OwnerResponse) { }

    func saveOwner(res: OwnerResponse) -> Owner {
        if let expct = ownerExpectation {
            expct.fulfill()
        }
        return OwnerMock()
    }

    func saveRepo(resList: [RepoResponse], owner: Owner) -> [Repo] {
        if let expct = repoExpectation {
            expct.fulfill()
        }
        return [RepoMock()]
    }
}
// MARK: Store Data UseCase Mock - Second Time Launch
final class StoreDataUseCaseMock_SecondTimeLaunch: StoreDataUseCase {
    var repositoryContainer: RepositoryContainer = RepositoryMock()

    func deleteRepo(_ owner: Owner) { }

    func deleteOwner(_ username: String) { }

    func updateOwner(_ owner: Owner, res: OwnerResponse) { }

    func saveOwner(res: OwnerResponse) -> Owner {
        XCTFail()
        return OwnerMock()
    }
    func saveRepo(resList: [RepoResponse], owner: Owner) -> [Repo] { XCTFail(); return [] }
}
// MARK: Store Data UseCase Mock - Delete Test
final class StoreDataUseCaseMock_DeleteTest: StoreDataUseCase {
    var expectation: XCTestExpectation?
    var repositoryContainer: RepositoryContainer = RepositoryMock()

    func deleteRepo(_ owner: Owner) { }

    func deleteOwner(_ username: String) {
        if let expct = expectation {
            expct.fulfill()
        }
    }

    func updateOwner(_ owner: Owner, res: OwnerResponse) { }

    func saveOwner(res: OwnerResponse) -> Owner {
        return OwnerMock()
    }

    func saveRepo(resList: [RepoResponse], owner: Owner) -> [Repo] {
        return []
    }

}
// MARK: Store Data UseCase Mock - Refresh
final class StoreDataUseCaseMock_RefreshTest: StoreDataUseCase {
    var ownerExpectation: XCTestExpectation?
    var repoExpectation: XCTestExpectation?
    var repositoryContainer: RepositoryContainer = RepositoryMock()

    func deleteRepo(_ owner: Owner) { }

    func deleteOwner(_ username: String) { }

    func updateOwner(_ owner: Owner, res: OwnerResponse) {
        if let expct = ownerExpectation {
            expct.fulfill()
        }
    }

    func saveOwner(res: OwnerResponse) -> Owner {
        return OwnerMock()
    }

    func saveRepo(resList: [RepoResponse], owner: Owner) -> [Repo] {
        if let expct = repoExpectation {
            expct.fulfill()
        }
        return [RepoMock()]
    }

}
