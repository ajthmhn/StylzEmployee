//
//  VerifyOtpValidation.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation

struct VerifyOtpForClientValidation{
    
    func validate(request: VerifyOtpForClientRequest) -> ValidationResult {
        
        if request.otp.count > 0{
            
            if "\(request.otp)".count < 5{
                
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "valid_otp", comment: ""))
            
            }
            
            return ValidationResult(success: true, errorMessage: nil)
        }
        else {
            
            if request.otp.count <= 0{
                print("verify 2 otp phone validation false")
                
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_otp", comment: ""))
            }
           
            
            return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
        }
    }
}
