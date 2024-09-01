//
//  ResetPasswordViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 15/03/23.
//

import UIKit
import StylzWebkit

class ResetPasswordViewController: UIViewController {

    
    @IBOutlet var viewChangePass: UIView!
    @IBOutlet var txtOtp: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblSub: UILabel!
    @IBOutlet var lblPass: UILabel!
    @IBOutlet var btnUIpdate: UIButton!

    @IBOutlet var lblHead2: UILabel!
    @IBOutlet var lblSub2: UILabel!
    @IBOutlet var lblCode: UILabel!
    @IBOutlet var btnVery: UIButton!
    @IBOutlet var btnBack: UIButton!

    var resetCode = ""
    var userID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewChangePass.isHidden = true
        
        txtOtp.text = resetCode
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "account_recovery", comment: "")
        lblHead2.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "account_recovery", comment: "")
        lblSub2.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_recovery", comment: "")
        lblCode.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "code", comment: "")
        lblSub.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_new", comment: "")
        lblPass.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "new_password", comment: "")
        btnUIpdate.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update", comment: ""), for: .normal)
        btnVery.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "verify", comment: ""), for: .normal)
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            txtPassword.textAlignment = .right
            txtOtp.textAlignment = .right
        }else{
            txtPassword.textAlignment = .left
            txtOtp.textAlignment = .left
        }
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)

    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func btrnVerify(_ sender: Any) {
        if txtOtp.text == resetCode{
            viewChangePass.isHidden = false
            animationScaleEffectSingle(view: viewChangePass)
        }else{
            viewChangePass.isHidden = true
        }
    }
    
    
    @IBAction func btnChangePasswod(_ sender: Any) {
        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        
        self.view.addSubview(loadingIndicator)

        var details = [String:Any]()
        details["reset_code"] = txtOtp.text
        details["user_id"] = self.userID
        details["password"] = self.txtPassword.text
                           
        StylzAPIFacade.shared.resetPassword(data: details) { (aRes) in
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
            }
            if aRes?.statusCode == 200{
               if aRes?.json?["status"].stringValue == "true"{
                   self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                }else{
                    if let error = aRes?.json?["error"].array{
                        if error.count > 0{
                            showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
                        }else{
                            showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                        }
                    }else{
                        showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                    }
                }
            }else{
                if let error = aRes?.json?["error"].array{
                    if error.count > 0{
                        showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
                    }else{
                        showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                    }
                }else{
                    showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                }
                }
            }
    }
}


//MARK: - handling forgot password api
extension ForgotPasswordViewController{
    
    func moveToOTPView(id:Int, otp:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.otpView) as! OTPViewController
        vc.otp =  otp
        vc.userId =  id
        vc.mobile = self.txtEmail.text ?? ""
        vc.isPassword = true
        vc.isEmail = self.isEmail
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func forgotPassword2(){
        let emailOrNum = txtEmail.text ?? ""
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let request = ForgotpasswordRequest(phone: emailOrNum, isEmail: self.isEmail)
        
        let viewModel = ForgotPasswordViewModel()
        viewModel.forgotPassword(request: request) { id, otp, errorMsg in
            
            DispatchQueue.main.async {
             
                loadingIndicator.removeFromSuperview()
                
                if  otp != nil && id != nil{
                
                    self.moveToOTPView(id: id!, otp: otp!)
                }
                else{
                    
                    showAlert(title: "", subTitle:  errorMsg ?? LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") , sender: self)
                }
            }
        }
    }
}
