//
//  VerifyOTPForPhoneRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/22/24.
//


import Foundation

struct VerifyOTPForPhoneRequest: Encodable {
   
    let otp:Int
   // let id: Int
    let phone:String
  //  let device:String
        
    func getRequestBody() -> [String:Any]{
        var  details = [String:Any]()
     
        details["phone_otp"] = otp
        details["phone"] = phone
        
        return details
    }
    
}

