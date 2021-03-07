//
//  LeagueTableViewCell.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/3/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import SDWebImage

private let leagueBadgeUrlStr = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="

class LeagueTableViewCell: UITableViewCell {

    
    private(set) var youtubeLink = ""
    var cellLinksHandler : ((String,String)->())?
    
    @IBOutlet weak var leagueLbl: UILabel!
    @IBOutlet weak var leagueImgView: UIImageView!{
        didSet{
            leagueImgView.layer.borderWidth = 5
            leagueImgView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
    }
    @IBOutlet weak var youTubeBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func playVideo(_ sender: Any) {
        if let url = URL(string: "https://\(youtubeLink)"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func loadLeagueImage(from urlString : String){
        leagueImgView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder.png"))
        spinner.stopAnimating()
        
    }
    
    
    
    func fetchLeagueBadge(for leagueID:String?){
        guard let ID = leagueID else {
            return
        }
        NetworkLayer.fetchData(from: leagueBadgeUrlStr+ID) {
            [unowned self]
            (data, error) in
            if error != nil{
                return
            }
            guard let recievedDict = data as? [String:Any]
                , let dataArr = recievedDict["leagues"] as? [Any]
                , let dataDict = dataArr[0] as? [String:Any]
                , let badgeStr = dataDict["strBadge"] as? String
                , let youTube = dataDict["strYoutube"] as? String else {
                return
            }
            
            self.cellLinksHandler?(badgeStr,self.youtubeLink)
            self.loadLeagueImage(from: badgeStr)
            self.youtubeLink = youTube
            DispatchQueue.main.async {
                if !self.youtubeLink.isEmpty{
                    self.youTubeBtn?.isHidden = false
                }else{
                    self.youTubeBtn?.isHidden = true
                }
            }
        }
    }
}
