//
//  APIRepositoryMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation
import Combine

final class APIRepositoryMock: APIRepository {
    func getRepo(queryParam: [URLQueryItem]) -> AnyPublisher<SearchRepoResponse, Error> {
        var resList = [RepoResponse]()
        let repoOwnerMock = RepoOwner(login: "MinnanoTaro", id: 33333)
        for idx in 1...5 {
            let repoResponseMock = RepoResponse(id: Int64(idx), repoFullName: "MyRepo\(idx)", url: "www.japan.com", repoOwner: repoOwnerMock, stargazersCount: 44, language: "java", desc: "hello world", fork: false)
            resList.append(repoResponseMock)
        }
        let repoMock = SearchRepoResponse(totalCount: 1, incompleteResults: false, items: resList)
        return Just(repoMock).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getOwner(with username: String) -> AnyPublisher<OwnerResponse, Error> {
        let ownerResponseMock = OwnerResponse(username: "MinnanoTaro", id: 33333, avatarUrl: "https://www.google.co.jp", fullname: "Taro Tanaka", followers: 99902, following: 4)
        return Just(ownerResponseMock).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getRepo(with username: String) -> AnyPublisher<[RepoResponse], Error> {
        var resList = [RepoResponse]()
        let repoOwnerMock = RepoOwner(login: "MinnanoTaro", id: 33333)
        for idx in 1...5 {
            let repoResponseMock = RepoResponse(id: Int64(idx), repoFullName: "MyRepo\(idx)", url: "www.japan.com", repoOwner: repoOwnerMock, stargazersCount: 44, language: "java", desc: "hello world", fork: false)
            resList.append(repoResponseMock)
        }
        return Just(resList).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    lazy var apiConfiguration: APIConfiguration = .init()
}

final class APIRepositoryMock_Failure: APIRepository {

    func getRepo(queryParam: [URLQueryItem]) -> AnyPublisher<SearchRepoResponse, Error> {
        return Fail(error: AppError.NetworkError.tooManyApiCalls).eraseToAnyPublisher()
    }

    func getOwner(with username: String) -> AnyPublisher<OwnerResponse, Error> {
        return Fail(error: AppError.NetworkError.tooManyApiCalls).eraseToAnyPublisher()
    }

    func getRepo(with username: String) -> AnyPublisher<[RepoResponse], Error> {
        return Fail(error: AppError.NetworkError.tooManyApiCalls).eraseToAnyPublisher()
    }

    lazy var apiConfiguration: APIConfiguration = .init()
}
