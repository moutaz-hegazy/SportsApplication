//
//  StoredLeague+CoreDataProperties.swift
//  
//
//  Created by moutaz hegazy on 3/6/21.
//
//

import Foundation
import CoreData


extension StoredLeague {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredLeague> {
        return NSFetchRequest<StoredLeague>(entityName: "StoredLeague")
    }

    @NSManaged public var youtubeLink: String?
    @NSManaged public var badge: String?
    @NSManaged public var sportName: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var leagueID: String?

}
