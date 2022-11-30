//
//  Repo+CoreDataProperties.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//
//

import Foundation
import CoreData


extension Repo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repo> {
        return NSFetchRequest<Repo>(entityName: Constants.Coredata.repo.rawValue)
    }

    @NSManaged public var repoId: Int64
    @NSManaged public var repoFullName: String?
    @NSManaged public var stargazersCount: Int64
    @NSManaged public var language: String?
    @NSManaged public var repoUrl: String?
    @NSManaged public var fork: Bool
    @NSManaged public var desc: String?
    @NSManaged public var owner: Owner?

    var unwrappedName: String {
        self.repoFullName.ownerEntity_unwrapNameString()
    }

    var unwrappedLang: String {
        self.language.ownerEntity_unwrapNameString()
    }

    var unwrappedDesc: String {
        self.desc ?? ""
    }

    var getRepoUrl: URL? {
        if let str = self.repoUrl, let url = URL(string: str) {
            return url
        }
        return nil
    }
}

extension Repo : Identifiable {

}
