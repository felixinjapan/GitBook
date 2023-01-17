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
    func canCallAgain(now: Date, threshold: Int) -> Bool
}

// MARK: - RefreshTimeChecker Implementation

final class DefaultAPIRefreshTimeChecker: RefreshTimeChecker {
    private var defaults = UserDefaults.standard
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
}
