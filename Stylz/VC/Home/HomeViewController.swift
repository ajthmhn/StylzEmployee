//
//  HomeViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 26/02/23.
//

import UIKit
import StylzWebkit

class HomeViewController: BaseViewController {

    struct VCConst {
        static let cellId = "home_cell_id"
    }
    
    let items = [["name":LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointments", comment: ""),"image":"appoint_dark","image_sel":"appoint_light"],["name":LocalizationSystem.sharedInstance.localizedStringForKey(key: "services", comment: ""),"image":"service_dark","image_sel":"service_light"],["name":LocalizationSystem.sharedInstance.localizedStringForKey(key: "settings", comment: ""),"image":"settings","image_sel":"settings"]]
    
    //["name":"Bills","image":"bills_dark","image_sel":"bills_light"]
    //["name":"Logout","image":"logout","image_sel":"logout"]
    //["name":"Walk-In","image":"walk_in","image_sel":"walk_in"]
    
    var selected = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //handling api innvalid token response
        setInvalidTokenNotificationOberver()
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // fetch messagng token and update user details
        self.fetchMessagingTokenAndCallUpdateTokenAPI()
        
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    
   
}

//MARK: - handle notification observer for invalid token
extension HomeViewController{

    func setInvalidTokenNotificationOberver(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("session_reset"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        deleteUserDetails()
        clearCart()
        StylzAPIFacade.shared.resetSession()
   
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.login) as! LoginViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
