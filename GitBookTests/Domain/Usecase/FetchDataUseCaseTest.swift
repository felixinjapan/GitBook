//
//  FetchDataUseCaseTest.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/20.
//
import XCTest

final class FetchDataUseCaseTest: XCTestCase {
    
    func test_whenSaveOwner_shouldCallCoreData() {
        let sut = DefaultFetchDataUseCase(repositoryContainer: RepositoryMock())
        let res = sut.getOwnerFromCoreData(with: "myOwner")
        XCTAssertNotNil(res)
    }
    
    func test_whenGetRepos_shouldCallCoreData() {
        let sut = DefaultFetchDataUseCase(repositoryContainer: RepositoryMock())
        let res = sut.getReposFromCoreData(with: OwnerMock())
        XCTAssertNotEqual(res.count, 0)
    }
    
    func test_whenGetOwnerList_shouldCallCoreData() {
        let sut = DefaultFetchDataUseCase(repositoryContainer: RepositoryMock())
        let res = sut.getOwnerListFromCoreData()
        XCTAssertNotEqual(res.count, 0)
    }
    
    func test_whenGetOwnerFromAPI_shouldCallFromAPI() {
        let expectation = self.expectation(description: "Should get response")
        
        let sut = DefaultFetchDataUseCase(repositoryContainer: RepositoryMock())
        let _ = sut.getOwnerFromAPI(with: "myOwner"){ res in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_whenGetRepoFromAPI_shouldCallFromAPI() {
        let expectation = self.expectation(description: "Should get response")
        
        let sut = DefaultFetchDataUseCase(repositoryContainer: RepositoryMock())
        let _ = sut.getRepoFromAPI(with: "myOwner", state: GitBookState()) { res in
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func test_whenGetOwnerFromAPIFailed_shouldNotReceiveRes() {
        let repositoryMock = RepositoryMock()
        let apiRepoMock = APIRepositoryMock_Failure()
        repositoryMock.apiRepository = apiRepoMock
        let sut = DefaultFetchDataUseCase(repositoryContainer: repositoryMock)
        
        let _ = sut.getOwnerFromAPI(with: "myOwner"){ res in
            XCTFail()
        }
    }
    
    func test_whenGetRepoFromAPIFailed_shouldNotReceiveRes() {
        let repositoryMock = RepositoryMock()
        let apiRepoMock = APIRepositoryMock_Failure()
        repositoryMock.apiRepository = apiRepoMock
        let sut = DefaultFetchDataUseCase(repositoryContainer: repositoryMock)
        
        let _ = sut.getRepoFromAPI(with: "myOwner", state: GitBookState()){ res in
            XCTFail()
        }
    }
}
