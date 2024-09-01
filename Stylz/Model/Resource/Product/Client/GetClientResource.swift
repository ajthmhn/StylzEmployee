//
//  GetClientResource.swift
//  Stylz
//
//  Created by abcd on 01/05/2024.
//


import Foundation
import StylzWebkit

struct getClientListResource{
    
    func getClientList(request:GetClientListRequest,completionHandler:@escaping (_ employee: [Employee]?)->()) {
        
        StylzAPIFacade.shared.getClientList(id: request.groupId, search: request.searchTerm) { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                
                    var employeeList = [Employee]()
                    
                    if let data = aRes?.json?["data"].array{
                    
                        for m in data{
                            let booking = Employee(ClientJson: m)
                            employeeList.append(booking)
                        }
                    }
                    
                    completionHandler(employeeList)
                    
                }else{
                    completionHandler(nil )
                }
            }
            else{
                completionHandler(nil )
            }
            
        }
    }
    
}
