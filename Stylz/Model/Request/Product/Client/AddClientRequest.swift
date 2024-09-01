//
//  AddClientRequest.swift
//  Stylz
//
//  Created by abcd on 02/05/2024.
//



import Foundation
import StylzWebkit


struct AddClientRequest {
    
    let phone:String
    let name:String
    let email:String
    let gender:Int
    let branchID:Int
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        
        details["first_name"] = name
        details["branch_id"] = branchID
        details["email"] = email
        details["gender"] = gender
        details["phone"] = phone
        
        return details
    }
    
}




