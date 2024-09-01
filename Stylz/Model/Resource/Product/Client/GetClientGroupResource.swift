//
//  getClientGroupResource.swift
//  Stylz
//
//  Created by abcd on 01/05/2024.
//

import Foundation
import StylzWebkit

struct GetClientGroupResource{
    
    func getClientGroup(completionHandler:@escaping(_ groups: [Categories]?)->()) {
        
        StylzAPIFacade.shared.getClientGroup { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    var categories = [Categories]()
                    if let data = aRes?.json?["data"].array{
                        print("fetching id \(data)")
                        for m in data{
                            let booking = Categories(groupjson: m)
                            categories.append(booking)
                            
                        }
                    }
                     
                    completionHandler(categories)
                    
                }else{
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
            
        }
    }
    
}
