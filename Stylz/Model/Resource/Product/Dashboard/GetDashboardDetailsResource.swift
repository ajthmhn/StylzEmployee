//
//  GetDashboardDetailsResource.swift
//  Stylz
//
//  Created by abcd on 08/05/2024.
//


import Foundation
import StylzWebkit

struct GetDashboardDetailsResource{
    
   func getDashboardDetails(request:DashboardDetailsRequest,completionHandler:@escaping (_ vatValue:Double?)->()) {
        
       StylzAPIFacade.shared.getDashboardDetails(branchID: request.branchID){ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    var salesVat:Double = 0
                 
                    if let data = aRes?.json?["data"].dictionary{
                        
                        salesVat = data["sales_vat"]?.doubleValue ?? 0.0
                    print("sales vat \(salesVat)")
                    }
                        completionHandler(salesVat)
                    }
                else{
                    
                    completionHandler(nil)
                }
            }
            else{
                completionHandler(nil)
            }
        }
    }
}
