//
//  SportCollectionViewCell.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/3/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImgView: UIImageView!
    @IBOutlet weak var sportLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var containerWidth: NSLayoutConstraint!
    
    
    
    
    func loadSportImage(from urlString : String){
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
                self?.sportImgView?.image = UIImage(data: imgData)
            }
        }
    }
}
