//
//  TourCell.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-12.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class TourCell: UITableViewCell{
    
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var tapContainer: UIView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var panoView: GVRPanoramaView!
}
