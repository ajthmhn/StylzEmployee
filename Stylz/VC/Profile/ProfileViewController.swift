//
//  ProfileViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 09/03/23.
//

import UIKit
import StylzWebkit


class ProfileViewController: BaseViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var lblName: UITextField!
    @IBOutlet var lblEmail: UITextField!
    @IBOutlet var lblPhone: UITextField!
    @IBOutlet var lblAccount: UITextField!
    @IBOutlet var btnUpdate: UIButton!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var btnBack: UIButton!
 
    @IBOutlet var BtnEdit: UIButton!
 
    @IBOutlet var editableViews: [UIView]!
    @IBOutlet var btnChangePassword: UIButton!
    @IBOutlet var lblRating: UILabel!
   
    
    var imagePicker = UIImagePickerController()
    var imageSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeFieldState(isEnabled: false)
        updateUI()
        updateEmployeeDetails()
        localizeView()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        fetchEmployeeInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        animationScaleEffect(view: viewCol)
       
        for all in viewCol{
            all.dropShadow()
        }
        
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        doUpdateProfile()
    }
    
    @IBAction func btnSelectImage(_ sender: UIButton) {
        presentImagePicker()
    }
    
    @IBAction func onClick_EditBtn(_ sender: UIButton) {
       doEnableFieldsForEditing()
    }
    
    @IBAction func btnPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.updatePass) as! UpdatePasswordViewController
        vc.isChangePassword = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
}



