//
//  PaymentViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 14/03/23.
//

import UIKit
import StylzWebkit

class PaymentViewController: BaseViewController {

    @IBOutlet var btnCash: [UIButton]!
    @IBOutlet var viewBalance: UIView!
    @IBOutlet var lblPaid: UILabel!
    @IBOutlet var viewSplit: UIView!
    
    @IBOutlet var lblSub: UILabel!
    @IBOutlet var lblVat: UILabel!
    @IBOutlet var lblTotal: UILabel!

    @IBOutlet var txtPaid: UITextField!
    @IBOutlet var txtSplit: UITextField!
    @IBOutlet var txtBalance: UITextField!
    @IBOutlet var btnContinue: UIButton!
    @IBOutlet var lblSubHead: UILabel!
    @IBOutlet var lblTiotalHead: UILabel!
    @IBOutlet var lblBalanceHad: UILabel!
    @IBOutlet var lblCashHead: UILabel!
    @IBOutlet var lblVatHead: UILabel!
   
    @IBOutlet var pamentMethodStackView: UIStackView!
    @IBOutlet var lblDiscountHead: UILabel!
    @IBOutlet var lblDiscount: UILabel!

    
    var paymentDelegate : ((String?) -> ())?

    
    
    var paymentType = 1
    var total = ""
    var sub = ""
    var vat = ""
    var vatPercentage = ""
    var appointment : Appointments?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateEntireView(tag: paymentType - 1)
        
        
        setLanguage()
        
        setPaymentValues()
        
        //setPaymentMethodView()
        
        setViewForPaidAppointment()
   
        configTF()
        
    }
    
    
 
    
    
    @IBAction func btnCash(_ sender: UIButton) {
        updateEntireView(tag: sender.tag)
        
    }

    @IBAction func btnConfirm(_ sender: UIButton) {
        doCheckout()
    }
    
  
}

//MARK: - ui
extension PaymentViewController{
    
    func setPaymentValues(){
        
        lblSub.text = sub
        lblVat.text = vat
        lblTotal.text = total
       
        txtPaid.text = total.replacingOccurrences(of: "SAR ", with: "")
        txtBalance.text = "0.0"
        txtSplit.text = "0.0"
        
        lblDiscount.text = "SAR \(appointment?.discount ?? 0.0)"
       
    }
    
    func setViewForPaidAppointment(){
      
        if appointment?.customer_prepaid != 0 {
            pamentMethodStackView.isHidden = true
            
        }
        else{
            updateEntireView(tag:1)
        }
 
        let vatPercentage = self.appointment?.customer_prepaid == 0 ? K.User.vatValue : 0.0
    
        lblVatHead.text = "VAT (\(vatPercentage))%"
    }
    
//    func setPaymentMethodView(){
//       
//        if paymentType == 3{
//            viewSplit.isHidden = false
//            lblPaid.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cash_paid", comment: "")
//            lblCashHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "online_paid", comment: "")
//
//        }else{
//            lblPaid.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cash_paid", comment: "")
//            viewSplit.isHidden = true
//        }
//        
//        
//        if paymentType == 1{
//            viewBalance.isHidden = true
//        }else{
//            viewBalance.isHidden = false
//        }
//    }
    
    
    func updateEntireView(tag:Int){
     
        for all in btnCash{
            all.setTitleColor(UIColor.black, for: .normal)
            all.layer.cornerRadius = 10
            all.layer.masksToBounds = true
            all.layer.borderWidth = 1
            all.layer.borderColor = UIColor.black.cgColor
            all.backgroundColor = UIColor.white
            all.imageView?.setImageColor(color: UIColor.black)
        }
       
        btnCash[tag].layer.borderColor = UIColor(hexString: "61AB9A")!.cgColor
        btnCash[tag].backgroundColor = UIColor(hexString: "61AB9A")!
        btnCash[tag].imageView?.setImageColor(color: UIColor.white)
        btnCash[tag].setTitleColor(UIColor.white, for: .normal)
        
        animationScaleEffectSingle(view: btnCash[tag])
        paymentType = tag + 1
        
        if paymentType == 1{
            viewBalance.isHidden = true
        }else{
            viewBalance.isHidden = false
        }
        
        txtPaid.text = total.replacingOccurrences(of: "SAR ", with: "")
        txtBalance.text = "0.0"
        txtSplit.text = "0.0"

        if paymentType == 3{
            viewSplit.isHidden = false
            lblPaid.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cash_paid", comment: "")
            lblCashHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "online_paid", comment: "")
        }else{
            lblPaid.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cash_paid", comment: "")
            viewSplit.isHidden = true
        }
    }
    
    
    func setLanguage(){
        btnCash[0].setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "card", comment: ""))", for: .normal)
        btnCash[1].setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "cashs", comment: ""))", for: .normal)
        btnCash[2].setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "split", comment: ""))", for: .normal)
        lblSubHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "subtotal", comment: "")
        lblTiotalHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "total", comment: "")
        btnContinue.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "cvonfirm_payment", comment: ""), for: .normal)
        lblBalanceHad.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "balance", comment: "")
        lblCashHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cash_paid", comment: "")
        
        
             lblDiscountHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Discount", comment: "")
           
    }
    
    
}


//MARK: - textfield handler

extension PaymentViewController{
    
    func configTF(){
        txtPaid.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
     
        txtSplit.addTarget(self, action: #selector(textFieldDidChangeSplit(textField:)), for: UIControl.Event.editingChanged)

    }
    
    @objc func textFieldDidChange(textField : UITextField){
        let total = total.replacingOccurrences(of: "SAR ", with: "")
        var paid = txtPaid.text
        
        
        if paid?.trimmingCharacters(in: .whitespaces) == ""{
            paid = "0.0"
            btnContinue.isEnabled = false
            btnContinue.backgroundColor = UIColor.lightGray
        }else{
            btnContinue.isEnabled = true
            btnContinue.backgroundColor = UIColor(hexString: "61AB9A")
        }
    
        if paymentType == 3{
            
            if Double(paid ?? "0.0")! >  Double(total)!{
                let balance = Double(total)! - Double(paid ?? "0.0")!
                txtBalance.text = "\(abs(balance))"
                txtSplit.text = "0.0"
            }else{
                let balance = Double(total)! - Double(paid ?? "0.0")!
                txtSplit.text = "\(abs(balance))"
                txtBalance.text = "0.0"
            }
         
        }else{
            let balance = Double(total)! - Double(paid ?? "0.0")!
            txtBalance.text = "\(abs(balance))"
        }
        
      
    }
    
    @objc func textFieldDidChangeSplit(textField : UITextField){
        let total = total.replacingOccurrences(of: "SAR ", with: "")
        var online = txtPaid.text ?? "0.0"
        var cash = txtSplit.text ?? "0.0"
        
        if online.trimmingCharacters(in: .whitespaces) == ""{
            online = "0.0"
        }
        
        if cash.trimmingCharacters(in: .whitespaces) == ""{
            cash = "0.0"
        }
        
        // crashed here while making changes in the
        txtPaid.text = "\(Double(total)! - Double(cash)!)"
        
        let paid  = Double(online)! - Double(cash)!
        
        if paid == 0 || paid == 0.0{
            btnContinue.isEnabled = false
            btnContinue.backgroundColor = UIColor.lightGray
        }else{
            btnContinue.isEnabled = true
            btnContinue.backgroundColor = UIColor(hexString: "61AB9A")
        }
        
        if Double(cash)! >  Double(total)!{
            let balance = Double(total)! - Double(cash)!
            txtBalance.text = "\(abs(balance))"
            txtPaid.text = "0.0"
        }else{
            txtBalance.text = "0.0"
        }
    }
}
