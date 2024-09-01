//
//  User.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 06/03/23.
//

import UIKit
import SwiftyJSON

public class User: JSONAble {
    public var userId : Int?
    public var first_name : String?
    
    //public var last_name : String?
    // public var reference_id : String?
    public var phone : String?
    public var image : String?
    public var email : String?
    
    //public var iqama_number : String?
    //public var national_id : Int?
    public var account_type : String?
    
    public var name_en : String?
    public var branchId : Int?
    public var name_ar : String?
    public var branchPhone : String?
    public var address : String?
    public var gender : Int?
    public var images = [ String]()
    public var saloRating : Double?
    public var employeeRating : Double?
    
    public init(json:JSON) {
        
        
        //        last_name = json["last_name"].string
        //        reference_id = json["reference_id"].string
        //
        //        iqama_number = json["iqama_number"].string
        //        national_id = json["national_id"].int
        //
        userId = json["id"].int
        phone = json["phone"].string
        image = json["image"].string
        employeeRating = json["rating"].doubleValue
        
        if let details = json["user"].dictionary {
            first_name = details["first_name"]?.string
            email = details["email"]?.string
        }
        
        if let details = json["role"].dictionary {
            account_type = details["name"]?.string
        }
        
        if let details = json["shop"].dictionary {
            name_en = details["name_en"]?.stringValue
            name_ar = details["name_ar"]?.stringValue
            branchPhone = details["phone"]?.stringValue
            address = details["address"]?.stringValue
            branchId = details["id"]?.int
            gender = details["gender"]?.int
            saloRating = details["salon_rating"]?.doubleValue
            
            
            if let choice = details["images"]?.array {
                for prodtJson in choice {
                   // let item = Images(json: prodtJson)
                    images.append(prodtJson.string ?? "")
                }
            }
            
        }
    }
    
    public func dicValue() -> [String:Any] {
        var userDic = [String:Any]()
       
        userDic["id"] = userId
        userDic["first_name"] = first_name
        
//        userDic["last_name"] = last_name
  //      userDic["reference_id"] = reference_id
        
        userDic["phone"] = phone
        userDic["image"] = image
        userDic["email"] = email
        
        //      userDic["iqama_number"] = iqama_number
        //    userDic["national_id"] = national_id
        
        
        userDic["account_type"] = account_type
        userDic["name_en"] = name_en
        userDic["branchId"] = branchId
        userDic["name_ar"] = name_ar
        userDic["branchPhone"] = branchPhone
        userDic["address"] = address
        userDic["gender"] = gender
        userDic["images"] = images
        
        userDic["saloRating"] = saloRating
        userDic["rating"] = employeeRating
        
        return userDic
    }
}
