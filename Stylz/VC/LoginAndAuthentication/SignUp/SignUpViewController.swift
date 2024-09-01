//
//  SignUpViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 26/02/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var txtView: [UIView]!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var imgAccept: UIImageView!
    @IBOutlet var lblPrivacy: UILabel!
    
    var accpet = false

    override func viewDidLoad() {
        super.viewDidLoad()

        for all in txtView{
            all.layer.borderColor =  UIColor.lightGray.cgColor
            all.layer.borderWidth  = 0.5
        }
        
        let strNumber: NSString = "I agree to Privacy policy" as NSString // you must set your
        let range = (strNumber).range(of: "Privacy policy")
        let attribute = NSMutableAttributedString.init(string: strNumber as String)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: range)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Poppins-Regular", size: 16.0)! , range: range)
        attribute.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.thick.rawValue , range: range)
        lblPrivacy.attributedText = attribute
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationScaleEffect(view: viewCol)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func btnAccept(_ sender: Any) {
        if accpet == true{
            accpet = false
            imgAccept.image = UIImage(named: "square")
        }else{
            accpet = true
            imgAccept.image = UIImage(named: "checkmark.square.fill")
        }
    }

}
