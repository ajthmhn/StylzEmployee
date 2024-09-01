//
//  GetClientListRequest.swift
//  Stylz
//
//  Created by abcd on 01/05/2024.
//

import Foundation

struct GetClientListRequest {
        let searchTerm:String?
        let groupId:Int
       
        func getRequestBody() -> [String:Any]{
            
            let details = [String:Any]()
          
            return details
        }
}
