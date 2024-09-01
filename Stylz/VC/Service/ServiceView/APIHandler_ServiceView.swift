//
//  APIHandler_ServiceView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit


//MARK: - hanlde APIs
extension ServiceViewController{
    
    func fetchDataWihtoutLoader(){
        DispatchQueue.global(qos: .userInitiated).async {
            self.getCategories()
        }
    }
 
  func resetCatData(){
      selectedCategoryID = 0
      selectedService = 0
      self.categories.removeAll()
    }
}

//MARK: - category API
extension ServiceViewController{
    
    
    func getCategories(){
        
        resetCatData()
        
        let gender = getGenderCode()
        
        let branceID = getBrannchCode()     //1 for gender //2 for branch id //3 for employee id
        
        let request = CategoryRequest(gender: gender, keyValue: branceID,filterWithbranch: true)
        
        let resource = CategeoryResource()
        resource.getCategories(request: request) { categories, errorMsg in
          
            DispatchQueue.main.async {
                
                if let categories{
                    self.categories = categories
                    self.setSelectedCatIndex()
                }
                
                self.colCategories.reloadData()
                self.getServices(showLoader:true)
            
            }
//            else{
//                self.dispatchGroup.leave()
//            }
        }
    }
    
    func setSelectedCatIndex(){
        if self.categories.count>0{
            selectedCategoryID = categories[0].id ?? 0
        }
    }
    
}

//MARK: - get services    //4
extension ServiceViewController{
    
    
    func getServices(showLoader:Bool){
        
    var loadingIndicator:UIActivityIndicatorView? = nil
                if showLoader{
                    loadingIndicator = getIndicator(controller: self)
                }
     
        
        self.services.removeAll()
        
        let gender = self.getGenderCode()
        let branchID = self.getGenderCode()
        
        let request = GetServicesRequest(salon_Id: branchID, categoryId: selectedCategoryID, employeeID: nil, gender: gender)
        
        let resource = GetMyServiceResource()
        resource.getServices(request: request) { services in
            
            DispatchQueue.main.async{
                
                if showLoader, loadingIndicator != nil {
                    loadingIndicator?.removeFromSuperview()
                }
                
                if let services{
                    self.services = services
                }
                
                // updating services
                print("services count \(self.services)")
                self.updateServicesView()
            }
        }
    }
    
    func updateServicesView(){
        print("updatinng servicee viiew")
        self.tblServicew.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblServicew)
        
        if self.services.count == 0{
            print("no data found")
            self.tblServicew.backgroundView = label
        }else{
            self.tblServicew.backgroundView = nil
        }
        
        
    }
}
