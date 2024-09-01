//
//  UIAndTableViewHandler_AppoitmentView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit



//MARK: - ui
extension AppointmentsViewController{

    func localizeView(){
      
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointments", comment: "")
        lblUpcomin.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "upcoming_appoinments", comment: "")
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            if languageChange == true{
                self.calender.transform = CGAffineTransform(scaleX: -1, y: 1);
                self.calender.calendarWeekdayView.transform = CGAffineTransform(scaleX: -1, y: 1);
            }
            
            let loc = Locale(identifier: "en")
            self.calender.locale = loc
        }
        else{
            let loc = Locale(identifier: "en")
            self.calender.locale = loc
        }
    }
}



//MARK: - table view
extension AppointmentsViewController : UITableViewDataSource, UITableViewDelegate{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! AppointmentListCell
        
        animationScaleEffectSingle(view: cell)
        
        cell.viewBg.dropShadow()
        
        
        if appointments.count <= indexPath.row{
            return UITableViewCell()
        }
        
        cell.lblName.text = appointments[indexPath.row].customerName
        
        //        var name = [String]()
        //        for all in appointments[indexPath.row].services{
        //            name.append(all.employee_first_name ?? "")
        //        }
        
        var services = [String]()
       
        for all in appointments[indexPath.row].services{
            services.append(LocalizationSystem.sharedInstance.getLanguage() == "ar" ? all.service_name_ar ?? "" : all.service_name_en ?? "")
        }
        //\(name.joined(separator: ", "))\n
        
        let itrems =  "\(services.joined(separator: ", "))"
        
        cell.lblAddress.text = itrems
        
        cell.lblDate.text = getDateSting(date: appointments[indexPath.row].date ?? "", time: appointments[indexPath.row].start_time ?? "")
       
        
        setImage(imageView: cell.imgBarber, url: appointments[indexPath.row].customerImage ?? "")
        
        
        if appointments[indexPath.row].appointment_status != 3{
            cell.imgPaid.isHidden = false
        }else{
            cell.imgPaid.isHidden = true
        }
        
        if appointments[indexPath.row].customer_prepaid == 0 {
            cell.paymentStatus.text = LocalizationSystem.sharedInstance
                .localizedStringForKey(key: K.MYStrings.unPaid, comment: "")
            cell.paymentStatus.textColor = getDarkColor(red: true)
            
        }
        else{
            cell.paymentStatus.text = LocalizationSystem.sharedInstance
                .localizedStringForKey(key: K.MYStrings.paid, comment: "")
            cell.paymentStatus.textColor = getDarkColor(red: false)
        }
        
        
        //        "\(appointments[indexPath.row].date ?? "") - \(appointments[indexPath.row].start_time ?? "")"
        
        //        if appointments[indexPath.row].billDetails.count > 0{
        //         print("appointments[indexPath.row].billDetails.count > 0 = true")
        //            cell.imgPaid.isHidden = true
        //        }else{
        //            print("appointments[indexPath.row].billDetails.count > 0 = false")
        //               cell.imgPaid.isHidden = false
        //        }
        
        cell.deleteTappedActions { aCell in
         
            let latDouble = self.appointments[indexPath.row].salon_latitude
            let longDouble = self.appointments[indexPath.row].salon_longitude
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
                
                if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(latDouble ?? 0.0),\(longDouble ?? 0.0)&directionsmode=driving") {
                    UIApplication.shared.open(url, options: [:])
                }}
            else {
                //Open in browser
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latDouble ?? 0.0),\(longDouble ?? 0.0)&directionsmode=driving") {
                    UIApplication.shared.open(urlDestination)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.appointmnentDetail) as! AppointmentDetailsViewController
        vc.appointments = self.appointments[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    func getDateSting(date:String?, time:String?)-> String {
        
        let formattedDate = getFormatedDate2(dateString: date ?? "", requiredformat: K.DateFormats.dateLocale)
        
        let formattedTime = getFormatedDate2(dateString:time ?? "" , requiredformat: K.DateFormats.timeLocale)
        
        return "\(formattedDate) - \(formattedTime)"
    }
    
    
}

