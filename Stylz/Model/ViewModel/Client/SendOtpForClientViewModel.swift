//
//  SendOtpForClientViewModel.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation
import StylzWebkit

struct SendOtpForClientViewModel{
    
    
    func sendOTPForClient(request: SendOtpForClientRequest, completionHandler:@escaping (_ employees: [Employee]?,_ phoneOTP:Int?,_ errMsg:String?)->()) {
        
        let validation = SendOtpForClientValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            
            let resource = SendOtpFroClientResource()
            
            resource.sendOTPForClient(request: request) { employees, phoneOTP, errMsg in
                
                completionHandler(employees, phoneOTP,errMsg)
            }
        }
        else{
            completionHandler(nil,nil, validationResult.errorMessage)
        }
        
        
    }
    
    
}
