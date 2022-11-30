//
//  RefreshTimeCheckerMock.swift
//  GitBookTests
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/20.
//

import Foundation

// MARK: Refresh Time Checker - Ready
final class RefreshTimeCheckerCallReadyMock: RefreshTimeChecker {
    func resetTimer() { }

    func canCallAgain(now: Date, threshold: Int) -> Bool {
        return true
    }
}
// MARK: Refresh Time Checker - Not ready
final class RefreshTimeCheckerCallNotReadyMock: RefreshTimeChecker {
    func resetTimer() { }

    func canCallAgain(now: Date, threshold: Int) -> Bool {
        return false
    }
}
