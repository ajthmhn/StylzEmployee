//
//  SendOtpForClientRequest.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//


import Foundation
import StylzWebkit


struct SendOtpForClientRequest {
    
   let phone:String
    
     func getRequestBody() -> [String:Any]{
     
         var details = [String:Any]()
        details["phone"] = phone
         
        return details
    }
    
    
}




