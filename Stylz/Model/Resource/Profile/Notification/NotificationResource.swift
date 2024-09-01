//
//  NotificationResource.swift
//  StylezUser
//
//  Created by MACBOOK on 3/6/24.
//

import Foundation


import StylzWebkit

struct NotificationReosurce{
    
    func getNotifications(request:NotificationRequest,completionHandler:@escaping (_ notifications: [NOtifications]?)->()) {
        
        StylzAPIFacade.shared.getNotifications(gender: request.gender)
        { (aRes) in
            
            if aRes?.statusCode == 200{
                
                if aRes?.json?["status"].intValue == 200{
                    var notifications = [NOtifications]()
                    
                    if let data = aRes?.json?["data"].array{
                        print("~data: \(data)")
                        for m in data{
                            let booking = NOtifications(json: m)
                            notifications.append(booking)
                        }
                    }
                    completionHandler(notifications)
                }else{
                    completionHandler(nil)
                }
            }
            else{
                completionHandler(nil)
            }
        }
    }
}
