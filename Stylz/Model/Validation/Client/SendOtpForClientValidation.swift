//
//  SendOtpForClientValidation.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation

struct SendOtpForClientValidation  {
    
    func validate(request: SendOtpForClientRequest) -> ValidationResult {
        if(request.phone.count > 0){
            
            if (request.phone.count > 9){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
            }
            
            return ValidationResult(success: true, errorMessage: nil)
            
        }
        else{
            
            if request.phone.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
            }
            
            return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
            
        }
        
    }
    
}
