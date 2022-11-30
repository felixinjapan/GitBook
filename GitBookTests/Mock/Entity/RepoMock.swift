//
//  RepoMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation

final class RepoMock: Repo {
    override var repoFullName: String? {
        get {
            return "MinnanoTaro"
        }
        set {}
    }

    override var language: String? {
        get {
            return "MinnanoTaro"
        }
        set {}
    }

    override var repoId: Int64 {
        get {
            return 1
        }
        set {}
    }

    override var stargazersCount: Int64 {
        get {
            return 333
        }
        set {}
    }

    override var fork: Bool {
        get {
            return false
        }
        set {}
    }

    override var desc: String? {
        get {
            return "MinnanoTaro"
        }
        set {}
    }

    override var owner: Owner? {
        get {
            return OwnerMock()
        }
        set {}
    }
}

