//
//  VerifyOTPResource.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation
import StylzWebkit

struct VerifyOTPForClientResource{
    
    func VerifyOtPForClient(request:VerifyOtpForClientRequest,completionHandler:@escaping (_ err: String?)->()) {
        
        print(request)
        StylzAPIFacade.shared.VerifyOtPForClient(data:request.getRequestBody()){ (aRes) in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    completionHandler(nil)
                }else{
                    
                completionHandler(getErrMsg(json: aRes?.json))
                  }
            }else{
                
                completionHandler(getErrMsg(json: aRes?.json))
       }
        }
    }
}

