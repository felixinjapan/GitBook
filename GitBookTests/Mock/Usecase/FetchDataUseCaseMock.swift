//
//  FetchDataUseCaseMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation
import XCTest
// MARK: Fetch Data UseCase Mock - First Time Launch
final class FetchDataUseCaseMock_FirstTimeLaunch: FetchDataUseCase {

    var ownerExpectation: XCTestExpectation?
    var repoExpectation: XCTestExpectation?

    var repositoryContainer: RepositoryContainer = RepositoryMock()

    func getOwnerFromCoreData(with username: String) -> Owner? {
        return nil
    }

    func getOwnerListFromCoreData() -> [Owner] {
        return []
    }

    func getReposFromCoreData(with owner: Owner) -> [Repo] {
        return []
    }

    func getRepoFromAPI(page: Int, query: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void) {
        var resList = [RepoResponse]()
        let repoOwnerMock = RepoOwner(login: "MinnanoTaro", id: 33333)
        for idx in 1...5 {
            let repoResponseMock = RepoResponse(id: Int64(idx), repoFullName: "MyRepo\(idx)", url: "www.japan.com", repoOwner: repoOwnerMock, stargazersCount: 44, language: "java", desc: "hello world", fork: false)
            resList.append(repoResponseMock)
        }
        if let expct = repoExpectation {
            expct.fulfill()
            completion(resList)
        }
    }

    func getOwnerFromAPI(with username: String, completion: @escaping (OwnerResponse) -> Void) {
        let ownerResponseMock = OwnerResponse(username: "MinnanoTaro", id: 33333, avatarUrl: "https://www.google.co.jp", fullname: "Taro Tanaka", followers: 99902, following: 4)
        if let expct = ownerExpectation {
            expct.fulfill()
            completion(ownerResponseMock)
        }
    }

    func getRepoFromAPI(with username: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void) {
        var resList = [RepoResponse]()
        let repoOwnerMock = RepoOwner(login: "MinnanoTaro", id: 33333)
        for idx in 1...5 {
            let repoResponseMock = RepoResponse(id: Int64(idx), repoFullName: "MyRepo\(idx)", url: "www.japan.com", repoOwner: repoOwnerMock, stargazersCount: 44, language: "java", desc: "hello world", fork: false)
            resList.append(repoResponseMock)
        }
        if let expct = repoExpectation {
            expct.fulfill()
            completion(resList)
        }
    }
}

// MARK: Fetch Data UseCase Mock - Second Time Launch
final class FetchDataUseCaseMock_SecondTimeLaunch: FetchDataUseCase {

    var ownerExpectation: XCTestExpectation?
    var repoExpectation: XCTestExpectation?

    var repositoryContainer: RepositoryContainer = RepositoryMock()
    let ownerMock = OwnerMock()
    let repoMock = RepoMock()

    func getOwnerFromCoreData(with username: String) -> Owner? {
        if let expct = ownerExpectation {
            expct.fulfill()
        }
        return ownerMock
    }

    func getOwnerListFromCoreData() -> [Owner] {
        if let expct = ownerExpectation {
            expct.fulfill()
        }
        return [ownerMock]
    }

    func getReposFromCoreData(with owner: Owner) -> [Repo] {
        if let expct = repoExpectation {
            expct.fulfill()
        }
        return [repoMock]
    }

    func getOwnerFromAPI(with username: String, completion: @escaping (OwnerResponse) -> Void) { }

    func getRepoFromAPI(page: Int, query: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void) { }

    func getRepoFromAPI(with username: String, state: GitBookState, completion: @escaping ([RepoResponse]) -> Void) { }
}
