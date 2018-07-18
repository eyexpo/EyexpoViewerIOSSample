//
//  Tour.swift
//  eyexpopronative
//
//  Created by Thompson Sanjoto on 2018-07-12.
//  Copyright © 2018 eyexpo. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class Tour{
    
    var cover_img_thumbnail_url: String
    var cover_img_original_url: String
    var tour_url: String
    var title: String
    var sub_title: String?
    
    init(tour:JSON){
        cover_img_thumbnail_url = tour["cover_img_thumbnail"].stringValue
        cover_img_original_url = tour["cover_img_original"].stringValue
        tour_url = tour["public_url"].stringValue
        title = (tour["name"].stringValue.count > 0 ) ? tour["name"].stringValue : "Untitled Tour"
    }

}
