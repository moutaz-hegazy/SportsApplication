//
//  ErrorAlert.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/7/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import UIKit

struct ErrorAlert{
    public static func getErrorAlert()-> UIAlertController{
        let alert = UIAlertController(title: "Error", message: "a problem happened while trying to connect to server please check your connection and try again. ", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okButton)
        return alert
    }
}
