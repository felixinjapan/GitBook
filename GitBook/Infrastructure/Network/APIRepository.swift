//
//  APIRepository.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation
import Combine

// MARK: - API Respository
protocol APIRepository {

    var apiConfiguration: APIConfiguration { get }
    
    func getOwner(with username: String) -> AnyPublisher<OwnerResponse, Error>
    func getRepo(with username: String) -> AnyPublisher<[RepoResponse], Error>
    func getRepo(queryParam: [URLQueryItem]) -> AnyPublisher<SearchRepoResponse, Error>
}

extension APIRepository {
    func execute<Response: Decodable>(_ urlReq: URLRequest) -> AnyPublisher<Response, Error> {
        // make a request
        return URLSession.shared.dataTaskPublisher(for: urlReq)
            .retry(apiConfiguration.apiRetryCount)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

