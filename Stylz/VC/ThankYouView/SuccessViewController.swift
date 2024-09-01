//
//  SuccessViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 01/03/23.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet var viewCol: [UIView]!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblSub: UILabel!
    @IBOutlet var btnBackService: UIButton!


    var isRescedule = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emptyCart()
        
        isWalkin(value: false)
      
        localizeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        animationScaleEffect(view: viewCol)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigateBack()
    }
}


//MARK: - handle navigation
extension SuccessViewController{

    func navigateBack(){
        if self.navigationController == nil{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "root_vc")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: false)
        }else{
            self.navigationController?.popToRootViewController(animated: false)
        }
    }
}


//MARK: - localize
extension SuccessViewController{
    func localizeView(){
        
        if isRescedule == true{
            lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "thank_you", comment: "")
            lblSub.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointment_resceduled", comment: "")
        }else{
            lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "thank_you", comment: "")
            lblSub.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email_send", comment: "")
        }
        
        btnBackService.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "back_service", comment: ""), for: .normal)
    }
}

//MARK: - delete cart details
extension SuccessViewController{
    
    func emptyCart(){
        var data = getCartData()
        data?.removeAll()
        
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "cart_details")
        defaults.synchronize()
        
    }
    
}

