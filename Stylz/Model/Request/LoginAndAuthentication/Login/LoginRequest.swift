//
//  LoginRequest.swift
//  Stylz
//
//  Created by abcd on 16/04/2024.
//

import Foundation

struct LoginRequest: Encodable {
   
    let userEmail, userPassword:String
    let fcmID:String
  
    func getLoginRequestBody() -> [String:Any]{
      
        var  loginObj = [String:Any]()
        
        loginObj["email"] = userEmail
        loginObj["password"] = userPassword
    
        //    loginObj["user_type"] = 5 // for stylist
        
        loginObj["user_type"] = 8 // for stylist
      
        loginObj["fcm_id"] = fcmID
         
        return loginObj
    }
    
}

