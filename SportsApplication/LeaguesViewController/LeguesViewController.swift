//
//  LeguesViewController.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/3/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

private let leaguesUrlStr = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"

class LeguesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AddToFav {

    var sportLeagues : [League] = []
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var leaguesTableView: UITableView!


    
    @IBAction func moveBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)
        
        if let leagueCell = cell as? LeagueTableViewCell{
            leagueCell.leagueLbl.text = sportLeagues[indexPath.row].leagueName
            leagueCell.fetchLeagueBadge(for: sportLeagues[indexPath.row].leagueID)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        if let leagueDetailsVC = storyboard?.instantiateViewController(identifier: "leagueDetailsVC") as? LeagueDetailsViewController{
            
            leagueDetailsVC.leagueID = sportLeagues[indexPath.row].leagueID
            leagueDetailsVC.modalPresentationStyle = .fullScreen
            leagueDetailsVC.modalTransitionStyle = .flipHorizontal
            
            present(leagueDetailsVC, animated: true) {
                [unowned self] in
                leagueDetailsVC.navBar.topItem?.title = self.sportLeagues[indexPath.row].leagueName
            }
            
        }
    
    }
    
    
    func addLeagueToFavourite(by ID: String) {
        
    }
    
    
     func retrieveLegues(for sport:String){
    
        NetworkLayer.fetchData(from: leaguesUrlStr) {
            [weak self]
            (data, error) in
            if(error != nil){
                //error handling
                return
            }
            guard let leagueDict = data as? [String:Any] else {
                return
            }
            guard let dataArr = leagueDict["leagues"] as? [Any] else{
                return
            }
            
            let leagues = dataArr.filter { (element) -> Bool in
                if let dataDict = element as?[String:String]{
                    if let sportName = dataDict["strSport"]{
                        if sport == sportName{
                            return true
                        }
                    }
                }
                return false
            }
            for league in leagues{
                if let leagueData = league as?[String:String]{
                    var newLeague = League()
                    newLeague.leagueID = leagueData["idLeague"]
                    newLeague.leagueName = leagueData["strLeague"]
                    newLeague.sportName = sport
                    newLeague.leagueAlternate = leagueData["strLeagueAlternate"]
                    self?.sportLeagues += [newLeague]
                    
                }
            }
            DispatchQueue.main.async {
                self?.leaguesTableView?.reloadData()
            }
        }
    }
}
