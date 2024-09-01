//
//  CheckOutRequest.swift
//  Stylz
//
//  Created by abcd on 05/05/2024.
//



import Foundation
import StylzWebkit


struct CheckOutRequest {
    
    let appointmentID:Int
    let vat_peercentage:Double
    let paymentMethod:Int
    
    let services:[AppointmentService]?
    let isPaid:Bool
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        
        if isPaid == false{
            details["items"] = getAppointmentDetailsFromSerives()
        }
        
//        else{
//            details["reference_id"] = ""
//            details["payment_id"] = ""
//            details["transaction_id"] = ""
//        }
        
        details["appointment_id"] = appointmentID
        details["vat_percentage"] = vat_peercentage
        details["payment_method"] = paymentMethod
        
        return details
    }
    
    
    func getAppointmentDetailsFromSerives() -> [[String:Any]]{
        var appointment = [[String:Any]]()
        
        for all in services ?? []{
            var data = [String:Any]()
            data["service_id"] = all.service_id
            data["employee_id"] = all.employee_id
            appointment.append(data)
        }
        
        return appointment
    }
    
}
