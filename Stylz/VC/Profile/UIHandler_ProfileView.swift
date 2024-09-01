//
//  UIHandler_ProfileView.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation
import UIKit


//MARK: - UI
extension ProfileViewController{
    
    func updateUI(){
        viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 40
        viewTop.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        viewCol[0].layer.borderWidth = 1
        viewCol[0].layer.borderColor = UIColor.lightGray.cgColor
        viewCol[1].layer.borderWidth = 1
        viewCol[1].layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    func updateEmployeeDetails(){
        
        setImage(imageView: imgUser, url: getUserDetails()?["image"] as? String ?? "")
        lblName.text = getUserDetails()?["first_name"] as? String ?? ""
        lblEmail.text = getUserDetails()?["email"] as? String ?? ""
        lblPhone.text = getUserDetails()?["phone"] as? String ?? ""
        lblAccount.text = getUserDetails()?["account_type"] as? String ?? ""
        
        lblRating.text = String.init(format: "%.1f", getUserDetails()?["rating"] as? Double ?? 0.0)
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile", comment: "")
        btnUpdate.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update", comment: ""), for: .normal)
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_white_right" : "back_white"), for: .normal)
    }
    
    
    func localizeView(){
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            lblName.textAlignment = .right
            lblEmail.textAlignment = .right
            lblPhone.textAlignment = .right
            lblAccount.textAlignment = .right
        }else{
            lblName.textAlignment = .left
            lblEmail.textAlignment = .left
            lblPhone.textAlignment = .left
            lblAccount.textAlignment = .left
        }
        
        btnChangePassword.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "change_password", comment: ""), for: .normal)
        
    }
}


//MARK: - update/edit btn handler
extension ProfileViewController{
    
    func doUpdateProfile(){
        //animationScaleEffect(view: editableViews)
        changeFieldState(isEnabled: false)
        updateProfile()
    }
    
    func doEnableFieldsForEditing(){
        changeFieldState(isEnabled: true)
        animationScaleEffect(view: editableViews)
    }
    
    func changeFieldState(isEnabled:Bool){
        lblName.isEnabled = isEnabled
        
        BtnEdit.isHidden = isEnabled
        btnUpdate.isHidden =  !isEnabled
    }
}


