//
//  UIHandler_AppointmentDetailsView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit

//MARK: - ui
extension AppointmentDetailsViewController{
  
    
    func handleBillDetails(){ // not using
        
        //MARK:- bil details
        
//                if appointments?.billDetails.count ?? 0 > 0{
//                    btnCheckout.isHidden = true
//                    btnCancel.isHidden = true
//                    btnRescehulde.isHidden = true
//                    bottomHeight.constant = 0
//                }else{
//                    bottomHeight.constant = 180
//                    btnCancel.isHidden = false
//                    btnRescehulde.isHidden = false
//                    btnCheckout.isHidden = false
//                    btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "checkout", comment: ""), for: .normal)
        //        }
    }
    
    
    func setViewForPaidAndUnpaidAppointment(){
        
        if appointments?.appointment_status == 1 || appointments?.appointment_status == 4 {
            bottomHeight.constant = 180
            btnCancel.isHidden = false
            btnRescehulde.isHidden = false
            btnCheckout.isHidden = false
        }else{
            btnCheckout.isHidden = true
            btnCancel.isHidden = true
            btnRescehulde.isHidden = true
            bottomHeight.constant = 0
        }
    }
    
    func populateViewWithData(){
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
        //btnCancel.layer.borderWidth = 1
        //btnCancel.layer.borderColor = UIColor(hexString: "FF3386")?.cgColor
        
        //btnRescehulde.layer.borderWidth = 1
        //btnRescehulde.layer.borderColor = UIColor.black.cgColor
        
        
        mobileLbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.phone, comment: "")):"
        
        emailLbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.email, comment: "")):"
   
        
        lblDate.text = getFormatedDate2(dateString: appointments?.start_time ?? "", requiredformat: K.DateFormats._dateLocale)
        
        lblTime.text = getFormatedDate2(dateString: appointments?.start_time ?? "", requiredformat: K.DateFormats.timeLocale)
        
        lblCustomerName.text = appointments?.customerName
        lblCustomerMobile.text = appointments?.customerPhone
        lblCustomerEmail.text = appointments?.customerEmail
        
    }
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointments", comment: "")
        lblDateHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "date", comment: "")
        lblTimeHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "time", comment: "")
        lblClientHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "client", comment: "")
        btnCancel.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: ""), for: .normal)
        btnRescehulde.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "rescedule", comment: ""), for: .normal)
        
        
        btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "checkout", comment: ""), for: .normal)
        
    }
    
    func handlePamentStatusTag(){
    
        if appointments?.customer_prepaid == 0 {
        
            btnPaymentStatus.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.unPaid, comment: ""), for: .normal)
            btnPaymentStatus.tintColor = getDarkColor(red: true)
            
            btnPaymentStatus.backgroundColor = getDarkColor(red: true).withAlphaComponent(0.3)
        
            }
        else{
          
            btnPaymentStatus.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.paid, comment: ""), for: .normal)
            btnPaymentStatus.tintColor = getDarkColor(red: false)
            
            btnPaymentStatus.backgroundColor = getDarkColor(red: false).withAlphaComponent(0.3)
          
      }
    }
}


//MARK: - table vieew
extension AppointmentDetailsViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments?.services.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.serviceCellId) as! ServiceListCell
        animationScaleEffectSingle(view: cell)
        cell.selectionStyle = .none
        
        /// cell.lblName.text = appointments?.services[indexPath.row].employee_first_name
        cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? appointments?.services[indexPath.row].service_name_ar :  appointments?.services[indexPath.row].service_name_en
        cell.lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(appointments?.services[indexPath.row].service_amount ?? "")"
        cell.lblDuration.text = appointments?.services[indexPath.row].service_duration
        
        
        //   setImage(imageView: cell.imgProduct, url: appointments?.services[indexPath.row].employee_image ?? "")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
