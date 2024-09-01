//
//  VerifyOTPRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation

struct VerifyOTPRequest: Encodable {
   
    let phone,email:String
    let isEmail:Bool
    
    func getRequestBody() -> [String:Any]{
        var  loginObj = [String:Any]()
        
        if isEmail == true{
            loginObj["email"] = email
        }else{
            loginObj["phone"] = phone
        }
        
        //loginObj["user_id"] = id
       
        return loginObj
    }
    
}

