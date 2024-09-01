//
//  OTPViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 22/08/23.
//

import UIKit
import AEOTPTextField
import StylzWebkit
//import FirebaseMessaging

class OTPViewController: BaseViewController {
    
    @IBOutlet var txtOtp: AEOTPTextField!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblHead2: UILabel!
    @IBOutlet var btnContinue: UIButton!
    @IBOutlet var lblReceive: UILabel!
    @IBOutlet var btnResend: UIButton!
    
    @IBOutlet var backBtn: UIButton!
    
    var otp = ""
    var mobile = ""
    var otpRight = ""
    var userId = 0
    var isPhoneLogin = false
    var isEmail = false
    var isPassword = false
    //  var deviceToken = ""
    var isUpdate = false
    
    var isFromClietView = false
    
    var numOrEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configOTPTextField()
        setLanguage()
        
        // self.getDeviceToken()
        setViewforUpdate()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            showAlert(title: self.otp, subTitle: "For testing use this otp", sender: self)
        }
    }
    
    @IBAction func btnVerify(_ sender: Any) {
        if isPassword == true{
            doUpdatePassword()
        }
        
        if isFromClietView{
            verifyAddClientOTP()
        }
    }
    
    @IBAction func btnResend(_ sender: Any) {
        
        txtOtp.clearOTP()
      
        if isPassword == true{
            forgotPassword2()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    
}

extension OTPViewController: AEOTPTextFieldDelegate,UITextFieldDelegate {
   
    func didUserFinishEnter(the code: String) {
        print(code)
        otpRight = code
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        otpRight = textField.text ?? ""
        
        print("textfield did change: \(textField.text?.count), otp \(otpRight)")
    }
}



//MARK: - move to password update view

extension OTPViewController{
    func doUpdatePassword(){
        if self.otp != self.otpRight{
            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "valid_otp", comment: ""), sender: self)
            return
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.updatePass) as! UpdatePasswordViewController
            
            vc.userID = self.userId
            vc.otp = self.otpRight
            //self.navigationController?.pushViewController(vc, animated: true)
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            
        }
    }
}

