//
//  UserListViewModelTest.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/17.
//

import Foundation
import XCTest

final class UserListViewModelTest: XCTestCase {

    func test_whenGetOwnerCalledFirstTime_shouldCallAPIAndUpdateState() {
        // given
        /// expectation
        let fetchExpectation = self.expectation(description: "Should trigger the get owner api call")
        let storeExpectation = self.expectation(description: "Should trigger the save owner in core data")
        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fecthDataUseCaseMock = FetchDataUseCaseMock_FirstTimeLaunch()
        let storeDataUseCaseMock = StoreDataUseCaseMock_FirstTimeLaunch()
        let state = GitBookState()
        let sut = DefaultUserListViewModel()

        storeDataUseCaseMock.ownerExpectation = storeExpectation
        fecthDataUseCaseMock.ownerExpectation = fetchExpectation

        appDIContainer.fetchDataUsecase = fecthDataUseCaseMock
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.getOwner(with: "myOwner")

        // then
        XCTAssertNotEqual(state.listOfOwners.count, 0)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenGetOwnerCalledSecondTime_shouldFetchCoreDataAndUpdateState() {
        // given
        /// expectation
        let fetchExpectation = self.expectation(description: "Should trigger the get owner core data")
        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let fecthDataUseCaseMock = FetchDataUseCaseMock_SecondTimeLaunch()
        let state = GitBookState()
        let sut = DefaultUserListViewModel()

        fecthDataUseCaseMock.ownerExpectation = fetchExpectation
        appDIContainer.fetchDataUsecase = fecthDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.getOwner(with: "myOwner")

        // then
        XCTAssertNotEqual(state.listOfOwners.count, 0)
        waitForExpectations(timeout: 3, handler: nil)
    }

    func test_whenDeleteUser_shouldFetchCoreDataAndUpdateState() {
        // given
        /// expectation
        let storeExpectation = self.expectation(description: "Should trigger the delete operation")
        /// mocking
        let appDIContainer = AppDIContainer(respositoryContainer: RepositoryMock())
        let storeDataUseCaseMock = StoreDataUseCaseMock_DeleteTest()
        let state = GitBookState()
        for idx in 1...10 {
            let ownerMock = OwnerMock()
            ownerMock.id = Int64(idx)
            state.listOfOwners.append(OwnerMock())
        }

        let sut = DefaultUserListViewModel()

        storeDataUseCaseMock.expectation = storeExpectation
        appDIContainer.storeDataUsecase = storeDataUseCaseMock
        sut.gitBookState = state
        sut.appDIContainer = appDIContainer

        // when
        sut.deleteData(at: IndexSet(integersIn: 4...4))

        // then
        XCTAssertEqual(state.listOfOwners.count, 9)
        for owner in state.listOfOwners {
            if owner.id == 4 {
                XCTFail()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
}
