//
//  SportsCollectionViewController.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/3/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import Alamofire


private let reuseIdentifier = "sportCell"

class SportsCollectionViewController: UICollectionViewController {

    private var sportsArr : [Sport] = []
    private let width = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDataFromWeb()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Sports"
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sportsArr.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let sportCell = cell as? SportCollectionViewCell, let urlString = sportsArr[indexPath.item].sportThumbnail{
            sportCell.containerWidth.constant = width/2
            sportCell.loadSportImage(from: urlString)
            sportCell.sportLbl.text = sportsArr[indexPath.item].sportName
        }
        
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let leaguesVC = storyboard?.instantiateViewController(identifier: "leaguesVC") as? LeguesViewController else{
            return
        }
        leaguesVC.modalPresentationStyle = .fullScreen
        
        present(leaguesVC, animated: true) {
            [weak self] in
            
            if let sport = self?.sportsArr[indexPath.item].sportName{
                leaguesVC.navBar.topItem?.title = sport
                leaguesVC.retrieveLegues(for: sport)
            }
        }
        
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    // MARK:- my functions.
    
    private func retrieveDataFromWeb(){
        print("START RETREIVE")
        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
        
        request.responseJSON { [weak self] (response) in
            switch(response.result)
            {
            case .success(let data):
                guard let sportsDict = data as? [String:Any] else{
                    return
                }
                guard let arr = sportsDict["sports"] as? [Any] else{
                    return
                }
                
                for element in arr{
                    guard let sportData = element as? [String:String] else {
                        return
                    }
                    var newSport = Sport()
                    newSport.sportID = sportData["idSport"]
                    newSport.sportName = sportData["strSport"]
                    newSport.sportFormat = sportData["strFormat"]
                    newSport.sportThumbnail = sportData["strSportThumb"]
                    newSport.sportThumbnailGreen = sportData["strSportThumbGreen"]
                    newSport.sportDescription = sportData["strSportDescription"]
                    
                    self?.sportsArr += [newSport]
                }
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                

            case .failure(let error):
                    print(error)
            }
        }

    }

}
