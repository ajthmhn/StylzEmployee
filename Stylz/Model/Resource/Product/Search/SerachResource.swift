//
//  SerachResource.swift
//  Stylz
//
//  Created by abcd on 06/05/2024.
//



import Foundation
import StylzWebkit

struct SerachResource{
    
    func searchAll(request:SearchRequest,completionHandler:@escaping (_ services: [Services]?,_ errMsg:String?)->()) {
        
        StylzAPIFacade.shared.searchAll(searchTerm: request.searchTerm,branchID: request.branchID){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    var servicesList = [Services]()
                    
                    if let salons = aRes?.json?["services"].array{
                        for m in salons{
                            let booking = Services(json: m)
                            servicesList.append(booking)
                        }
                        completionHandler(servicesList,nil)
                    }
                }else{
                    
                    completionHandler(nil,getErrMsg(json: aRes?.json))
                }
            }
            else{
                completionHandler(nil,getErrMsg(json: aRes?.json))
            }
        }
    }
}
