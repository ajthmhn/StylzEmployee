//
//  VerifyClientOTP_APIHanddler.swift
//  Stylz
//
//  Created by abcd on 05/05/2024.
//

import Foundation


extension OTPViewController{
    
    func verifyAddClientOTP(){
        
        
        let activityIndicator = getIndicator(controller: self)
        
        let request = VerifyOtpForClientRequest(otp: otpRight)
        
        let viewModel = VerifyOtpForClientViewModel()
        viewModel.VerifyOtPForClient(request: request) { errorMsg in
            
            DispatchQueue.main.async {
                
                activityIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }else{
                    
                    self.moveToAddClientView()
                    
                }
            }
        }
        
    }
    
    
    func moveToAddClientView(){
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.addClient) as! AddClientViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
