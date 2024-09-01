//
//  AppointmentDetailsViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 01/03/23.
//

import UIKit
import StylzWebkit

class AppointmentDetailsViewController: BaseViewController {
    
    struct VCConst {
        static let serviceCellId = "service_cell_id"
    }
    
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnRescehulde: UIButton!
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblCustomerName: UILabel!
    @IBOutlet var lblCustomerMobile: UILabel!
    @IBOutlet var lblCustomerEmail: UILabel!
    @IBOutlet var imgCustomer: UIImageView!
    @IBOutlet var btnCheckout: UIButton!
    @IBOutlet var bottomHeight: NSLayoutConstraint!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblDateHead: UILabel!
    @IBOutlet var lblTimeHead: UILabel!
    @IBOutlet var lblClientHead: UILabel!
    @IBOutlet var btnPrint: UIButton!
    @IBOutlet var btnBack: UIButton!
   
    @IBOutlet var btnPaymentStatus: UIButton!
   
    @IBOutlet var mobileLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
   
    
    var appointments : Appointments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("~ appointemnt id: \(appointments?.id) disounvt\(appointments?.discount)")
        self.populateViewWithData()
        
        self.handleBillDetails()
        
        setViewForPaidAndUnpaidAppointment()
    
        setImage(imageView: imgCustomer, url: appointments?.customerImage ?? "")
        
        setLanguage()
    
        handlePamentStatusTag()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.showCancelAppointmentAlert()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnCheckout(_ sender: Any) {
        self.moveToPaymentView()
    }
    
    @IBAction func btnRescedule(_ sender: Any) {
        self.showAppointmentSchedulingAlert()
    }
}



//MARK: - checkout

extension AppointmentDetailsViewController{
    
    func moveToPaymentView(){
        
        var totals = [Double]()
        for all in appointments?.services ?? []{
            totals.append(Double(all.service_amount ?? "0.0")!)
        }
        
        let sum = totals.reduce(0, +)
        var vat = (K.User.vatValue * sum) / 100
        
        //        if appointments?.billDetails.count ?? 0 > 0{
        //            self.navigationController?.popViewController(animated: false)
        //        }
        
        if appointments?.customer_prepaid != 0{
            vat = (0 * sum) / 100
            print("\(vat)")
        }
        
        //else{
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.payment) as! PaymentViewController
        
        vc.modalPresentationStyle = .popover
        
        vc.sub = "SAR \(sum  - vat)"
        vc.vat = "SAR \(vat)"
      //  vc.total = "SAR \(sum)"
        vc.total = "SAR \(sum - (self.appointments?.discount ?? 0.0))"
      
        
        vc.appointment = self.appointments
        vc.paymentDelegate = { err in
            self.dismiss(animated: false)
          
            if err != nil{
                showAlert(title: "", subTitle:err!, sender: self)
            }
            
        }
        self.present(vc, animated: true)
        
        //  }
    }
}



//MARK: -  reschedule appointment
extension AppointmentDetailsViewController{
    
    func showAppointmentSchedulingAlert(){
        let alertController = UIAlertController(title: "", message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "rescedule_appopint", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.moveToSelectDateView()
        }
        let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func moveToSelectDateView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.selectDate) as! SelectDateViewController
        vc.isRescedule = true
        vc.appointmentDetails = self.appointments
        self.navigationController?.pushViewController(vc, animated:  false)
    }
}
