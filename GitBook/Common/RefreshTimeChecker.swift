//
//  RefreshTimeChecker.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/20.
//

import Foundation

// MARK: - RefreshTimeChecker

protocol RefreshTimeChecker {
    func resetTimer()
    func increaseCount()
    func canCallAgain(maxNumOfCallAllowed: Int) -> Bool
    func canCallAgain(now: Date, threshold: Int) -> Bool
}

// MARK: - RefreshTimeChecker Implementation

final class DefaultAPIRefreshTimeChecker: RefreshTimeChecker {
    private var defaults = UserDefaults.standard
    private var callcCount = 0
    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }

    func resetTimer() {
        defaults.set(Date(), forKey: Constants.GithubAPI.lastApiRun.rawValue)
    }

    func canCallAgain(now: Date, threshold: Int) -> Bool {
        if let from = defaults.value(forKey: Constants.GithubAPI.lastApiRun.rawValue) as? Date {
            let diffComponents = Calendar.current.dateComponents([.second], from: from, to: now)
            guard let sec = diffComponents.second else { return false }
            return sec > threshold
        }
        // first run or time expired
        return true
    }

    func increaseCount() {
        self.callcCount+=1
    }

    func canCallAgain(maxNumOfCallAllowed: Int) -> Bool {
        if maxNumOfCallAllowed > callcCount {
            return true
        }
        // initiate timer
        resetTimer()
        self.callcCount = 0
        return false
    }
}
