//
//  Images.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//

import UIKit
import SwiftyJSON

public class Images: JSONAble {
    public var id : Int?
    public var image : String?
  
    public init(json:JSON) {
        id = json["id"].int
        image = json["image"].intToSafeString()
     
    }
}

