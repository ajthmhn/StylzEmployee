//
//  SendVerifyOtpResource.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//

import Foundation
import StylzWebkit


struct SendOtpFroClientResource{
    
    func sendOTPForClient(request:SendOtpForClientRequest,completionHandler:@escaping (_ employees: [Employee]?,_ phoneOTP:Int?,_ errMsg:String?)->()) {
        
        print(request)
        StylzAPIFacade.shared.sendOTPForClient(data:request.getRequestBody()){ (aRes) in
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    
                    
                    let otp = aRes?.json?["phone_otp"].intValue
                  
                    if let otp, otp != 0
                    {
                        completionHandler(nil, otp, nil)
                        return
                    }
                    
                    else{
                        var employeeList = [Employee]()
                        let employee = Employee(ClientJson: aRes?.json?["data"])
                        employeeList.append(employee)
                        
                        print("in empliyee \(employeeList)")
                        
                        if employeeList.count>0{
                            completionHandler(employeeList,nil,nil)
                            return
                        }
                    }
                    completionHandler(nil,nil,getErrMsg(json: aRes?.json))
                    
                }else{
                    
                    completionHandler(nil,nil,getErrMsg(json: aRes?.json))
                }
            }else{
                
                completionHandler(nil,nil,getErrMsg(json: aRes?.json))
            }
        }
    }
}
