//
//  GetTimingsResource.swift
//  StylezUser
//
//  Created by mac on 18/03/2024.
//

import Foundation
import StylzWebkit

struct GetTimingsResource{
    
    func checkAvailabilityy(request:GetTimingsRequest,completionHandler:@escaping (_ timings:  [Timings]?)->()) {
        
        
        StylzAPIFacade.shared.checkAvailabilityy(data: request.getRequestBody()){ (aRes) in
            
            if aRes?.statusCode == 200{
                
                if aRes?.json?["status"].intValue == 200{
                
                    var timings = [Timings]()
                    
                    if let data = aRes?.json?["data"].array{
                
                        for m in data{
                            let booking = Timings(json: m)
                            timings.append(booking)
                        }
                    }
                    
                    completionHandler(timings)
                    
                }
                else{
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}
