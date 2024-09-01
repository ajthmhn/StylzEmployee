//
//  BaseViewController.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import UIKit
import FirebaseMessaging

import StylzWebkit

class BaseViewController: UIViewController {
    var deviceToken = ""
    
    let dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func getGenderCode() -> Int{
        return getUserDetails()?["gender"] as? Int ?? 0
    }
    
    func getBrannchCode() -> Int{
        return getUserDetails()?["branchId"] as? Int ?? 0
    }
    
    func getCustomerID() -> Int?{
        
        let customerID = getUserDetails()?["id"] as? Int ?? nil
        print(customerID)
        
        return customerID
    }
    
    func getUserID() -> Int{
        return  StylzAPIFacade.shared.session?.UserId ?? -1
    }
  
}

//MARK: - UI

extension BaseViewController{
    
    func updateSecureTFState(txtField:UITextField, sender:UIButton){
        if txtField.isSecureTextEntry == true{
            txtField.isSecureTextEntry = false
            sender.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }else{
            txtField.isSecureTextEntry = true
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    func setTxtFieldALignment(tf:UITextField){
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            tf.textAlignment = .right
        }else{
            tf.textAlignment = .left
        }
    }
    
    func getNoDataLabel(tableORColView:UIView) -> UILabel{
        let label = UILabel()
        label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_data", comment: "")
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.sizeToFit()
        label.frame = CGRect(x: tableORColView.frame.width/2, y: tableORColView.frame.height/2, width: tableORColView.frame.width, height: 50)
        
        return label
    }
    
    func getAttributedString() -> NSMutableAttributedString{
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "سلة", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
        //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
        let attributedString4 = NSMutableAttributedString(string:"100 SAR", attributes:attrs4 as [NSAttributedString.Key : Any])
        attributedString3.append(attributedString4)
        
        return attributedString3
    }
    
    
    
    func getAttributesStringWithSum(sum:Double) -> NSMutableAttributedString {
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
        let attributedString4 = NSMutableAttributedString(string:"SAR \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
        attributedString3.append(attributedString4)
        return attributedString3
    }
}

//MARK: - handling inidicator
extension BaseViewController{
    
    func getIndicator(controller:UIViewController) -> UIActivityIndicatorView{
        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        
        controller.view.addSubview(loadingIndicator)
        
        return loadingIndicator
    }
}


// MARK: - firebase  messaging token
extension BaseViewController{
    
    func getDeviceToken(){
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("device token \(token)")
                self.deviceToken = token
                
            }
        }
    }
    
    func fetchMessagingTokenAndCallUpdateTokenAPI(){
        Messaging.messaging().token { token, error in
            if let error = error {
                print("~ Error fetching FCM registration token: \(error)")
            } else if let token = token {
                self.deviceToken = token
                   DispatchQueue.global(qos: .userInitiated).async {
                        //MARK: -- have to update
                          self.updateToken()
                    }
            }
        }
    }
    
    func updateToken(){
        var details = [String:Any]()
        
        details["fcm_token"] = deviceToken
       
        print("fcm tokenn: \(details)")
        
                StylzAPIFacade.shared.updateToken(profDet: details) { (aRes) in
                    print("\(aRes?.json) ~~~~ updated user token \(self.deviceToken)")
                }
        
    }
    
}
