//
//  ResultsView.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class ResultsView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var resultsCollectionView : UICollectionView!
    
    var resultsArray = [Results](){
        didSet{
            resultsCollectionView.reloadData()
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath)
        
        if let resultCell = cell as? ResultsCollectionViewCell{
            resultCell.dateLbl.text = resultsArray[indexPath.item].date
            resultCell.homeTeamLbl.text = resultsArray[indexPath.item].homeTeam
            resultCell.awayTeamLbl.text = resultsArray[indexPath.item].awayTeam
            resultCell.homeResultLbl.text = resultsArray[indexPath.item].homeTeamScore
            resultCell.awayResultLbl.text = resultsArray[indexPath.item].awayTeamScore
            resultCell.timeLbl.text = resultsArray[indexPath.item].time
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20, height: collectionView.bounds.height - 40)
    }

}
