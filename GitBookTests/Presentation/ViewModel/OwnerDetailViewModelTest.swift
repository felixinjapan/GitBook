//
//  OwnerDetailViewModelTest.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/18.
//

import Foundation
import XCTest

final class OwnerDetailViewModelTest: XCTestCase {

    func test_whenGetRepoCalledFirstTime_shouldCallAPIAndUpdateState() {
        // given
        /// expectation
        let fetchExpectation = self.expectation(description: "Should trigger the get repo api call")
        let storeExpectation = self.expectation(description: "Should trigger the save repo in core data")
        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fetchDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_FirstTimeLaunch()
        let state = GitBookState()
        let sut = DefaultOwnerDetailViewModel()

        storeDataUseCaseMock.repoExpectation = storeExpectation
        fetchDataUseCaseMock.repoExpectation = fetchExpectation

        appDIContainer.fetchDataUsecase = fetchDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.getRepo(with: OwnerMock())
        
        // then
        XCTAssertNotEqual(state.currentRepoList.count, 0)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenGetRepoCalledSecondTime_shouldNotCallAPIAndUpdateState() {
        // given
        /// expectation
        let fetchExpectation = self.expectation(description: "Should trigger the get repo api call")
        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fecthDataUseCaseMock = FetchDataUseCaseMock_SecondTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_SecondTimeLaunch()
        let state = GitBookState()
        let sut = DefaultOwnerDetailViewModel()

        fecthDataUseCaseMock.repoExpectation = fetchExpectation

        appDIContainer.fetchDataUsecase = fecthDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.getRepo(with: OwnerMock())

        // then
        XCTAssertNotEqual(state.currentRepoList.count, 0)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenRefreshCalled_shouldCallAPIAndUpdateState() {
        // given
        /// expectation
        let fetchOwnerExpectation = self.expectation(description: "Should trigger the get owner api call")
        let fetchRepoExpectation = self.expectation(description: "Should trigger the get repo api call")

        let storeOwnerExpectation = self.expectation(description: "Should trigger the save owner in core data")
        let storeRepoExpectation = self.expectation(description: "Should trigger the save repo in core data")

        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fetchDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_RefreshTest()
        let state = GitBookState()
        for idx in 1...10 {
            let ownerMock = OwnerMock()
            ownerMock.id = Int64(idx)
            state.listOfOwners.append(OwnerMock())
        }

        let sut = DefaultOwnerDetailViewModel()

        let owner = OwnerMock()

        storeDataUseCaseMock.ownerExpectation = storeOwnerExpectation
        storeDataUseCaseMock.repoExpectation = storeRepoExpectation

        fetchDataUseCaseMock.ownerExpectation = fetchOwnerExpectation
        fetchDataUseCaseMock.repoExpectation = fetchRepoExpectation

        appDIContainer.fetchDataUsecase = fetchDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.refresh(with: owner)

        // then
        XCTAssertEqual(state.currentRepoList.count, 1)
        XCTAssertEqual(state.listOfOwners.count, 10)
        XCTAssertTrue(state.isRepoListLoaded)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenRefreshIsAllowed_shouldUpdateCorrectState() {
        // given
        let timeCheckerCallAgainTrue = RefreshTimeCheckerCallReadyMock()
        let sut = DefaultOwnerDetailViewModel(refreshTimeChecker: timeCheckerCallAgainTrue)
        /// expectation
        let fetchOwnerExpectation = self.expectation(description: "Should trigger the get owner api call")
        let fetchRepoExpectation = self.expectation(description: "Should trigger the get repo api call")

        let storeOwnerExpectation = self.expectation(description: "Should trigger the save owner in core data")
        let storeRepoExpectation = self.expectation(description: "Should trigger the save repo in core data")

        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fetchDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_RefreshTest()
        fetchDataUseCaseMock.repoExpectation = fetchRepoExpectation
        fetchDataUseCaseMock.ownerExpectation = fetchOwnerExpectation
        storeDataUseCaseMock.repoExpectation = storeRepoExpectation
        storeDataUseCaseMock.ownerExpectation = storeOwnerExpectation

        appDIContainer.fetchDataUsecase = fetchDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock

        let state = GitBookState()

        // when
        sut.appDIContainer = appDIContainer
        sut.gitBookState = state
        sut.refresh(with: OwnerMock())

        // then
        XCTAssertEqual(state.currentRepoList.count, 1)
        XCTAssertFalse(state.showTooManyCallAlert)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func test_whenRefreshIsNotAllowed_shouldFallInFailure() {
        // given
        let timeCheckerCallAgainTrue = RefreshTimeCheckerCallNotReadyMock()
        let sut = DefaultOwnerDetailViewModel(refreshTimeChecker: timeCheckerCallAgainTrue)

        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())

        let state = GitBookState()

        // when
        sut.appDIContainer = appDIContainer
        sut.gitBookState = state
        sut.refresh(with: OwnerMock())

        // then
        XCTAssertEqual(state.currentRepoList.count, 0)
        XCTAssertTrue(state.showTooManyCallAlert)
    }
}
