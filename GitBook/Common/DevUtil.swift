//
//  DevUtil.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//

import Foundation
import SwiftUI

final class DevUtil {
    // singleton
    static let instance = DevUtil()

    lazy var gitBookStateFullStub: GitBookState = {
        let state = GitBookState()
        state.listOfOwners.append(OwnerMock())
        state.currentRepoList.append(RepoMock())
        return state
    }()

    // show the path for sqlite
    func printCoreDataSQLliteFileDirectory() {
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
    }
}
