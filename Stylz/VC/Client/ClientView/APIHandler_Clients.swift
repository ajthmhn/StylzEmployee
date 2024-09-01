//
//  APIHandler_Clients.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import UIKit
import StylzWebkit



//MARK: -- handling api - client group api
extension ClientsViewController{
    
    func fetchData(getOnlyClients:Bool){
       
        
        dispatchGroup.enter()
        let loadingIndicator = getIndicator(controller: self)
        
        getOnlyClients ? getClients() : getClientsGroup()
        
        dispatchGroup.notify(queue: .main) {
            loadingIndicator.removeFromSuperview()
            self.colGroups.reloadData()
            self.updateClientView()
        }
    }
    
    
    func getClientsGroup(){
       
        reSetGroupData()
       
        let resource = GetClientGroupResource()
        resource.getClientGroup { groups in
            if let groups{
                self.groups = groups
                print("group id \(self.groupId)")
                self.addAllGroupId()
                self.getClients()
            }
            else{
                self.dispatchGroup.leave()
            }
        }
    }
    
    func reSetGroupData(){
        self.selectedGroupID = -1
        self.selectedGroup = 0
        self.groups.removeAll()
    }
  
    func addAllGroupId(){
        self.groups.insert(Categories(id: -1), at: 0)
    }
    
}



//MARK: - get clients
extension ClientsViewController{
    
    func getClients(){
      
        filteredEmployeeList.removeAll()
        EmployeeList.removeAll()
        
        self.selectedClient = -1
        
        var searchTerm:String? = txtSearch.text ?? ""
        
        if searchTerm == "" || (searchTerm?.isEmptyOrWhitespace() == true){
            searchTerm = nil
        }
        
        let request = GetClientListRequest(searchTerm: searchTerm, groupId:selectedGroupID)
        
        let resource = getClientListResource()
        resource.getClientList(request: request){ employee in
            if let employee{
                
                self.filteredEmployeeList = employee
                self.EmployeeList = employee
            }
            self.dispatchGroup.leave()
        }
    }
    
    
    func updateClientView(){
        self.tblServicew.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblServicew)
        
        if self.filteredEmployeeList.count == 0{
            self.tblServicew.backgroundView = label
        }else{
            self.tblServicew.backgroundView = nil
        }
    }
}


//MARK: - boook appointmennt

extension ClientsViewController{
    
    func moveToThanksView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.success) as! SuccessViewController
        
        showSuccess(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "checkout_succcess", comment: ""), subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "email_send", comment: ""), view: vc.view)
        
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func bookAppointmnet(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let request = getCreateAppointmentRequest()
        
        print("~ print appoinntment request: \(request.getRequestBody())")
        
        let resource = CreateAppointmentResource()
        
        resource.bookAppointment(request: request) { appointmentId,referenceID, errorMsg in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    self.moveToThanksView()
                }
            }
        }
    }
    
    func getCreateAppointmentRequest() -> CreateAppointmentRequest{
        let date = date
        let time = time
        let customerID = self.selectedClient
        let amount = getTotalAmount()
        let branchId = getBrannchCode()
        
        return CreateAppointmentRequest(customerID: customerID, branchID: branchId, totalAmount: amount, date: date, Starttime: time)
    }
    
    func getTotalAmount() -> String{
 
        var totalAmount = ""
        
        if let cartData = getCartData(){
            
            var totals = [Double]()
            
            for all in cartData{
                totals.append(Double(all["price"] as? String ?? "0.0")!)
            }
            
            totalAmount = "\(totals.reduce(0, +))"
        }
        return totalAmount
    }
}


