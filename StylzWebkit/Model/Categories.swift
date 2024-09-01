//
//  Categories.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//

import UIKit
import SwiftyJSON

public class Categories: JSONAble {
    public var id : Int?
    public var name_en : String?
    public var name_ar : String?
    public var service_category_icon : String?
    public var service_category_icon_Female : String?
   
   // public var services = [ Services]()

    
    
    public init(json:JSON) {
        id = json["id"].int
        name_en = json["name_en"].string
        name_ar = json["name_ar"].string
        
        service_category_icon = json["service_category_icon"].string
        service_category_icon_Female = json["service_category_icon_female"].string
    }
    
    public init(groupjson:JSON) {
        id = groupjson["id"].int
        name_en =  groupjson["name"].string
        name_ar = groupjson["name"].string
    }
    
    public init(id:Int) {
        self.id = id
        name_en =  "All"
        name_ar = "الجميع"
    }
}
