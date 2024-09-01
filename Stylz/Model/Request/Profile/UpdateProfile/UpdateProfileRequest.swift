//
//  UpdateProfileRequest.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import UIKit

struct UpdateProfileRequest {
   
    let name: String
    
    func getRequestBody() -> [String:Any]{
      
        var profDic = [String:Any]()
        
        profDic["first_name"] = name
        
    return profDic
}
}
