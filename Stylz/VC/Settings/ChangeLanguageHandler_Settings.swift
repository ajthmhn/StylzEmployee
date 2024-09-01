//
//  ChangeLanguageHandler_Settings.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

//MARK: - handle language change
extension SettingsViewController{
    
    func showLanguageOptions(){
        
        let alertController = UIAlertController(title: ""
                                                , message: "", preferredStyle: .actionSheet)
        
        let Camera = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "English", comment: "")
                                   , style: .default) { action in
            
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            self.lblLangauge.text = "EN"
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Done"
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false)
            
        }
        
        let Gallery = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "عربي", comment: "")
                                    , style: .default){ action in
            
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "تم"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            self.lblLangauge.text = "AR"
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false)
        }
        
        
        let Cancel = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: "")
                                   , style: .default)
        alertController.addAction(Camera)
        alertController.addAction(Gallery)
        alertController.addAction(Cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}



