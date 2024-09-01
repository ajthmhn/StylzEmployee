//
//  APIHandler_SelectDateView.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit

//MARK: - reschedulee
extension SelectDateViewController{
    
    func moveToThanKsViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.success) as! SuccessViewController
        showSuccess(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "thank_you", comment: ""), subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointment_resceduled", comment: ""), view: vc.view)
        vc.isRescedule = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    // updated -
    func reSceuleAppointment(){
        
        let loadingIndicator = self.getIndicator(controller:self)
        
        
        let appointmentId = appointmentDetails?.id ?? 0
        
     //   if selectedTime < timings.count{
            let starTime = timings[selectedTime].start_time ?? ""
       // }
        
        // let endTime = timings[selectedTime].end_time ?? ""
        // let salonId = appointmentDetails?.salon_id ?? 0
        let date = lblDate.text  ?? ""
        
        let request  =  RescheduleAppointmentRequest(appointmentID: appointmentId, date: date, startTime: starTime)
        
        print(request)
        let resource = RescheduleAppointmentReesource()
        resource.resceduleAppointment(request: request) { errMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if errMsg != nil, let errMsg{
                    showAlert(title: "", subTitle: errMsg, sender: self)
                }else{
                    self.moveToThanKsViewController()
                }
                
            }
        }
    }
}


//MARK: - get timings
extension SelectDateViewController{
    
    
    func updateTimingCollectionView(){
        self.colTimings.reloadData()
        
        let label = getNoDataLabel(tableORColView: colTimings)
        
        if self.timings.count == 0{
            self.colTimings.backgroundView = label
        }else{
            self.colTimings.backgroundView = nil
        }
        
    }
    
    
    func getTimings(){
        
        self.timings.removeAll()
        self.selectedTime = -1
        
        let loadingIndicator  = self.getIndicator(controller: self)
    
        let branchId = getBrannchCode()
        let request = GetTimingsRequest(services: appointmentDetails?.services, isReschedule: isRescedule, isReorder: false, date: lblDate.text ?? "", branchId:branchId)
        
        print("~ getTimings \(request.getRequestBody())")
        
        let resource = GetTimingsResource()
        
        resource.checkAvailabilityy(request: request) { timings in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if let timings{
                    self.timings = timings
                }
                
                self.updateTimingCollectionView()
            }
        }
    }
}
