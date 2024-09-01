//
//  LoginEmailViewMode.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation

struct LoginViewModel{
    
    func login(request: LoginRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
        
        let validation = LoginValidation()
       
        let validationResult = validation.validateEmail(request: request)
        
        if validationResult.success{
            
            let resource = LoginResource()
            resource.login(request: request) {  errorMsg  in
                completionHandler(errorMsg)
            }
        }
        else{
            completionHandler(validationResult.errorMessage)
        }
    }
}
