//
//  VerifyOtpForClient.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//



import Foundation

struct VerifyOtpForClientViewModel{
    
    
    func VerifyOtPForClient(request: VerifyOtpForClientRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
        
        let validation = VerifyOtpForClientValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            let resource = VerifyOTPForClientResource()
            resource.VerifyOtPForClient(request: request) { err in
                completionHandler(err)
            }
            
        }
        else{
            completionHandler(validationResult.errorMessage)
        }
        
        
    }
    
    
}
