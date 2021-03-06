//
//  TeamsView.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class TeamsView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var leagueTeams = [TeamData](){
        didSet{
            teamsCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var teamsCollectionView : UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagueTeams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath)
        
        if let teamCell = cell as? TeamCollectionViewCell{
            if let badgeStr = leagueTeams[indexPath.item].teamBadge{
                teamCell.loadTeamBadge(from: badgeStr)
                teamCell.imgViewHeight.constant = collectionView.bounds.height - 30
                teamCell.teamImgView.layer.cornerRadius = (collectionView.bounds.height - 30)/2
            }
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height-20, height: collectionView.bounds.height-20)
    }
    

}
