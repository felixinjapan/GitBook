//
//  SearchRepoViewModel.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2023/01/19
//

import Foundation
import os

// MARK: SearchRepo View Model
protocol SearchRepoViewModel: ObservableObject {
    var appDIContainer: AppDIContainer? { get }
    var gitBookState: GitBookState? { get }

    func getRepo(query: String, page: Int)
    func initData()
}

final class DefaultSearchRepoViewModel {
    var appDIContainer: AppDIContainer?
    var gitBookState: GitBookState?
    private var cancelBag = CancelBag()
    private let logger = Logger(subsystem: Constants.Logging.subsystem.rawValue, category: String(describing: DefaultUserListViewModel.self))

    let refreshTimeChecker: RefreshTimeChecker
    let apiConfiguration: SearchRepoViewConfiguration

    var canCallApi: Bool {
        // e.g 10 times maximum, reset after 10 secs.
        refreshTimeChecker.canCallAgain(now: Date(), threshold: apiConfiguration.apiSleepPeriodSec) && refreshTimeChecker.canCallAgain(maxNumOfCallAllowed: apiConfiguration.apiMaxNumCall)
    }

    init(refreshTimeChecker: RefreshTimeChecker = DefaultAPIRefreshTimeChecker(), apiConfiguration: SearchRepoViewConfiguration = SearchRepoViewConfiguration()) {
        self.refreshTimeChecker = refreshTimeChecker
        self.apiConfiguration = apiConfiguration
    }
}

// MARK: DefaultSearchRepoViewModel
extension DefaultSearchRepoViewModel: SearchRepoViewModel {
    func getRepo(query: String, page: Int) {
        if query.isEmpty { return }
        guard let container = self.appDIContainer else { return }
        guard let state = self.gitBookState else { return }

        let ownerFullname = query + String(page)
        var owner: Owner
        // owner acts as a key in the coredata
        if let ownerEntity = container.fetchDataUsecase.getOwnerFromCoreData(with: ownerFullname) {
            owner = ownerEntity
        } else {
            owner = container.storeDataUsecase.saveOwner(username: ownerFullname)
        }
        // check exisitng data
        let repoList = container.fetchDataUsecase.getReposFromCoreData(with: owner)
        if !repoList.isEmpty {
            state.updateState(searchRepoList: repoList)
            state.isSearchRepoListLoaded = true
            return
        }
        // API request throttling
        guard canCallApi else { state.showTooManyCallAlert = true; return }
        state.showTooManyCallAlert = false
        // call API to retrieve data
        container.fetchDataUsecase.getRepoFromAPI(page: page, query: query, state: state) { [unowned self] res in
            self.refreshTimeChecker.increaseCount()
            let repoList = container.storeDataUsecase.saveRepo(resList: res, owner: owner)
            DevUtil.instance.printCoreDataSQLliteFileDirectory()
            state.isSearchRepoListLoaded = true
            state.updateState(searchRepoList: repoList)
        }
    }

    func initData(){
        guard let container = self.appDIContainer else { return }
        guard let gitBookState = self.gitBookState else { return }
        // check exisiting data
        gitBookState.listOfOwners = container.fetchDataUsecase.getOwnerListFromCoreData()
    }

    func inject(with appDIContainer: AppDIContainer, with gitBookState: GitBookState) {
        self.appDIContainer = appDIContainer
        self.gitBookState = gitBookState
    }
}
