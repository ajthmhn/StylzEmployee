//
//  VerifyOtpForClientRequest.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//



import Foundation
import StylzWebkit


struct VerifyOtpForClientRequest {
    
   let otp:String
    
     func getRequestBody() -> [String:Any]{
     
        var details = [String:Any]()
        details["otp_code"] = otp
         
        return details
    }
    
    
}




