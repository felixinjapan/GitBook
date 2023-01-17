//
//  GithubAPIRepositoryTest.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/20.
//

import XCTest

final class GithubAPIRepositoryTest: XCTestCase {

    func test_whenGetRepoCalled_shouldReturnCorrectState() {
        // given
        let expectation = self.expectation(description: "should call successfully")
        let sut = DefaultGithubAPIRepository()
        let cancelBag = CancelBag()

        // when
        sut.getRepo(with: "myOwner").sink(receiveCompletion: {
            if case .failure = $0 {
                XCTFail()
            }
        }, receiveValue: {_ in
            expectation.fulfill()
        }).store(in: cancelBag)

        // then
        waitForExpectations(timeout: 7, handler: nil)
    }

    func test_whenGetOwnerCalled_shouldReturnCorrectState() {
        // given
        let expectation = self.expectation(description: "should call successfully")
        let sut = DefaultGithubAPIRepository()
        let cancelBag = CancelBag()

        // when
        sut.getOwner(with: "myOwner").sink(receiveCompletion: {
            if case .failure = $0 {
                XCTFail()
            }
        }, receiveValue: {_ in
            expectation.fulfill()
        }).store(in: cancelBag)

        // then
        waitForExpectations(timeout: 7, handler: nil)
    }
}
