//
//  LoginResource.swift
//  Stylz
//
//  Created by abcd on 16/04/2024.
//


import Foundation
import StylzWebkit


struct LoginResource{
    
    func login(request: LoginRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
        
        StylzAPIFacade.shared.login(profDet: request.getLoginRequestBody()){ (aRes) in
            print(request.getLoginRequestBody())
            print("\(aRes?.json)")
                if aRes?.statusCode == 200{
                    if aRes?.json?["status"].intValue == 200{
                    
                        // saveUserDetails(userDetails: (StylzAPIFacade.shared.session?.currentUser)!)
                        
                        completionHandler(nil)
                    }
                    else{
                        completionHandler(getErrMsg(json: aRes?.json))
                    }
                }else{
                    completionHandler(getErrMsg(json: aRes?.json))
                }
        }
    }
    
    
}
