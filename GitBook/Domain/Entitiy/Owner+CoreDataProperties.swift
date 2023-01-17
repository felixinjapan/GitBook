//
//  Owner+CoreDataProperties.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//
//

import Foundation
import CoreData


extension Owner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: Constants.Coredata.owner.rawValue)
    }

    @NSManaged public var username: String?
    @NSManaged public var id: Int64
    @NSManaged public var avatarUrl: String?
    @NSManaged public var fullname: String?
    @NSManaged public var followers: Int64
    @NSManaged public var following: Int64
    @NSManaged public var repos: Repo?

    var unWrappedUsername: String {
        username.ownerEntity_unwrapNameString()
    }

    var unWrappedFullName: String {
        fullname.ownerEntity_unwrapNameString()
    }

    var unwrappedAvatarUrl: URL? {
        if let url = avatarUrl {
            return URL(string: url)
        }
        return nil
    }
}

// MARK: Generated accessors for repos
extension Owner {

    @objc(addReposObject:)
    @NSManaged public func addToRepos(_ value: Repo)

    @objc(removeReposObject:)
    @NSManaged public func removeFromRepos(_ value: Repo)

    @objc(addRepos:)
    @NSManaged public func addToRepos(_ values: NSSet)

    @objc(removeRepos:)
    @NSManaged public func removeFromRepos(_ values: NSSet)

}

extension Owner : Identifiable {

}

extension Optional where Wrapped == String {
    func ownerEntity_unwrapNameString() -> String {
        return self ?? Constants.General.unknown.rawValue
    }
}

