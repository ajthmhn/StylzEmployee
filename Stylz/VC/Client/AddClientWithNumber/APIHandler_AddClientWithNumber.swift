//
//  APIHandler_AddClientWithNumber.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation


//MARK: - api

extension AddClientWithNumberViewController{
    
    func sendOTP(){
        
        let loadingIndicator = getIndicator(controller: self)
        
        let phone = txtPhone.text ?? ""
        let request = SendOtpForClientRequest(phone: phone )
        
        let viewModel = SendOtpForClientViewModel()
        viewModel.sendOTPForClient(request: request) { employees, otp, errMsg in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if errMsg != nil{
                    showAlert(title: "", subTitle: errMsg!, sender: self)
                    return
                }
                
                if let employees, let delegate = self.addClientDelegate{
                    
                    delegate(employees, nil)
                    return
                }
                
                if let otp, let delegate = self.addClientDelegate{
                    
                    delegate(nil, otp)
                    return
                }
            }
        }
    }
}
