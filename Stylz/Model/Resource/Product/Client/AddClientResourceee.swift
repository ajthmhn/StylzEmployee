//
//  AddClientResourceee.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation
import StylzWebkit

struct AddClientResourceee{
    
    func addClient(request:AddClientRequest,completionHandler:@escaping (_ err: String?)->()) {
        
        print(request)
        StylzAPIFacade.shared.addClient(data:request.getRequestBody()){ (aRes) in
            print("code \(aRes?.statusCode)")
            if aRes?.statusCode == 201{
                if aRes?.json?["status"].intValue == 201{
                    
                    completionHandler(nil)
                }else{
                    
                    completionHandler(getErrMsg(json: aRes?.json))
                  }
            }else{
                
                completionHandler(getErrMsg(json: aRes?.json))
       }
        }
    }
}
