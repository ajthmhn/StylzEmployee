//
//  LogoutHandler_Settings.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation
import UIKit
import StylzWebkit

//MARK: - logout
extension SettingsViewController{
    
    
    func moveToRootVc(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.login) as! LoginViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func callLogoutAPIAndDeleteUserDetails(){
        StylzAPIFacade.shared.logout() { ares in
            print("~logged: \(ares?.json)")
            
            if ares?.statusCode == 200{
                print("~logged out successfuly: \(ares)")
            }
        }
        
        clearCart()
        deleteUserDetails()
        StylzAPIFacade.shared.resetSession()
    }
    
    
    func showLogOutConfirmationAlert(){
        let title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "signout", comment: "")
        
        let logOutMsg = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.wantToLogOut, comment: "")
        
        let cancel =  LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.cancelPremium, comment: "")
        
        let alertController = UIAlertController(title:title , message: logOutMsg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: title, style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.callLogoutAPIAndDeleteUserDetails()
            DispatchQueue.main.async {
                self.moveToRootVc()
            }
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
