//
//  TableViewHandler_ClientsView.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.
//

//

import UIKit

//MARK: - taable view
extension ClientsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmployeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
        cell.viewBg.dropShadow()
        cell.lblName.text = filteredEmployeeList[indexPath.row].first_name
        cell.lblPrice.text = filteredEmployeeList[indexPath.row].email
        cell.lblDuration.text = filteredEmployeeList[indexPath.row].phone
        
        cell.mobileLbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.phone, comment: "")):"
        
        cell.emailLbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.email, comment: "")):"
        
        
        setImage(imageView: cell.imgClient, url: filteredEmployeeList[indexPath.row].image ?? "")
        
        
        if selectedClient == filteredEmployeeList[indexPath.row].id{
            cell.imgProduct.isHidden = false
            animationScaleEffectSingle(view: cell)
        }else{
            cell.imgProduct.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedClient = filteredEmployeeList[indexPath.row].id ?? 0
        tableView.reloadData()
    }
    
}

