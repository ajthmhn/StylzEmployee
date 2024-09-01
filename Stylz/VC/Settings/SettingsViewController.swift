//
//  SettingsViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 07/03/23.
//

import UIKit
import StylzWebkit
import IQKeyboardManagerSwift

class SettingsViewController: UIViewController {
    
    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblLangauge: UILabel!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblAccount: UILabel!
    @IBOutlet var lblProfile: UILabel!
    @IBOutlet var lblNotif: UILabel!
    @IBOutlet var lblReport: UILabel!
    @IBOutlet var lblSettings: UILabel!
    @IBOutlet var lblLanguage: UILabel!
    @IBOutlet var lblSignout: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var imgarrows: [UIImageView]!
    
    @IBOutlet var lblAccountDelete: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        setLanguage()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setUpView()
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnOpetions(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 0:
            self.moveTo(controllerId: stryBrdId.profile)
            
        case 2:
            self.moveTo(controllerId: stryBrdId.report,isPresenting: true)
            
        case 1:
            self.moveTo(controllerId: stryBrdId.notification)
            
        case 3:
            showLanguageOptions()
            
        case 4:
            showLogOutConfirmationAlert()
            
        case 5:
            showDeleteAccountAlert()
            
        default:
            print("")
        }
    }
}


//MARK: - handle ui
extension SettingsViewController{
    
    
    func setUpView(){
        
        animationScaleEffect(view: viewCol)
        
        for all in viewCol{
            all.dropShadow()
        }
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            lblLangauge.text = "AR"
        }else{
            lblLangauge.text = "EN"
        }
        
        self.lblPhone.text = "+966 \(getUserDetails()?["phone"] as? String ?? "")"
    }
 
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "settings", comment: "")
        lblAccount.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "account", comment: "")
        lblProfile.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile", comment: "")
        lblNotif.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "notifications", comment: "")
        lblReport.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "report", comment: "")
        lblSettings.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "settings", comment: "")
        lblLanguage.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "language", comment: "")
        lblSignout.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "signout", comment: "")
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
        for all in imgarrows{
            all.image  = UIImage(systemName: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "chevron.left" : "chevron.right")
        }
        
        lblAccountDelete.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DeleteAccount", comment: "")
    }
    
}


//MARK: - handle navigation
extension SettingsViewController{
    
    func moveTo(controllerId:String, isPresenting:Bool = false){
        let vc = self.storyboard?.instantiateViewController(withIdentifier:controllerId) as! BaseViewController
        
        if isPresenting{
            vc.modalPresentationStyle = .popover
            self.present(vc, animated: true)
        }
        else{
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
