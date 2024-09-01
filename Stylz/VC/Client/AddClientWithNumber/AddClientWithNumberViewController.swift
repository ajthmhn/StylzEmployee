//
//  AddClientWithNumberViewController.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import UIKit
import StylzWebkit

class AddClientWithNumberViewController: BaseViewController {
    
    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var btnAdd: UIButton!
    
    var addClientDelegate : (([Employee]?, Int?) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        txtPhone.delegate = self
        
        setLanguage()
        
        setTxtFieldALignment(tf: txtPhone)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationScaleEffect(view: viewCol)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        //    self.navigationController?.popViewController(animated: false)
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAddClient(_ sender: Any) {
        sendOTP()
    }
    
}


//MARK: - ui
extension AddClientWithNumberViewController{
    
    func setLanguage(){
        
        lblPhone.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone_no", comment: "")
        
        btnAdd.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.sendOTP, comment: ""), for: .normal)
        
        //   btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
    }
}



//MARK: - textfield delegate
extension AddClientWithNumberViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        switch textField {
        case txtPhone :
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: "0123456789") &&
            prospectiveText.count <= 9
            
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
