//
//  AddClientValidation.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation

import Foundation
struct AddClientValidation{
    
    func validate(request: AddClientRequest) -> ValidationResult {
        if(request.email.count > 0 && request.phone.count > 0 && request.name.count > 0 ){

            
            if(!request.email.validateEmail())
            {  return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_valid_email", comment: ""))
            }
            
            if (request.phone.count > 9){
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.enterValidNum, comment: ""))
            }
        
            
            return ValidationResult(success: true, errorMessage: nil)
        }
        else{
            if request.email.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_email", comment: ""))}
            
            if request.name.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_name", comment: ""))
            }
            if request.phone.count <= 0{
                return ValidationResult(success: false, errorMessage: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_phone", comment: ""))
            }
           
        }
        
        return ValidationResult(success: false, errorMessage:
                                LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""))
    }
    
}
