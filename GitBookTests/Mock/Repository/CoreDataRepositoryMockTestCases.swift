//
//  CoreDataRepositoryMockTestCases.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation
import CoreData
import XCTest

final class CoreDataRepositoryMock_SaveOwnerTest: CoreDataRepositoryMock {
    var saveExpectation: XCTestExpectation?
    var insertExpectation: XCTestExpectation?

    override func insertOwner(ownerResponse: OwnerResponse) -> Owner {
        if let expt = insertExpectation {
            expt.fulfill()
        }
        return OwnerMock()
    }

    override func saveData() {
        if let expt = saveExpectation {
            expt.fulfill()
        }
    }
}

final class CoreDataRepositoryMock_SaveRepoTest: CoreDataRepositoryMock {
    var saveExpectation: XCTestExpectation?
    var insertExpectation: XCTestExpectation?

    override func insertRepo(res: RepoResponse, owner: Owner) -> Repo {
        if let expt = insertExpectation {
            expt.fulfill()
        }
        return RepoMock()
    }

    override func saveData() {
        if let expt = saveExpectation {
            expt.fulfill()
        }
    }
}

final class CoreDataRepositoryMock_DeleteOwner: CoreDataRepositoryMock {
    var saveExpectation: XCTestExpectation?
    var targetExpectation: XCTestExpectation?

    override func deleteOwner(_ username: String) {
        if let expt = targetExpectation {
            expt.fulfill()
        }
    }

    override func saveData() {
        if let expt = saveExpectation {
            expt.fulfill()
        }
    }
}

final class CoreDataRepositoryMock_DeleteRepo: CoreDataRepositoryMock {
    var saveExpectation: XCTestExpectation?
    var targetExpectation: XCTestExpectation?

    override func deleteRepos(_ owner: Owner) {
        if let expt = targetExpectation {
            expt.fulfill()
        }
    }

    override func saveData() {
        if let expt = saveExpectation {
            expt.fulfill()
        }
    }
}

final class CoreDataRepositoryMock_UpdateOwner: CoreDataRepositoryMock {
    var saveExpectation: XCTestExpectation?
    var targetExpectation: XCTestExpectation?

    override func updateOwner(res: OwnerResponse, owner: Owner) {
        if let expt = targetExpectation {
            expt.fulfill()
        }
    }

    override func saveData() {
        if let expt = saveExpectation {
            expt.fulfill()
        }
    }
}
