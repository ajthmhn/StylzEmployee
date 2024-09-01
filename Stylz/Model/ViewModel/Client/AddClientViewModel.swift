//
//  AddClientViewModel.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation

struct AddClientViewModel{
    
    func addClient(request: AddClientRequest, completionHandler:@escaping ( _ errorMsg: String?)->()) {
        
        let validation = AddClientValidation()
        let validationResult = validation.validate(request: request)
        
        if validationResult.success{
            let resource = AddClientResourceee()
            
            resource.addClient(request: request) { err in
                completionHandler(err)
            }
      
        }
        else{
            completionHandler(validationResult.errorMessage)
        }
        
    }

}
