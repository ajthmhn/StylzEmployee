//
//  Employee.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//


import UIKit
import SwiftyJSON

public class Employee: JSONAble {
    public var id : Int?//
    //  public var employee : Int?
    
    public var price : String?//
    public var first_name : String?//
    public var last_name : String?//
    // public var reference_id : String?
    public var image : String?//
    //public var employee_rating : String?
    
    public var phone : String?//
    public var email : String?//
    public var branchNameEn : String?//
    public var branchNameAr : String?//
    
    public var employee__first_name : String?
    public var employee__last_name : String?
    
    public var total_amount : String?
    
    
    public var services = [ Services ]()
    
    public init(json:JSON) {
        id = json["id"].int
        // employee = json["employee"].int
        price = json["employee_service_price"].intToSafeString()
        
        //   reference_id = json["reference_id"].string
        image = json["image"].string
        
        //employee_rating = json["employee_rating"].intToSafeString()
        
        total_amount = json["total_amount"].intToSafeString()
        
        
        if let choice = json["user"].dictionary {
            employee__first_name = choice["first_name"]?.string
            employee__last_name = json["last_name"].string
            first_name = json["first_name"].string
            last_name = json["last_name"].string
            
            phone = choice["phone"]?.string
            email = choice["email"]?.string
            
        }
        
        if let choice = json["shop"].dictionary {
            branchNameEn = choice["name_en"]?.string
            branchNameAr = choice["name_ar"]?.string
        }
        
        if let choice = json["employee_service"].array {
            for prodtJson in choice {
                let item = Services(json: prodtJson)
                services.append(item)
            }
        }
        
    }
    
    public init(ClientJson:JSON?){
        id = ClientJson?["id"].int
        // employee = json["employee"].int
        price = ClientJson?["employee_service_price"].intToSafeString()
        
        //   reference_id = json["reference_id"].string
        image = ClientJson?["image"].string
        
        //employee_rating = json["employee_rating"].intToSafeString()
        
        total_amount = ClientJson?["total_amount"].intToSafeString()
        
        
        employee__first_name = ClientJson?["first_name"].string
        employee__last_name = ClientJson?["last_name"].string
        first_name = ClientJson?["first_name"].string
        last_name = ClientJson?["last_name"].string
        
        phone = ClientJson?["phone"].string
        email = ClientJson?["email"].string
        
    }
    
    
    public init(json2:JSON) {
        id = json2["employee_id"].int
        total_amount = json2["total_amount"].intToSafeString()
        first_name = json2["employee__user__first_name"].stringValue
        employee__first_name = json2["employee__user__first_name"].stringValue
       }
    
}

