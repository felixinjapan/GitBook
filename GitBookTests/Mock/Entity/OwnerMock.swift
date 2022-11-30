//
//  OwnerMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation

final class OwnerMock: Owner {
    override var username: String? {
        get {
            return "MinnanoTaro"
        }
        set {}
    }

    override var fullname: String? {
        get {
            return "MinnanoTaro"
        }
        set {}
    }

    override var avatarUrl: String? {
        get {
            return "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png"
        }
        set {}
    }

    override var id: Int64 {
        get {
            return Int64.random(in: 0...100000)
        }
        set {}
    }

    override var followers: Int64 {
        get {
            return Int64.random(in: 0...100000)
        }
        set {}
    }

    override var following: Int64 {
        get {
            return Int64.random(in: 0...100000)
        }
        set {}
    }

    override var repos: Repo? {
        get {
            return Repo()
        }
        set {}
    }
}
