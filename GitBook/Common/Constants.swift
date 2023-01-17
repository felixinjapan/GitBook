//
//  Constants.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import Foundation

enum Constants {
    enum GithubAPI: String {
        case oauthKey = "Authorization"
        case oauthValuePrefix = "Bearer"
        case owner = "owner"
        case lastApiRun = "lastApiRun"
        case getMethod = "GET"
    }
    enum Coredata: String {
        case nameDataModel = "GitBook"
        case repo = "Repo"
        case owner = "Owner"
    }
    enum InfoDictionaryKey: String {
        case token = "Token"
        case apiBaseURL = "ApiBaseURL"
        case getOwnerInfoPath = "GetOwnerInfoPath"
        case getOwnerRepoInfoPath = "GetOwnerRepoInfoPath"
        case apiRetryCount = "ApiRetryCount"
        case apiTimeoutInSec = "ApiTimeoutInSec"
    }
    enum General: String {
        case unknown = "unknown"
        case emptyString = ""
    }
    enum Logging: String {
        case subsystem = "jp.co.felixinjapan.Gitbook"
    }
}
