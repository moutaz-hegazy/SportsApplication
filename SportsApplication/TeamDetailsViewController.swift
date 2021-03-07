//
//  TeamDetailsViewController.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/7/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var team : TeamData?
    
    @IBOutlet weak var teamNameLbl: UILabel!
    @IBOutlet weak var teamBadgeView: UIImageView!
    @IBOutlet weak var leagueNameLbl: UILabel!
    @IBOutlet weak var sportNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        teamBadgeView.layer.cornerRadius = view.bounds.width*0.75/2
    }
    @IBAction func dismissView(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}
