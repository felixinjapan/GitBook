//
//  SearchRepoResponse.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation

struct SearchRepoResponse: Decodable {
    let totalCount: Int64
    let incompleteResults: Bool
    let items: [RepoResponse]


    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = try container.decode(Int64.self, forKey: .totalCount)
        self.incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        self.items = try container.decode([RepoResponse].self, forKey: .items)
    }

    init(totalCount: Int64, incompleteResults: Bool, items: [RepoResponse]){
        self.totalCount = totalCount
        self.incompleteResults = incompleteResults
        self.items = items
    }
}
