//
//  APIHandler_Notifications.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation
import UIKit
import StylzWebkit


//MARK: - fetching notifications data
extension NotificationsViewController{
    
    func getData(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let gender = getGenderCode()
        
        let request = NotificationRequest(gender: gender)
        
        let resource = NotificationReosurce()
        
        resource.getNotifications(request: request) { notifications in
            
            self.isDataLoading = false
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if notifications != nil, let notifications{
                    
                    self.checkIfempty(notifications: notifications)
                    
                    self.notifications.append(contentsOf:  notifications)
                    
                    self.updateView()
                    
                }else{
                    self.dataEmpty = true
                    self.updateView()
                }
            }
        }
    }
    
    
    func updateView(){
        self.tblNotif.reloadData()
        
        let label = self.getNoDataLabel(tableORColView: self.tblNotif)
        
        if self.notifications.count == 0{
            self.tblNotif.backgroundView = label
        }else{
            self.tblNotif.backgroundView = nil
        }
    }
    
    
    func checkIfempty(notifications:[NOtifications]){
        if notifications.count == 0{
            self.dataEmpty = true
        }else{
            self.dataEmpty = false
        }
    }
}
