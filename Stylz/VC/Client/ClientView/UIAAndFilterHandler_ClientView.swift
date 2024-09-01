//
//  UIHandler_ClientView.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import UIKit

extension ClientsViewController{
    
    func handleBackBtn(){
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
    }
    
    func localizeeView(){
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_client", comment: "")
        btnBook.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "book_appoint", comment: ""), for: .normal)
        txtSearch.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search", comment: "")
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            txtSearch.textAlignment = .right
        }else{
            txtSearch.textAlignment = .left
        }
        
    }
    
}


//MARK: - textfield delegate
extension ClientsViewController:UITextFieldDelegate{
    
    func configTf(){
        
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        txtSearch.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        
        filterData()
        
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        filterData()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}


//MARK: - filter data
extension ClientsViewController{
    
    func filterData(){
        
        if ((txtSearch.text?.isEmptyOrWhitespace()) == true){
            filteredEmployeeList = EmployeeList
        }
        else{
            filteredEmployeeList = EmployeeList.filter { $0.first_name?.lowercased().contains(txtSearch.text?.lowercased() ?? "") ?? false }
        }
        
        print("filetered employee liasr count \(filteredEmployeeList.count)")
        self.updateClientView()
        
    }
}
