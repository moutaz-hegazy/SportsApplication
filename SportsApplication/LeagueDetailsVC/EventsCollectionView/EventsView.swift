//
//  EventsView.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class EventsView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var shownEvents : [Event] = []{
        didSet{
            eventsCollectionView?.reloadData()
        }
    }
    
    private let width = UIScreen.main.bounds.height
    
    @IBOutlet weak var eventsCollectionView: UICollectionView!

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath)
        
        if let eventCell = cell as? EventCollectionViewCell{
            eventCell.eventNameLbl.text = shownEvents[indexPath.item].eventName
            eventCell.eventDateLbl.text = shownEvents[indexPath.item].eventDate
            eventCell.eventTimeLbl.text = shownEvents[indexPath.item].eventTime
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width - 40, height: collectionView.bounds.size.height-20)
    }
    
    
    //MARK:- my functions
    

}
