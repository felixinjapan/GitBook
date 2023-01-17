//
//  GitBookState.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/09.
//

import Foundation

final class GitBookState {
    @Published var listOfOwners = [Owner]()
    @Published var currentRepoList = [Repo]()
    
    @Published var isRepoListLoaded = false
    @Published var showTooManyCallAlert = false

    @Published var pageType: Constants.Page = .UserList
}

extension GitBookState: ObservableObject { }

extension GitBookState {
    func updateState(owner: Owner){
        self.listOfOwners.append(owner)
    }
    
    func updateState(owner: Owner, pos: Int){
        self.listOfOwners.insert(owner, at: pos)
    }
    
    func updateState(repo: [Repo]){
        self.currentRepoList = repo
    }
}

