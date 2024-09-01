//
//  Appointments.swift
//  StylzWebkit
//
//  Created by WC_Macmini on 14/03/23.
//

import UIKit
import SwiftyJSON

public class Appointments: JSONAble {
    public var id : Int?//
    public var reference_id : String?//
    public var appointment_status : Int?//
    public var customer_prepaid : Int?//
    public var salon_id : Int?//
    public var salon_name_ar : String?//
    public var salon_name_en : String?//
    public var salon_address : String?//
    public var salon_address_region : String?//
    public var salon_latitude : Double?//
    public var salon_longitude : Double?//
    public var vat_reg_number : String?//
    public var date : String?//
    public var start_time : String?//
    public var end_time : String?//
    
    public var customerId : Int? //
    public var customerName : String? //
    public var customerPhone : String? //
    public var customerEmail : String?//
    public var customerImage : String?//
    
    public var services = [ AppointmentService ]()
    public var billDetails = [ BillDetails ]()
    
    public var discount:Double?
    
    public init(json:JSON) {
      
        id = json["id"].int
        reference_id = json["reference_id"].string
        appointment_status = json["appointment_status"].int
        customer_prepaid = json["customer_prepaid"].int
        salon_id = json["shop_id"].int
        salon_name_ar = json["shop_name"].string
        salon_name_en = json["shop_name"].string
        salon_address = json["shop_address"].string
        salon_address_region = json["salon_address_region"].string
        salon_latitude = json["shop_latitude"].double
        salon_longitude = json["shop_longitude"].double
       
        date = json["date"].string
        start_time = json["start_time"].string
        end_time = json["end_time"].string
      
        vat_reg_number = json["vat_reg_number"].string
        

        discount = json["discounted_amount"].double
        
        if let choice = json["customer"].dictionary {
            customerId = choice["id"]?.int
            customerName = choice["first_name"]?.string
            customerPhone = choice["phone"]?.string
            customerEmail = choice["email"]?.string
            customerImage = choice["image"]?.string
        }
        
       if let choice = json["services"].array {
            for prodtJson in choice {
                let item = AppointmentService(json: prodtJson)
                services.append(item)
            }
        }
        
        //needs to be changedd
        if let choice = json["bill_details"].array {
            for prodtJson in choice {
                let item = BillDetails(json: prodtJson)
                billDetails.append(item)
            }
        }
    }
}
