//
//  CartViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit

class CartViewController: UIViewController {
    
    struct VCConst {
        static let cellId  = "cart_cell_id"
    }
    
    @IBOutlet var lblProceed: UILabel!
    @IBOutlet var btnCash: [UIButton]!
    @IBOutlet var lblSub : UILabel!
    @IBOutlet var lblVat : UILabel!
    @IBOutlet var lblTotal : UILabel!
    @IBOutlet var lblCheckout : UILabel!
    @IBOutlet var viewWalkin : UIView!
    @IBOutlet var bottomHeight : NSLayoutConstraint!
    
    @IBOutlet var lblHead : UILabel!
    @IBOutlet var lblService : UILabel!
    @IBOutlet var lblSubHead : UILabel!
    @IBOutlet var lblTotalHead : UILabel!
    @IBOutlet var btnBack : UIButton!
    @IBOutlet var lblVAThead : UILabel!
    
    
    var paymentType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInitialView()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
        setCartPriceLabels()
        
        viewWalkin.isHidden = true
        bottomHeight.constant = 80
        
        setLanguage()
        
        //        if checkWalkin() == true{
        //            viewWalkin.isHidden = false
        //            bottomHeight.constant = 150
        //        }else{
        //            viewWalkin.isHidden = true
        //            bottomHeight.constant = 80
        //        }
        
    }
    
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnCash(_ sender: UIButton) {
        self.handlePaymentOption(sender: sender)
    }
    
    
    @IBAction func btnContinue(_ sender: Any) {
        self.moveToSelectDateView()
    }
    
}




//MARK: -  handle payment btn
extension CartViewController{
    
    func handlePaymentOption(sender:UIButton){
        for all in btnCash{
            all.setTitleColor(UIColor.black, for: .normal)
            all.layer.cornerRadius = 10
            all.layer.masksToBounds = true
            all.layer.borderWidth = 1
            all.layer.borderColor = UIColor.black.cgColor
            all.backgroundColor = UIColor.white
            all.imageView?.setImageColor(color: UIColor.black)
        }
        btnCash[sender.tag].layer.borderColor = UIColor(hexString: "61AB9A")!.cgColor
        btnCash[sender.tag].backgroundColor = UIColor(hexString: "61AB9A")!
        btnCash[sender.tag].imageView?.setImageColor(color: UIColor.white)
        btnCash[sender.tag].setTitleColor(UIColor.white, for: .normal)
        
        animationScaleEffectSingle(view: btnCash[sender.tag])
        paymentType = sender.tag + 1
    }
}




//MARK: - handle continue btn - move to scheduling view
extension CartViewController{
    
    func moveToSelectDateView(){
        
        //  if checkWalkin() == true{
        //      if paymentType == 0{
        //           showAlert(title: "", subTitle: "Select a payment method", sender: self)
        //           return
        //       }
        
        //       let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.payment) as! PaymentViewController
        //      vc.modalPresentationStyle = .popover
        //    vc.paymentType = self.paymentType
        //       vc.sub = self.lblSub.text ?? ""
        //       vc.vat = self.lblVat.text ?? ""
        //       vc.total = self.lblTotal.text ?? ""
        //       self.present(vc, animated: true)
        //    }else{
        
        if let cartData = getCartData() , cartData.count > 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.selectDate) as! SelectDateViewController
            self.navigationController?.pushViewController(vc, animated:  false)
            
        }
        else{
        showEmptyCartAlertAndPopBack()
        }
        
        //  }
    }
    
    
    func showEmptyCartAlertAndPopBack(){
        
        let emptyCartmsg = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.cartIsEmpty, comment: "")
      
        let alertController = UIAlertController(title: "", message: emptyCartmsg , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.navigationController?.popViewController(animated: false)
        }
    
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
       
    }
}
