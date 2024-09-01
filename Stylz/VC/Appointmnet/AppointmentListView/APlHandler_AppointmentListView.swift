//
//  APlHandler_AppointmentListView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import StylzWebkit
import UIKit


//MARK: - handling API
extension AppointmentsViewController{
    
  
    func fetchDataa(){
        self.getAppointments()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.ghetAllAppointments()
        }
    }
    
    
    func updateAppointmentTableView(date:Date){
        
        self.lblNONData.isHidden = true
        self.tblServicew.reloadData()
        
        if self.appointments.count == 0{
            self.lblNONData.isHidden = false
            if self.Holidays.contains(date){
                self.lblNONData.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.branchISClosed, comment: "")
            }else{
                self.lblNONData.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_appoint", comment: "")
            }
        }
    }
    

    func getAppointments(){
     
        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        
        self.view.addSubview(loadingIndicator)
        
        let date = calender.selectedDate!
        let dateFom = DateFormatter()
        dateFom.locale = Locale(identifier:"en")
        dateFom.dateFormat = "yyyy-MM-dd"
        
        appointments.removeAll()
       
        StylzAPIFacade.shared.getAppointments(date:dateFom.string(from: date)){ (aRes) in
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
            }
            
            print("~ \(aRes?.json)")
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    if let dataObj = aRes?.json?["data"].dictionary{
                        
                        if let dataArray = dataObj["appointments"]?.array{
                            for m in dataArray{
                                let booking = Appointments(json: m)
                                self.appointments.append(booking)
                            }
                        }
                    }
                    
                }
            }
           
            DispatchQueue.main.async {
                self.updateAppointmentTableView(date: date)
            }
        }
    }
}


//MARK: - all appointments
extension AppointmentsViewController{
    
    func ghetAllAppointments(){
        dates.removeAll()
        Holidays.removeAll()
        
        StylzAPIFacade.shared.getAllAppointments(month: ""){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    if let dataObj = aRes?.json?["data"].dictionary{
                        
                        if let dataArray = dataObj["holidays"]?.array{
                            
                            for m in dataArray{
                                let booking = Appointments(json: m)
                                
                                let dateFom = DateFormatter()
                                dateFom.locale = Locale(identifier:"en")
                                dateFom.dateFormat = "yyyy-MM-dd"
                                
                                self.Holidays.append(dateFom.date(from: booking.date!)!)
                            }
                            print("holidys: array: \(self.Holidays)")
                        }
                        
                        if let dataArray = dataObj["appointments"]?.array{
                            
                            for m in dataArray{
                                let booking = Appointments(json: m)
                                
                                let dateFom = DateFormatter()
                                dateFom.locale = Locale(identifier:"en")
                                dateFom.dateFormat = "yyyy-MM-dd"
                                
                                self.dates.append(dateFom.date(from: booking.date!)!)
                                
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.calender.reloadData()
                
                if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
                    if languageChange == true{
                        self.calender.transform = CGAffineTransform(scaleX: -1, y: 1);
                        self.calender.calendarWeekdayView.transform = CGAffineTransform(scaleX: -1, y: 1);
                    }
                    let loc = Locale(identifier: "en")
                    self.calender.locale = loc
                }else{
                    let loc = Locale(identifier: "en")
                    self.calender.locale = loc
                }
                
            }
        }
    }
}
