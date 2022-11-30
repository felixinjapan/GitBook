//
//  OwnerRepos.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation

struct RepoOwner: Decodable {
    let login: String
    let id: Int64
}

struct RepoResponse: Decodable {
    let id: Int64
    let repoFullName: String
    let repoOwner: RepoOwner
    let stargazersCount: Int64
    var language: String?
    var desc: String?
    var fork: Bool
    var url: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case repoOwner = "owner"
        case stargazersCount = "stargazers_count"
        case language
        case desc = "description"
        case fork
        case url = "html_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.repoFullName = try container.decode(String.self, forKey: .fullName)
        self.stargazersCount = try container.decode(Int64.self, forKey: .stargazersCount)
        self.repoOwner = try container.decode(RepoOwner.self, forKey: .repoOwner)
        self.language = try container.decode(String?.self, forKey: .language)
        self.desc = try container.decode(String?.self, forKey: .desc)
        self.fork = try container.decode(Bool.self, forKey: .fork)
        self.url = try container.decode(String?.self, forKey: .url)
    }

    init(id: Int64, repoFullName: String, url: String, repoOwner: RepoOwner, stargazersCount: Int64, language: String, desc: String, fork: Bool){
        self.id = id
        self.repoFullName = repoFullName
        self.repoOwner = repoOwner
        self.stargazersCount = stargazersCount
        self.language = language
        self.desc = desc
        self.fork = fork
        self.url = url
    }
}
