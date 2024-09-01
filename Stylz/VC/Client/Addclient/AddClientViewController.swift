//
//  AddClientViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 16/03/23.
//

import UIKit
import StylzWebkit

class AddClientViewController: BaseViewController {
    
    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPhone: UITextField!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEMail: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var btnBack: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLanguage()
        configTextfield()
        handleTxtFieldAlignment()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationScaleEffect(view: viewCol)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        //   self.navigationController?.popViewController(animated: false)
        //     self.dismiss(animated: true)
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func btnAddClient(_ sender: Any) {
        doAddClient()
    }
}


//MARK: - ui
extension AddClientViewController{
    
    func handleTxtFieldAlignment(){
        setTxtFieldALignment(tf: txtName)
        setTxtFieldALignment(tf: txtEmail)
        setTxtFieldALignment(tf: txtPhone)
    }
    
    func configTextfield(){
        txtName.delegate = self
        txtEmail.delegate = self
        txtPhone.delegate = self
    }
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_client", comment: "")
        lblName.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "full_name", comment: "")
        lblEMail.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: "")
        lblPhone.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "phone_no", comment: "")
        btnAdd.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_client", comment: ""), for: .normal)
    }
    
}



//MARK: - textfield delegate
extension AddClientViewController:UITextFieldDelegate{
    
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
