//
//  Services.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//

import UIKit
import SwiftyJSON

public class Services: JSONAble {
    public var id : Int?
    public var service : Int?
    public var name_en : String?
    public var name_ar : String?
    public var description_en : String?
    public var description_ar : String?
    public var duration : String?
    public var amount : String?
    public var service_status : Int?
    
    public var branch__name_en : String?
    public var branch__name_ar : String?
    
    public var total_amount : String?
    
    public var employees = [ Employee]()
    
    
    public init(json:JSON) {
        id = json["id"].int
        service = json["service"].int
        name_en = json["name_en"].string
        name_ar = json["name_ar"].string
        description_en = json["description_en"].string
        description_ar = json["description_ar"].string
        duration = json["duration"].string
        amount = json["amount"].intToSafeString()
        service_status = json["service_status"].int
        total_amount = json["amount"].intToSafeString()

        if let choice = json["shop"].dictionary {
            branch__name_en = choice["shop_name"]?.string
            branch__name_ar = choice["shop_name"]?.string
        }
        
        if let choice = json["employees"].array {
            for prodtJson in choice {
                let item = Employee(json: prodtJson)
                employees.append(item)
            }
        }
    }
  
    public init(json2:JSON) {
        id = json2["service_id"].int
        name_en = json2["service__name_en"].string
        name_ar = json2["service__name_ar"].string
        total_amount = json2["total_amount"].intToSafeString()

    }
  
   
}
