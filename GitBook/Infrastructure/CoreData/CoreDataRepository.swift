//
//  CoreDataRepository.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//

import Foundation
import CoreData
import os

protocol CoreDataRepository {
    var container: NSPersistentContainer { get }
    /// read
    func fetchRepoLists(owner: Owner) -> [Repo]
    func fetchOwner(username: String) -> Owner?
    func fetchAllOwnerList() -> [Owner]
    /// create
    func insertOwner(ownerResponse: OwnerResponse) -> Owner
    func insertOwner(username: String) -> Owner
    func insertRepo(res: RepoResponse, owner: Owner) -> Repo
    /// update
    func updateOwner(res: OwnerResponse, owner: Owner)
    /// delete
    func deleteRepos(_ owner: Owner)
    func deleteOwner(_ username: String)
    func saveData()
}

final class DefaultCoreDataRepository: CoreDataRepository {
    let container: NSPersistentContainer
    let logger = Logger(subsystem: Constants.Logging.subsystem.rawValue, category: String(describing: DefaultCoreDataRepository.self))
    
    init(container: NSPersistentContainer) {
        self.container = container
    }

    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error as NSError {
            logger.error("failed to save \(String(describing: error))")
        }
    }
}

// MARK: - READ Implementation

extension DefaultCoreDataRepository {
    
    func fetchOwner(username: String) -> Owner? {
        let fetchRequest = NSFetchRequest<Owner>(entityName: Constants.Coredata.owner.rawValue)
        fetchRequest.predicate = NSPredicate(format: "username = %@", username)
        do {
            let ownerList = try self.container.viewContext.fetch(fetchRequest)
            return ownerList.first
        } catch let error as NSError {
            logger.error("fetching Repo Entity with \(username) failed \(String(describing: error))")
        }
        return nil
    }

    func fetchAllOwnerList() -> [Owner] {
        let fetchRequest:NSFetchRequest<Owner> = Owner.fetchRequest()
        fetchRequest.predicate =  NSPredicate(format: "id > %i", 0)
        do {
            let ownerList = try self.container.viewContext.fetch(fetchRequest)
            return ownerList
        } catch let error as NSError {
            logger.error("fetching all owner list failed \(String(describing: error))")
        }
        return [Owner]()
    }

    func fetchRepoLists(owner: Owner) -> [Repo] {
        let fetchRequest = NSFetchRequest<Repo>(entityName: Constants.Coredata.repo.rawValue)
        fetchRequest.predicate = NSPredicate(format: "owner = %@", owner)
        let sortDescriptor = NSSortDescriptor(key: "repoFullName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let repoList = try self.container.viewContext.fetch(fetchRequest)
            return repoList
        } catch let error as NSError {
            logger.error("fetching Repo Entity with \(owner.unWrappedUsername) failed \(String(describing: error))")
        }
        return [Repo]()
    }
}

// MARK: - UPDATE Implementation

extension DefaultCoreDataRepository {
    func updateOwner(res: OwnerResponse, owner: Owner) {
        owner.username = res.username
        owner.id = res.id
        owner.followers = res.followers
        owner.following = res.following
        owner.avatarUrl = res.avatarUrl
        owner.fullname = res.fullname
    }
}

// MARK: - CREATE Implementation

extension DefaultCoreDataRepository {

    func insertOwner(ownerResponse: OwnerResponse) -> Owner {
        let ownerEntity = Owner(context: container.viewContext)
        ownerEntity.username = ownerResponse.username
        ownerEntity.id = ownerResponse.id
        ownerEntity.followers = ownerResponse.followers
        ownerEntity.following = ownerResponse.following
        ownerEntity.avatarUrl = ownerResponse.avatarUrl
        ownerEntity.fullname = ownerResponse.fullname
        
        return ownerEntity
    }

    func insertOwner(username: String) -> Owner {
        let ownerEntity = Owner(context: container.viewContext)
        ownerEntity.username = username
        return ownerEntity
    }

    func insertRepo(res: RepoResponse, owner: Owner) -> Repo {
        let repoEntity = Repo(context: container.viewContext)
        repoEntity.repoId = res.id
        repoEntity.language = res.language
        repoEntity.stargazersCount = res.stargazersCount
        repoEntity.repoUrl = res.url
        repoEntity.desc = res.desc
        repoEntity.repoFullName = res.repoFullName
        repoEntity.fork = res.fork
        owner.addToRepos(repoEntity)
        
        return repoEntity
    }
}

// MARK: - DELETE Implementation

extension DefaultCoreDataRepository {
    func deleteOwner(_ username: String){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Constants.Coredata.owner.rawValue)
        fetchRequest.predicate = NSPredicate(format: "username = %@", username)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try self.container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            logger.error("failed to save \(String(describing: error))")
        }
    }

    func deleteRepos(_ owner: Owner){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Constants.Coredata.owner.rawValue)
        fetchRequest.predicate = NSPredicate(format: "owner = %@", owner)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try self.container.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            logger.error("failed to save \(String(describing: error))")
        }
    }
}
