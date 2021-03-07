//
//  CoreDataLayer.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/6/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataLayer{
    
    private(set) var storedLeagues = [StoredLeague]()
    private static var coreDataObj = CoreDataLayer()
    static var shared : CoreDataLayer {
        get{
            coreDataObj.getDataFromStorage()
            return coreDataObj
        }
    }
    
    //MARK:- Core Data Methods
    private func getDataFromStorage(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest : NSFetchRequest<StoredLeague> = StoredLeague.fetchRequest()
            do{
                storedLeagues = try managedContext.fetch(fetchRequest)
            }catch let error as NSError{
                print(error)
            }
        }
    }

    
    func addLeagueToStorage(_ league: League){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext

            if league.leagueName != nil,!(isLeagueFound(with: league.leagueID) ?? true){
                let newLeague = StoredLeague(context: managedContext)
                newLeague.leagueID = league.leagueID
                newLeague.leagueName = league.leagueName
                newLeague.sportName = league.sportName
                newLeague.youtubeLink = league.youtubeLink
                newLeague.badge = league.badge
                
                storedLeagues += [newLeague]
                
                do{
                    try managedContext.save()
                    print("<<<<< SAVED")
                }catch let error as NSError{
                    print(error)
                }
            }
        }
    }
    
    private func isLeagueFound(with leagueID : String?)->Bool?{
        guard let id = leagueID else{
            return nil
        }
        if storedLeagues.count == 0{
            getDataFromStorage()
        }
        for league in storedLeagues{
            if(league.leagueID == id){
                return true
            }
        }
        return false
    }
    
    

    func deleteFromStorage(at index:Int ){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(storedLeagues[index])
            storedLeagues.remove(at: index)
            do{
                try managedContext.save();
                print("item Deleted")
            }catch let error as NSError{
                print(error);
            }
        }
    }

//    func deleteFromStorageIfExistsWith(title : String){
//        getDataFromStorage()
//        for movie in stordMovies{
//            if movie.title == title{
//                if let index = stordMovies.firstIndex(of: movie){
//                    deleteFromStorage(at: index)
//                    stordMovies.remove(at: index)
//                }
//            }
//        }
//    }
//
//    private func deleteAllFromStorage(){
//        if(displayLocally){
//            for index in stordMovies.indices{
//                deleteFromStorage(at: index)
//            }
//            stordMovies.removeAll()
//            tableView.reloadData()
//            reloadFromWeb()
//        }
//    }
}
