//
//  CheckoutResource.swift
//  Stylz
//
//  Created by abcd on 05/05/2024.
//



import Foundation
import StylzWebkit


struct CheckoutResource{
    
    func walkinCheckout(request:CheckOutRequest,completionHandler:@escaping (_ errMsg: String?)->()) {
        
        StylzAPIFacade.shared.walkinCheckout(data: request.getRequestBody()) { (aRes) in
            print("! \(aRes?.json), code: \(aRes?.statusCode)")
            
            if aRes?.statusCode == 200{
                if aRes?.json?["message"].stringValue == "Invoice generated successfully!"{
                    completionHandler(nil)
                    return
                }
                else{
                    completionHandler(getErrMsg(json: aRes?.json))
                }
            }
            else{
                
                completionHandler(getErrMsg(json: aRes?.json))
                
            }
        }
    }
}
