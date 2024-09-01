//
//  ReportViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 15/03/23.
//

import UIKit
import StylzWebkit

class ReportViewController: BaseViewController {
    
    struct VCConst {
        static let employeeID = "employee_cell_id"
        static let serviceCellId = "service_cell_id"
    }
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblCash: UILabel!
    @IBOutlet var lblOnline: UILabel!
    @IBOutlet var lblSplit: UILabel!
    @IBOutlet var lblSplitOnline: UILabel!
    @IBOutlet var lblappSales: UILabel!
    @IBOutlet var lblCancel: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var employeeHeight: NSLayoutConstraint!
    @IBOutlet var serviceHeight: NSLayoutConstraint!
    @IBOutlet var lblCustomer: UILabel!
    @IBOutlet var lblService: UILabel!
    @IBOutlet var tblEmployee: UITableView!
    @IBOutlet var tblService: UITableView!
    
    @IBOutlet var lblSalesHead: UILabel!
    @IBOutlet var lblCashHead: UILabel!
    @IBOutlet var lblPOsOnlineHEad: UILabel!
    @IBOutlet var lblPosSplitHead: UILabel!
    @IBOutlet var lblSplitCashHead: UILabel!
    @IBOutlet var lblAppSales: UILabel!
    @IBOutlet var lblCancelPenality: UILabel!
    @IBOutlet var lblTotalHead: UILabel!
    @IBOutlet var lblEmployeeHead: UILabel!
    @IBOutlet var lblServiceSalesHead: UILabel!
    @IBOutlet var lblCutomersHead: UILabel!
    @IBOutlet var lblServicNOHead: UILabel!
    
    
    @IBOutlet var lblDiscountHead: UILabel!
    @IBOutlet var lblDiscount: UILabel!
   
    
    var employeeList = [Employee]()
    var serviceList = [Services]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLanguage()
        
        employeeList.removeAll()
        serviceList.removeAll()
        
        fetchDataAndUpdteView()
        
    }
}


//MARK: - UI
extension ReportViewController{

    func setLanguage(){
        lblSalesHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sales", comment: "")
        lblCashHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cash", comment: "")
        lblPOsOnlineHEad.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "pos_online", comment: "")
        lblPosSplitHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "pos_split_online", comment: "")
        lblSplitCashHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "pos_split_cash", comment: "")
        lblAppSales.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "app_sales", comment: "")
        lblCancelPenality.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel_penality", comment: "")
        lblTotalHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "total_sales", comment: "")
        lblEmployeeHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "employee_sales", comment: "")
        lblServiceSalesHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_sales", comment: "")
        lblCutomersHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_customer", comment: "")
        lblServicNOHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "no_service", comment: "")
        
        lblDiscountHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DiscountAmount", comment: "")
    }
}


//MARK: - tableview
extension ReportViewController : UITableViewDataSource, UITableViewDelegate{
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return employeeList.count
        }else{
            return serviceList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView.tag == 0{
           
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.employeeID) as! ServiceListCell
            
            cell.lblName.text = employeeList[indexPath.row].employee__first_name
            cell.lblPrice.text = "SAR \(employeeList[indexPath.row].total_amount ?? "")"
            
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.serviceCellId) as! ServiceListCell
            
            cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? serviceList[indexPath.row].name_ar ?? "" : serviceList[indexPath.row].name_en ?? ""
          
            cell.lblPrice.text = "SAR \(serviceList[indexPath.row].total_amount ?? "")"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}



extension ReportViewController{
    
    func getFormatedDate(dateString:String, requiredformat:String) -> String
    {
       // let dateString = "2024-04-05T09:00:00Z"

        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()

        // Set the date format to match the input string
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //"2024-05-27 08:09:22"

        // Set the timezone to UTC to match the input string
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        // Parse the string into a Date object
        if let date = dateFormatter.date(from: dateString) {
            // Create another DateFormatter for extracting the time
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = requiredformat
            
            // Set the timezone to UTC to match the input string
            timeFormatter.timeZone = TimeZone(identifier: "UTC")
            timeFormatter.locale = Locale(identifier:"en")
            
            // Format the date to get the time component
            let timeString = timeFormatter.string(from: date)
            
            print("Time extracted from string:", timeString)
            return timeString
        } else {
            print("Failed to parse date string")
        }

        return dateString
        
    }

}
