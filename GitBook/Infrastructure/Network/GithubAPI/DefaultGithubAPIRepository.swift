//
//  DefaultGithubAPIRepository.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation
import Combine

// MARK: - Default GithubAPI Repository

final class DefaultGithubAPIRepository {
    let apiConfiguration: APIConfiguration

    init(apiConfiguration: APIConfiguration = APIConfiguration()) {
        self.apiConfiguration = apiConfiguration
    }
}

// MARK: - DefaultGithubAPIRepository Implementation

extension DefaultGithubAPIRepository: APIRepository {

    func getRepo(with username: String) -> AnyPublisher<[RepoResponse], Error> {
        let path = apiConfiguration.pathGetOwnerRepoInfo
        return getRequestByUsername(with: path, username: username)
    }

    func getRepo(queryParam: [URLQueryItem]) -> AnyPublisher<SearchRepoResponse, Error> {
        let path = apiConfiguration.pathSearchRepo
        var url = apiConfiguration.apiBaseURL.appendingPathComponent(path)
        url.append(queryItems: queryParam)
        var request = URLRequest(url: url)
        // load token on the http header
        let tokenKey = Constants.GithubAPI.oauthKey.rawValue
        let tokenValue = Constants.GithubAPI.oauthValuePrefix.rawValue + " " + apiConfiguration.token

        request.allHTTPHeaderFields = [tokenKey:tokenValue]
        request.httpMethod = Constants.GithubAPI.getMethod.rawValue
        return execute(request)
    }

    func getOwner(with username: String) -> AnyPublisher<OwnerResponse, Error> {
        let path = apiConfiguration.pathGetOwnerInfo
        return getRequestByUsername(with: path, username: username)
    }

    private func getRequestByUsername<T: Decodable>(with path: String, username: String) -> AnyPublisher<T, Error> {

        let completePath = path.replacingOccurrences(of: ":".appending(Constants.GithubAPI.owner.rawValue), with: username)
        let url = apiConfiguration.apiBaseURL.appendingPathComponent(completePath)

        var request = URLRequest(url: url)
        // load token on the http header
        let tokenKey = Constants.GithubAPI.oauthKey.rawValue
        let tokenValue = Constants.GithubAPI.oauthValuePrefix.rawValue + " " + apiConfiguration.token

        request.allHTTPHeaderFields = [tokenKey:tokenValue]
        request.httpMethod = Constants.GithubAPI.getMethod.rawValue
        return execute(request)
    }
}
