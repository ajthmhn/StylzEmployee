//
//  UIHandler_SelectDateView.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit


//MARK: - ui
extension SelectDateViewController{
    
    
    func setCurrentDate(){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        dateFormat.locale  = Locale(identifier: "en")
        lblDate.text = dateFormat.string(from: Date())
      
    }
    
    func localizeView(){
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
        if isRescedule == true{
            btnNext.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "rescedule_appointment", comment: ""), for: .normal)
        }else{
            btnNext.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "choose_client", comment: ""), for: .normal)
        }
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_date", comment: "")
        lblTime.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "available_time", comment: "")
        
        
     
    }
    
}
