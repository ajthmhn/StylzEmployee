////
////  LoginViewController.swift
////  Stylz
////
////  Created by WC_Macmini on 26/02/23.
////
//
//import UIKit
//import StylzWebkit
//
//class LoginViewController: UIViewController {
//    
//    @IBOutlet var viewCol: [UIView]!
//    @IBOutlet var txtView: [UIView]!
//    @IBOutlet var txtName: UITextField!
//    @IBOutlet var txtPassword: UITextField!
//    
//    @IBOutlet var lblName: UILabel!
//    @IBOutlet var lblPass: UILabel!
//    @IBOutlet var btnRetrive: UIButton!
//    @IBOutlet var btnLogin: UIButton!
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        for all in txtView{
//            all.layer.borderColor =  UIColor.lightGray.cgColor
//            all.layer.borderWidth  = 0.5
//        }
//        
//        lblName.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "userId", comment: "")
//        lblPass.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: "")
//        btnRetrive.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "retrive", comment: ""), for: .normal)
//        btnLogin.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: ""), for: .normal)
//        
//        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
//            txtName.textAlignment = .right
//            txtPassword.textAlignment = .right
//        }else{
//            txtName.textAlignment = .left
//            txtPassword.textAlignment = .left
//        }
//    }
//    
//    func loginUser(){
//        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.large
//        loadingIndicator.startAnimating();
//        
//        self.view.addSubview(loadingIndicator)
//        
//        
//        StylzAPIFacade.shared.login(name: txtName.text ?? "", password: txtPassword.text ?? "") { (aRes) in
//            DispatchQueue.main.async {
//                loadingIndicator.removeFromSuperview()
//            }
//            if aRes?.statusCode == 200{
//                if aRes?.json?["status"].stringValue == "true"{
//                    saveUserDetails(userDetails: (StylzAPIFacade.shared.session?.currentUser)!)
//                
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
//                    vc?.modalPresentationStyle = .fullScreen
//                    self.present(vc!, animated: false)
//                    
//                }
//                else{
//                    if let error = aRes?.json?["error"].array{
//                        if error.count > 0{
//                            showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
//                        }else{
//                            showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
//                        }
//                    }else{
//                        showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
//                    }
//                }
//            }else{
//                if let error = aRes?.json?["error"].array{
//                    if error.count > 0{
//                        showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
//                    }else{
//                        showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
//                    }
//                }else{
//                    showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
//                }
//            }
//        }
//    }
//    
//    
//    @IBAction func btnSignUp(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.signUp) as! SignUpViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false)
//    }
//    
//    @IBAction func btnPassword(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.recovery) as! RecoveryViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: false)
//    }
//    
//    
//    @IBAction func btnLogin(_ sender: Any) {
//        if txtName.text == ""{
//            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_username", comment: ""), sender: self)
//            return
//        }else if txtPassword.text == ""{
//            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "enter_password", comment: ""), sender: self)
//            return
//        }
//        
//        self.loginUser()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        animationScaleEffect(view: viewCol)
//    }
//    
//    
//}
//
