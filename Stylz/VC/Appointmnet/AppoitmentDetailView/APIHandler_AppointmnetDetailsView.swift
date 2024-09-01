//
//  APIHandler_AppointmnetDetailsView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit
import StylzWebkit

//MARK: - caancel appointment

extension AppointmentDetailsViewController{
    
    func showCancelAppointmentAlert(){
       
        let alertController = UIAlertController(title: "", message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel_appopint", comment: ""), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.cancelAppointment()
        }
        
        let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
    
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func cancelAppointment(){
     
        let loadingIndicator = getIndicator(controller: self)
        
        StylzAPIFacade.shared.cancelAppointment(id: appointments?.id ?? 0) { (aRes) in
            DispatchQueue.main.async {
                if aRes?.statusCode == 200{
                    if aRes?.json?["status"].int == 200{
                        
                        loadingIndicator.removeFromSuperview()
                        
                        let alertController = UIAlertController(title: "", message:  aRes?.json?["message"].stringValue ?? "", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.navigationController?.popViewController(animated: false)
                        }
                    
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        
                    }else{
                        showAlert(title: "", subTitle: getErrMsg(json: aRes?.json), sender: self)
                    }
                }else{
                    showAlert(title: "", subTitle: getErrMsg(json: aRes?.json), sender: self)
                }
            }
        }
    }
}
