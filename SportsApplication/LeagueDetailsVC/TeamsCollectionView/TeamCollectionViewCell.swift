//
//  TeamCollectionViewCell.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/5/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImgView: UIImageView!{
        didSet{
            teamImgView.layer.borderWidth = 5
            teamImgView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
    }
    @IBOutlet weak var imgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func loadTeamBadge(from urlString : String){
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imgData = try? Data(contentsOf: url) else{
                return
            }
            DispatchQueue.main.async {
                [weak self] in
                self?.spinner.stopAnimating()
                self?.teamImgView.image = UIImage(data: imgData)
            }
        }
    }
    
}
