//
//  DeleteAccountHandler_Settings.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation
import UIKit
import StylzWebkit


//MARK: - Delete account

extension SettingsViewController{
    
    func showDeleteAccountAlert(){
        
        
        let confirm = LocalizationSystem.sharedInstance.localizedStringForKey(key: "confirm", comment: "")
        let cancel = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: "")
        let areYouSure = LocalizationSystem.sharedInstance.localizedStringForKey(key: "YouSure", comment: "")
        let alertTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DeleteAccount2", comment: "")
        let youWantToDeleteAcc = LocalizationSystem.sharedInstance.localizedStringForKey(key: "WantToDelete", comment: "")
        
        
        let alertController = UIAlertController(title: alertTitle, message: youWantToDeleteAcc, preferredStyle: UIAlertController.Style.alert)
        
        
        let okAction = UIAlertAction(title: confirm, style: UIAlertAction.Style.destructive) {
            (result : UIAlertAction) -> Void in
            
            self.deleteAcc()
            
        }
        
        let deleteAction = UIAlertAction(title: cancel, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteAcc(){
        
        //let accDeleted = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DeletedMsg", comment: "")
        StylzAPIFacade.shared.deleteAccount { ares in
            print("acc deleted: \(ares?.json?["message"])")
        }
        
        deleteUserDetails()
        StylzAPIFacade.shared.resetSession()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.login) as! LoginViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
}

