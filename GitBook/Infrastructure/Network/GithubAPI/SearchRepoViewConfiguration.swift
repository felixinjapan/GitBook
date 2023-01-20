//
//  APIConfiguration.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation

// MARK: - SearchRepoViewConfiguration

final class SearchRepoViewConfiguration {
    lazy var apiMaxNumCall: Int = {
        guard let strValue = Bundle.main.object(forInfoDictionaryKey: Constants.InfoDictionaryKey.apiMaxNumCall.rawValue) as? String else {
            fatalError("apiMaxNumCall not found")
        }
        guard let apiMaxNumCall = Int(strValue) else {
            fatalError("apiRetryCount must be an integer")
        }
        return apiMaxNumCall
    }()
    
    lazy var apiSleepPeriodSec: Int = {
        guard let strValue = Bundle.main.object(forInfoDictionaryKey: Constants.InfoDictionaryKey.apiSleepPeriodSec.rawValue) as? String else {
            fatalError("apiSleepPeriodSec not found")
        }

        guard let apiSleepPeriodSec = Int(strValue) else {
            fatalError("apiRetryCount must be an integer")
        }
        return apiSleepPeriodSec
    }()
}
