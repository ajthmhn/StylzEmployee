//
//  LoginViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 26/02/23.
//

import UIKit
import StylzWebkit

class LoginViewController: BaseViewController {
    
    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var txtView: [UIView]!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblPass: UILabel!
    @IBOutlet var btnRetrive: UIButton!
    @IBOutlet var btnLogin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextfieldsBorders()
        
        localizeView()
        
        getDeviceToken()
    }
    
    
    @IBAction func btnSignUp(_ sender: Any) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.signUp) as! SignUpViewController
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @IBAction func btnPassword(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.retrievePass) as! ForgotPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        self.loginUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationScaleEffect(view: viewCol)
    }
    
}


//MARK:  - ui

extension LoginViewController{
    
    
    func setTextfieldsBorders(){
        for all in txtView{
            all.layer.borderColor =  UIColor.lightGray.cgColor
            all.layer.borderWidth  = 0.5
        }
    }
    
    
    func localizeView(){
        lblName.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "userId", comment: "")
        lblPass.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: "")
        btnRetrive.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "retrive", comment: ""), for: .normal)
        btnLogin.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: ""), for: .normal)
        
        lblTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: "")
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            txtName.textAlignment = .right
            txtPassword.textAlignment = .right
        }else{
            txtName.textAlignment = .left
            txtPassword.textAlignment = .left
        }
    }
}

