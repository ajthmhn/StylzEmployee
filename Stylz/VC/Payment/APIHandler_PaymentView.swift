//
//  APIHandler_Payment.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation

//MARK: - checkout api
extension PaymentViewController{
    
    func moveToSuccessView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.success) as! SuccessViewController
        
        showSuccess(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "checkout_succcess", comment: ""), subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "email_send", comment: ""), view: vc.view)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    func doCheckout(){
        
        let loadingIndicator = getIndicator(controller: self)
        
        let appointmentID = self.appointment?.id ?? 0
        let paymentMethod = self.paymentType
        let vatPercentage = self.appointment?.customer_prepaid == 0 ? K.User.vatValue : 0.0
        let isPaid = self.appointment?.customer_prepaid == 0 ? false : true
        
        let request = CheckOutRequest(appointmentID: appointmentID, vat_peercentage: vatPercentage, paymentMethod: paymentMethod, services: appointment?.services, isPaid: isPaid)
        
        print(request.getRequestBody())
        
        let resource = CheckoutResource()
        resource.walkinCheckout(request: request) { errMsg in
            
            DispatchQueue.main.async{
                
                loadingIndicator.removeFromSuperview()
                
                if errMsg != nil{
                    
                    if let delegate = self.paymentDelegate{
                        delegate(errMsg)
                    }
                }
                else{
                    print("move to success")
                    self.moveToSuccessView()
                }
            }
        }
        
    }
}
