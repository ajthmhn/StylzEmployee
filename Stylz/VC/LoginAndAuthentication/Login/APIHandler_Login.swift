//
//  APIHandler_Login.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit

//MARK: - Login API
extension LoginViewController{
    
    func moveToHome(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false)
    }
    
    func loginUser(){
        let loadingIndicator = getIndicator(controller: self)
        
        let email = txtName.text ?? ""
        let pass = txtPassword.text ?? ""
        
        let request = LoginRequest(userEmail: email , userPassword: pass,fcmID: self.deviceToken)
        
        print("login request \(request.getLoginRequestBody())")
        let viewModel  = LoginViewModel()
        
        viewModel.login(request: request) { errorMsg in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    self.fetchEmployeeInfoAndMoveToRoot()
                }
            }
        }
    }
}



//MARK: - fetch user data

extension LoginViewController{
    
    
    func fetchEmployeeInfoAndMoveToRoot(){
        let resource = GetEmployeeInformation()
        resource.getEmployeeInformation { err in
            if err != nil{
                showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""), sender: self)
            }
            else{
                self.moveToHome()
            }
        }
    }
}


