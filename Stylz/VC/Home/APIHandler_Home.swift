//
//  APIHandler_Home.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit



//MARK: - dashboard api
extension HomeViewController{
    
    func fetchData(){
        DispatchQueue.global(qos: .userInitiated).async {
            self.getDashboarDetails()
        }
    }
    
    func getDashboarDetails(){
    
        let branchID = getBrannchCode()
        
        let request = DashboardDetailsRequest(branchID: branchID )
        
        
        let resource = GetDashboardDetailsResource()
        resource.getDashboardDetails(request: request) { vatValue in
            if let vatValue{
                K.User.vatValue = vatValue
            }
        }
     }
}
