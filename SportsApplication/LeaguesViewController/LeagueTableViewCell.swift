//
//  LeagueTableViewCell.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/3/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit
import Alamofire

class LeagueTableViewCell: UITableViewCell {

    
    private var youtubeLink : String?
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func playVideo(_ sender: Any) {
        if let urlStr = youtubeLink,let url = URL(string: "https://\(urlStr)"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func loadLeagueImage(from urlString : String){
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
                self?.leagueImgView?.image = UIImage(data: imgData)
            }
        }
    }
    
    
    
    func fetchLeagueBadge(for leagueID:String?){
        guard let ID = leagueID else {
            return
        }
        let request = AF.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(ID)")
        
        request.responseJSON {[weak self](response) in
            switch(response.result)
            {
            case .success(let data):
                guard let recievedDict = data as? [String:Any] else {
                    return
                }
                guard let dataArr = recievedDict["leagues"] as? [Any] else{
                    return
                }
                guard let dataDict = dataArr[0] as?[String:Any] else {
                    return
                }
                
                guard let badgeStr = dataDict["strBadge"] as? String else{
                    return;
                }
                self?.loadLeagueImage(from: badgeStr)
                self?.youtubeLink = dataDict["strYoutube"] as? String
                DispatchQueue.main.async {
                    if let link  = self?.youtubeLink , !link.isEmpty{
                        print("\(link)<<<<<<<<<")
                        self?.youTubeBtn?.isHidden = false
                    }else{
                        self?.youTubeBtn?.isHidden = true
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
