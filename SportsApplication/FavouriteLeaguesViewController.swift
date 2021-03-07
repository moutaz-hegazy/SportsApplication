//
//  FavouriteLeaguesViewController.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/6/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import Alamofire

class FavouriteLeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var leaguesTableView: UITableView!
    
    
    private lazy var coreDataManager = CoreDataLayer.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        leaguesTableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.storedLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)
        
        if let leagueCell = cell as? LeagueTableViewCell{
            leagueCell.leagueLbl.text = coreDataManager.storedLeagues[indexPath.row].leagueName
            if let imageUrl = coreDataManager.storedLeagues[indexPath.row].badge{
                leagueCell.loadLeagueImage(from : imageUrl)
                print("\(imageUrl) <<<< IN LOAD")
            }else{
                print("BIG NULL!!!")
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let check = NetworkReachabilityManager()?.isReachable,check{
            if let leagueDetailsVC = storyboard?.instantiateViewController(identifier: "leagueDetailsVC") as? LeagueDetailsViewController{
                
                leagueDetailsVC.leagueID = coreDataManager.storedLeagues[indexPath.row].leagueID
                leagueDetailsVC.modalPresentationStyle = .fullScreen
                leagueDetailsVC.modalTransitionStyle = .flipHorizontal
                
                present(leagueDetailsVC, animated: true) {
                    [unowned self] in
                    leagueDetailsVC.navBar.topItem?.title = self.coreDataManager.storedLeagues[indexPath.row].leagueName
                    leagueDetailsVC.favBarButton.title = ""
                    leagueDetailsVC.favBarButton.isEnabled = false
                }
            }
        }else{
            let alert = UIAlertController(title: "Internet is turned off", message: "please ensure you are connected to the internet", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataManager.deleteFromStorage(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
