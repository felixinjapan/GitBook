//
//  OwnerResponse.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation

import Foundation

struct OwnerResponse: Decodable {
    let username: String
    let id: Int64
    let avatarUrl: String
    let fullname: String?
    let followers: Int64
    let following: Int64

    enum CodingKeys: String, CodingKey {
        case username = "login"
        case id
        case avatarUrl = "avatar_url"
        case fullname = "name"
        case followers
        case following
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
        self.id = try container.decode(Int64.self, forKey: .id)
        self.avatarUrl = try container.decode(String.self, forKey: .avatarUrl)
        self.fullname = try container.decode(String?.self, forKey: .fullname)
        self.followers = try container.decode(Int64.self, forKey: .followers)
        self.following = try container.decode(Int64.self, forKey: .following)
    }

    init(username: String, id: Int64, avatarUrl: String, fullname: String, followers: Int64, following: Int64){
        self.username = username
        self.id = id
        self.avatarUrl = avatarUrl
        self.following = following
        self.followers = followers
        self.fullname = fullname
    }
}
