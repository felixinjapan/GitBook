//
//  HomeViewModel.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/09.
//

import Foundation
import os

// MARK: Home View Model
protocol HomeViewModel: ObservableObject {
    var appDIContainer: AppDIContainer? { get }
    var gitBookState: GitBookState? { get }
    
    func getOwner(with username: String)
    func initData()
    func deleteData(at offsets: IndexSet)
}

final class DefaultHomeViewModel {
    var appDIContainer: AppDIContainer?
    var gitBookState: GitBookState?
    private var cancelBag = CancelBag()
    private let logger = Logger(subsystem: Constants.Logging.subsystem.rawValue, category: String(describing: DefaultHomeViewModel.self))
}

// MARK: DefaultHomeViewModel
extension DefaultHomeViewModel: HomeViewModel {
    func getOwner(with username: String) {
        guard let container = self.appDIContainer else { return }
        guard let state = self.gitBookState else { return }
        // check exisiting data
        if let owner = container.fetchDataUsecase.getOwnerFromCoreData(with: username) {
            state.updateState(owner: owner)
            return
        }
        // call API to get owner data
        container.fetchDataUsecase.getOwnerFromAPI(with: username) { res in
            // store response in the coredata
            let owner = container.storeDataUsecase.saveOwner(res: res)
            state.updateState(owner: owner)
        }
    }
    
    func initData(){
        guard let container = self.appDIContainer else { return }
        guard let gitBookState = self.gitBookState else { return }
        // check exisiting data
        gitBookState.listOfOwners = container.fetchDataUsecase.getOwnerListFromCoreData()
    }
    
    func deleteData(at offsets: IndexSet){
        guard let container = self.appDIContainer else { return }
        guard let gitBookState = self.gitBookState else { return }
        // check exisiting data
        for index in offsets {
            let owner = gitBookState.listOfOwners[index]
            container.storeDataUsecase.deleteRepo(owner)
            container.storeDataUsecase.deleteOwner(owner.unWrappedUsername)
        }
        gitBookState.listOfOwners.remove(atOffsets: offsets)
    }
    
    func inject(with appDIContainer: AppDIContainer, with gitBookState: GitBookState) {
        self.appDIContainer = appDIContainer
        self.gitBookState = gitBookState
    }
}
