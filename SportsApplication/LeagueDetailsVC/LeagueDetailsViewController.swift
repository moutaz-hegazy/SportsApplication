//
//  LeagueDetailsViewController.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import Alamofire


private let eventsLink = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
private let resultsLink = "https://www.thesportsdb.com/api/v1/json/1/lookupevent.php?id="
private let teamsLink = "https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id="

class LeagueDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var eventView: EventsView!
    @IBOutlet weak var resultsView: ResultsView!
    @IBOutlet weak var teamsView: TeamsView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var leagueID : String?
    
    var eventsID = [String?]()
    
    @IBAction func backToCaller(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadEvents()
        loadTeams()
    }
    
    
    
    @IBAction func addToFavourite(_ sender: Any) {
    }
    
    
    
    //MARK:- may functions
    
    private func loadEvents(){
        guard let id = leagueID else {
            return
        }
        NetworkLayer.fetchData(from:eventsLink + id){
            [unowned self](data,error) in
            if error != nil{
                // error code
                return
            }
            
            var eventsArr = [Event]()
            guard let dataDict = data as? [String:Any]
                ,let dataArr = dataDict["events"] as? [Any] else{
                return
            }
            for element in dataArr{
                guard let elementDict = element as? [String:Any] else{
                    return
                }
                //print("wezza: >> \(elementDict["strEvent"] ?? "NONE")")
                var newEvent = Event()
                newEvent.eventID = elementDict["idEvent"] as? String
                self.eventsID += [newEvent.eventID]
                newEvent.eventName = elementDict["strEvent"] as? String
                newEvent.eventDate = elementDict["dateEvent"] as? String
                newEvent.eventTime = elementDict["strTime"] as? String
                eventsArr += [newEvent]
            }
            self.eventView.shownEvents = eventsArr
            self.loadResults()
        }
    }
    
    private func loadResults(){
        for idString in eventsID{
            guard let id = idString else {
                continue
            }
            NetworkLayer.fetchData(from: "\(resultsLink)\(id)") {
                [unowned self]
                (data, error) in
                if error != nil{
                    //error handling
                    return
                }
                guard let dataDict = data as? [String:Any]
                    ,let dataArr = dataDict["events"] as? [Any]
                    ,let event = dataArr[0] as? [String:Any] else{
                    return
                }
                
                var result = Results()
                result.homeTeam = event["strHomeTeam"] as? String
                result.homeTeamScore = event["intHomeScore"] as? String
                result.awayTeam = event["strAwayTeam"] as? String
                result.awayTeamScore = event["intAwayScore"] as? String
                result.date = event["dateEvent"] as? String
                result.time = event["strTime"] as? String
                self.resultsView.resultsArray += [result]
            }
        }
    }
    
    private func loadTeams(){
        guard let id = leagueID else{
            return
        }
        
        NetworkLayer.fetchData(from: teamsLink+id) {
            [unowned self]
            (data, error) in
            if error != nil{
                //error handle
                return
            }
            
            guard let teamsData = data as? [String:Any],
                let teamsArray = teamsData["teams"] as? [Any] else{
                    return
            }
            var teams = [TeamData]()
            for team in teamsArray{
                guard let teamData = team as? [String:Any] else{
                    continue
                }
                var newTeam = TeamData()
                newTeam.teamID = teamData["idTeam"] as? String
                newTeam.teamName = teamData["strTeam"] as? String
                newTeam.leagueName = teamData["strLeague"] as? String
                newTeam.sportName = teamData["strSport"] as? String
                newTeam.teamBadge = teamData["strTeamBadge"] as? String
                
                teams += [newTeam]
            }
            self.teamsView.leagueTeams = teams
        }
    }
}
