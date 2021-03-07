//
//  TeamSelectionProtocol.swift
//  SportsApplication
//
//  Created by moutaz hegazy on 3/7/21.
//  Copyright © 2021 moutaz_hegazy. All rights reserved.
//

import Foundation
import UIKit

protocol TeamSelection {
    func didSelect(_ team:TeamData , with badge:UIImage?)
}
