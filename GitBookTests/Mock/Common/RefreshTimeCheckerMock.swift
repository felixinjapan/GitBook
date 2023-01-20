//
//  RefreshTimeCheckerMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/20.
//

import Foundation

// MARK: Refresh Time Checker - Ready
final class RefreshTimeCheckerCallReadyMock: RefreshTimeChecker {
    var callCount: Int = 0

    func increaseCount() {
        callCount+=1
    }

    func canCallAgain(maxNumOfCallAllowed: Int) -> Bool {
        return true
    }

    func resetTimer() { }

    func canCallAgain(now: Date, threshold: Int) -> Bool {
        return true
    }
}
// MARK: Refresh Time Checker - Not ready
final class RefreshTimeCheckerCallNotReadyMock: RefreshTimeChecker {
    var callCount: Int = 10

    func increaseCount() {
        callCount+=1
    }

    func canCallAgain(maxNumOfCallAllowed: Int) -> Bool {
        return false
    }

    func resetTimer() { }

    func canCallAgain(now: Date, threshold: Int) -> Bool {
        return false
    }
}
