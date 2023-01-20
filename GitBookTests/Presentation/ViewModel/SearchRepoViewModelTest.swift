//
//  SearchRepoViewModelTest.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2023/01/20.
//

import Foundation
import XCTest

final class SearchRepoViewModelTest: XCTestCase {

    func test_whenGetRepoCalledFirstTime_shouldCallAPIAndUpdateState() {
        // given
        let timeCheckerCallAgainTrue = RefreshTimeCheckerCallReadyMock()

        /// expectation
        let fetchExpectation = self.expectation(description: "Should trigger the get repo api call")
        let storeExpectation = self.expectation(description: "Should trigger the save repo in core data")
        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fetchDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_FirstTimeLaunch()
        let state = GitBookState()
        let sut = DefaultSearchRepoViewModel(refreshTimeChecker: timeCheckerCallAgainTrue)

        storeDataUseCaseMock.repoExpectation = storeExpectation
        fetchDataUseCaseMock.repoExpectation = fetchExpectation

        appDIContainer.fetchDataUsecase = fetchDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.getRepo(query: "test", page: 1)

        // then
        XCTAssertNotEqual(state.searchRepoList.count, 0)
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
        let sut = DefaultSearchRepoViewModel()

        fecthDataUseCaseMock.repoExpectation = fetchExpectation

        appDIContainer.fetchDataUsecase = fecthDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.getRepo(query: "test", page: 1)

        // then
        XCTAssertNotEqual(state.searchRepoList.count, 0)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenAPICallIsNotAllowedAndRecordExists_shouldReturnStoredData() {
        // given
        let timeCheckerCallAgainTrue = RefreshTimeCheckerCallNotReadyMock()
        let sut = DefaultSearchRepoViewModel(refreshTimeChecker: timeCheckerCallAgainTrue)

        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())

        let state = GitBookState()

        // when
        sut.appDIContainer = appDIContainer
        sut.gitBookState = state
        sut.getRepo(query: "test", page: 1)

        // then
        XCTAssertEqual(state.searchRepoList.count, 1)
        XCTAssertFalse(state.showTooManyCallAlert)
    }

    func test_whenAPICallIsNotAllowedAndNoRecordExists_shouldReturnVoid() {
        // given
        let timeCheckerCallAgainTrue = RefreshTimeCheckerCallNotReadyMock()
        let sut = DefaultSearchRepoViewModel(refreshTimeChecker: timeCheckerCallAgainTrue)
        /// mocking store data use case
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fetchDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_FirstTimeLaunch()

        appDIContainer.fetchDataUsecase = fetchDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.appDIContainer = appDIContainer

        /// mocking state
        let state = GitBookState()
        sut.gitBookState = state

        // when
        sut.getRepo(query: "test", page: 1)

        // then
        XCTAssertEqual(state.searchRepoList.count, 0)
        XCTAssertTrue(state.showTooManyCallAlert)
    }

    func test_whenEmptyQueryPassed_shouldReturnVoid() {
        // given
        let timeCheckerCallAgainTrue = RefreshTimeCheckerCallNotReadyMock()
        let sut = DefaultSearchRepoViewModel(refreshTimeChecker: timeCheckerCallAgainTrue)
        /// mocking store data use case
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fetchDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_FirstTimeLaunch()

        appDIContainer.fetchDataUsecase = fetchDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.appDIContainer = appDIContainer

        /// mocking state
        let state = GitBookState()
        sut.gitBookState = state

        // when
        sut.getRepo(query: "", page: 1)

        // then
        XCTAssertEqual(state.searchRepoList.count, 0)
        XCTAssertFalse(state.showTooManyCallAlert)
    }
}
