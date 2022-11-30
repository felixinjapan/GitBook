//
//  OwnerDetailViewModel.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//

import Foundation
import os
// MARK: OwnerDetail View Model
protocol OwnerDetailViewModel: ObservableObject {
    var appDIContainer: AppDIContainer? { get }
    var gitBookState: GitBookState? { get }
    var refreshTimeChecker: RefreshTimeChecker { get }
    var thresholdInSec: Int { get }
    var canCallApi: Bool { get }

    func getRepo(with owner: Owner)
    func refresh(with owner: Owner)
}

final class DefaultOwnerDetailViewModel {
    var appDIContainer: AppDIContainer?
    var gitBookState: GitBookState?

    let thresholdInSec = 5
    let refreshTimeChecker: RefreshTimeChecker

    var canCallApi: Bool {
        if refreshTimeChecker.canCallAgain(now: Date(), threshold: thresholdInSec) {
            refreshTimeChecker.resetTimer()
            return true
        }
        return false
    }

    init(refreshTimeChecker: RefreshTimeChecker = DefaultAPIRefreshTimeChecker()) {
        self.refreshTimeChecker = refreshTimeChecker
    }

    private var cancelBag = CancelBag()
    private let logger = Logger(subsystem: Constants.Logging.subsystem.rawValue, category: String(describing: DefaultHomeViewModel.self))
}
// MARK: Owner Detail View Model - Implementation
extension DefaultOwnerDetailViewModel: OwnerDetailViewModel {

    func getRepo(with owner: Owner) {
        guard let container = appDIContainer else { return }
        guard let state = gitBookState else { return }
        state.currentRepoList = [Repo]()
        state.isRepoListLoaded = false
        // check exisiting data
        let repoList = container.fetchDataUsecase.getReposFromCoreData(with: owner)
        if !repoList.isEmpty {
            state.updateState(repo: repoList)
            state.isRepoListLoaded = true
            return
        }
        // call API to get repo data
        container.fetchDataUsecase.getRepoFromAPI(with: owner.unWrappedUsername, state: state) { res in
            self.logger.info("api call for repo success")
            // store response in the coredata
            let repoList = container.storeDataUsecase.saveRepo(resList: res, owner: owner)
            DevUtil.instance.printCoreDataSQLliteFileDirectory()
            state.updateState(repo: repoList)
            state.isRepoListLoaded = true
        }
    }

    func refresh(with owner: Owner) {
        guard let container = appDIContainer else { return }
        guard let state = gitBookState else { return }
        guard canCallApi else { state.showTooManyCallAlert = true; return }
        state.showTooManyCallAlert = false
        state.isRepoListLoaded = false
        // call API to update owner data
        container.fetchDataUsecase.getOwnerFromAPI(with: owner.unWrappedUsername) { [unowned self] res in
            self.logger.info("refresh for owner success")
            // delete core data
            container.storeDataUsecase.updateOwner(owner, res: res)
        }
        // call API to update repo data
        container.fetchDataUsecase.getRepoFromAPI(with: owner.unWrappedUsername, state: state) { [unowned self] res in
            self.logger.info("refresh for repo success")
            // delete core data
            container.storeDataUsecase.deleteRepo(owner)
            // store response in the coredata
            state.currentRepoList = [Repo]()
            let repoList = container.storeDataUsecase.saveRepo(resList: res, owner: owner)
            state.updateState(repo: repoList)
            state.isRepoListLoaded = true
        }
    }

    func inject(with appDIContainer: AppDIContainer, with gitBookState: GitBookState) {
        self.appDIContainer = appDIContainer
        self.gitBookState = gitBookState
    }
}

