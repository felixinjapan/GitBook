//
//  StoreDataUseCaseTest.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/20.
//
import XCTest

final class StoreDataUseCaseTest: XCTestCase {

    func test_whenSaveOwner_shouldCallCoreData() {
        let insertExpectation = self.expectation(description: "Should trigger insert owner")
        let saveExpectation = self.expectation(description: "Should trigger the save owner in core data")

        let repositoryMock = RepositoryMock()
        let coreDataMock = CoreDataRepositoryMock_SaveOwnerTest()

        coreDataMock.insertExpectation = insertExpectation
        coreDataMock.saveExpectation = saveExpectation

        repositoryMock.coreDataRepository = coreDataMock

        let sut = DefaultStoreDataUseCase(repositoryContainer: repositoryMock)

        let ownerResponseMock = OwnerResponse(username: "MinnanoTaro", id: 33333, avatarUrl: "https://www.google.co.jp", fullname: "Taro Tanaka", followers: 99902, following: 4)

        let _ = sut.saveOwner(res: ownerResponseMock)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenSaveRepo_shouldCallCoreData() {
        let insertExpectation = self.expectation(description: "Should trigger insert owner")
        let saveExpectation = self.expectation(description: "Should trigger the save owner in core data")

        let repositoryMock = RepositoryMock()
        let coreDataMock = CoreDataRepositoryMock_SaveRepoTest()

        coreDataMock.insertExpectation = insertExpectation
        coreDataMock.saveExpectation = saveExpectation

        repositoryMock.coreDataRepository = coreDataMock

        let sut = DefaultStoreDataUseCase(repositoryContainer: repositoryMock)
        let repoOwnerMock = RepoOwner(login: "MinnanoTaro", id: 33333)

        let repoResponseMock = RepoResponse(id: 1, repoFullName: "MyRepo", url: "www.japan.com", repoOwner: repoOwnerMock, stargazersCount: 44, language: "java", desc: "hello world", fork: false)

        let _ = sut.saveRepo(resList: [repoResponseMock], owner: OwnerMock())
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenDeleteOwner_shouldCallCoreData() {
        let targetExpectation = self.expectation(description: "Should trigger insert owner")
        let saveExpectation = self.expectation(description: "Should trigger the save owner in core data")

        let repositoryMock = RepositoryMock()
        let coreDataMock = CoreDataRepositoryMock_DeleteOwner()

        coreDataMock.targetExpectation = targetExpectation
        coreDataMock.saveExpectation = saveExpectation

        repositoryMock.coreDataRepository = coreDataMock

        let sut = DefaultStoreDataUseCase(repositoryContainer: repositoryMock)
        let _ = sut.deleteOwner("Taro123")
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenDeleteRepo_shouldCallCoreData() {
        let targetExpectation = self.expectation(description: "Should trigger insert owner")
        let saveExpectation = self.expectation(description: "Should trigger the save owner in core data")

        let repositoryMock = RepositoryMock()
        let coreDataMock = CoreDataRepositoryMock_DeleteRepo()

        coreDataMock.targetExpectation = targetExpectation
        coreDataMock.saveExpectation = saveExpectation

        repositoryMock.coreDataRepository = coreDataMock

        let sut = DefaultStoreDataUseCase(repositoryContainer: repositoryMock)
        let _ = sut.deleteRepo(OwnerMock())
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenUpdateOwner_shouldCallCoreData() {
        let targetExpectation = self.expectation(description: "Should trigger insert owner")
        let saveExpectation = self.expectation(description: "Should trigger the save owner in core data")
        let ownerResponseMock = OwnerResponse(username: "MinnanoTaro", id: 33333, avatarUrl: "https://www.google.co.jp", fullname: "Taro Tanaka", followers: 99902, following: 4)

        let repositoryMock = RepositoryMock()
        let coreDataMock = CoreDataRepositoryMock_UpdateOwner()

        coreDataMock.targetExpectation = targetExpectation
        coreDataMock.saveExpectation = saveExpectation

        repositoryMock.coreDataRepository = coreDataMock

        let sut = DefaultStoreDataUseCase(repositoryContainer: repositoryMock)
        let _ = sut.updateOwner(OwnerMock(), res: ownerResponseMock)
        waitForExpectations(timeout: 3, handler: nil)
    }
}
