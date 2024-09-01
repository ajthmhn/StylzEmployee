//
//  APIHandler_Report.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

import Foundation
import StylzWebkit


//MARK: - fetch report data

extension ReportViewController{
    
    func fetchDataAndUpdteView(){
       
        StylzAPIFacade.shared.getSalesReport{ (aRes) in
        
            if aRes?.statusCode == 200{
            
                if aRes?.json?["status"].intValue == 200{
                    
                    if let allData = aRes?.json?["data"].dictionary {
                        
                      
                        let dateFormat = DateFormatter()
                        dateFormat.dateFormat = "MMM d, h:mm a"
                        dateFormat.locale = Locale(identifier:"en")
                
                        //  self.lblDate.text = dateFormat.string(from: Date())
                        self.lblDate.text = self.getFormatedDate(dateString: allData["till_open_time"]?.stringValue ?? "" , requiredformat: "MMM d, hh:mm a")
                      
                
                        //Shop
                        if let data = allData["shop_details"]?.dictionary {
                            
                            self.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? data["branch_name_ar"]?.stringValue ?? "" : data["branch_name_en"]?.stringValue ?? ""
                            
                                }
                        
                        //Sales
                        if let data = allData["sales"]?.dictionary {
                           
                            self.lblCash.text = "SAR \(data["total_cash"]?.doubleValue ?? 0.0)"
                            
                            self.lblOnline.text = "SAR \(data["total_online_amount"]?.doubleValue ?? 0.0 )"
                            self.lblSplit.text = "SAR \(data["total_split_cash"]?.doubleValue ?? 0.0)"
                            self.lblSplitOnline.text = "SAR \(data["total_split_online_amount"]?.doubleValue ?? 0.0)"
                            self.lblappSales.text = "SAR \(data["customer_total_online_amount"]?.doubleValue ?? 0.0)"
                            
                            self.lblCancel.text = "SAR \(data["cancellation_penalty"]?.doubleValue ?? 0.0)"
                            
                            self.lblTotal.text = "SAR \(data["total_amount"]?.doubleValue ?? 0.0)"
                            
                            
                            //total customer count
                            self.lblCustomer.text = "\(data["customer_count"]?.intValue ?? 0)"
                          
                            //new - disocount
                            self.lblDiscount.text = "SAR \(data["total_discounted_amount"]?.doubleValue ?? 0.0)"
                            
                        }
                        
                        // employee sales
                        if let data = allData["employee_sales"]?.array {
                            for m in data{
                                let booking = Employee(json2: m)
                                self.employeeList.append(booking)
                            }
                        }
                        
                        // services details
                        if let data = allData["service_sales"]?.array {
                            for m in data{
                                let booking = Services(json2: m)
                                self.serviceList.append(booking)
                            }
                        }
                        
                   
                        // upate view
                        self.updateView()
                        
                    }
                    else{
                        self.dismiss(animated: true)
                        showAlert(title: "", subTitle: getErrMsg(json: aRes?.json) , sender: self)
                    }
                }
                else{
                    self.dismiss(animated: true)
                    showAlert(title: "", subTitle: getErrMsg(json: aRes?.json) , sender: self)
                }
            }else{
                self.dismiss(animated: true)
                 showAlert(title: "", subTitle: getErrMsg(json: aRes?.json) , sender: self)
               
            }
        }
    }
    
    func updateView(){
        self.employeeHeight.constant = CGFloat((self.employeeList.count * 40) + 67)
        self.serviceHeight.constant = CGFloat((self.serviceList.count * 40) + 67)
        
       // self.lblCustomer.text = "\(self.employeeList.count)"
        self.lblService.text = "\(self.serviceList.count)"
        
        self.tblEmployee.reloadData()
        self.tblService.reloadData()

    }
}
