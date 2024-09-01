//
//  CreateAppointmentRequest.swift
//  StylezUser
//
//  Created by abcd on 01/04/2024.
//

import Foundation
import StylzWebkit


struct CreateAppointmentRequest {
    
    let customerID:Int
    let branchID:Int
    let totalAmount:String
    let date:String
    let Starttime:String
    
    func getRequestBody() -> [String:Any]{
        
        
        var details = [String:Any]()
        
        details["date"] = date
        details["start_time"] = Starttime
        details["appointment_details"] = getAppointmentDetailsFromCart()
        details["branch_id"] = branchID
        details["total_amount"] = totalAmount
        details["customer_id"] = customerID
        
    
        return details
    }

    
    func getAppointmentDetailsFromCart() -> [[String:Any]]{
        var appointment = [[String:Any]]()
    
        if let cartData = getCartData(){
            
            for all in cartData {
                var data = [String:Any]()
                data["service_id"] = all["service_id"] as? Int
                data["employee_id"] = all["customer_id"] as? Int
                appointment.append(data)
            }
        }
        
       return appointment
    }
    
}
