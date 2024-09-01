//
//  APIHandler_AddClient.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation


//MARK: - add client api
extension AddClientViewController{
    
    
    func doAddClient(){
        
        let loadingIndicator = getIndicator(controller: self)
        
        let name = txtName.text ?? ""
        let phone = txtPhone.text ?? ""
        let email = txtEmail.text ?? ""
        let gender = 1
        
        let branchId = getGenderCode()
        
        let request = AddClientRequest(phone:phone , name: name, email: email, gender: gender, branchID: branchId)
        
        let viewModel = AddClientViewModel()
        viewModel.addClient(request: request) {  errorMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    
                    let msg = LocalizationSystem.sharedInstance
                        .localizedStringForKey(key: K.MYStrings.clietAdded, comment: "")
                    
                    showSuccess(title:"" , subTitle: msg, view:self.view )
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                    }
                }
            }
            
        }
    }
}
