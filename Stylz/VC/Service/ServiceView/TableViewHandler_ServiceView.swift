//
//  TableViewHandler_ServiceView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit


//MARK: - table view
extension ServiceViewController : UITableViewDataSource, UITableViewDelegate{
  
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                if newsize.height == 0{
                    tblHeight.constant = 200
                }else{
                    tblHeight.constant = newsize.height
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEmplooyee == true{
            return employeeList.count
        }else{
            if services.count > 0{
                return services.count
            }else{
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmplooyee == true{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.employeeCellId) as! ServiceListCell
            
            animationScaleEffectSingle(view: cell)
            
            cell.dropShadow()
            
            cell.lblName.text =  employeeList[indexPath.row].first_name
            cell.lblDuration.text = employeeList[indexPath.row].phone
            setImage(imageView: cell.imgProduct, url: employeeList[indexPath.row].image ?? "")
            //            cell.lblPrice.text = employeeList[indexPath.row].employee_rating
            return cell
            
        }
        else{
          
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.serviceCellId) as! ServiceListCell
            animationScaleEffectSingle(view: cell)
            cell.dropShadow()
            
            let service = services[indexPath.row]
            
            cell.lblName.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? service.name_ar : service.name_en
            
            if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
                cell.lblDuration.text = "\(service.duration ?? "") دقيقة"
            }else{
                cell.lblDuration.text = "\(service.duration ?? "") Mins"
            }
           
        
            cell.lblDurationHead.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "duration", comment: "")):"
           
             
            if let icon = categories[selectedService].service_category_icon, icon == "" {
                 cell.imgProduct.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            }
            else{
               print ("~ icon \(categories[selectedService].service_category_icon ?? "")")
                setImage(imageView: cell.imgProduct, url: categories[selectedService].service_category_icon ?? "",placeholderImg: "scissor")
            }
            
            cell.btnAdd.setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_basket", comment: "")) ", for: .normal)
            
            
            
           
            cell.lblPrice.attributedText = getAttributesPriceStringWithSum(sum: service.amount ?? "")
            
            cell.deleteTappedActions { aCell in
                
                var details = [String:Any]()
                details["customer_id"] = getUserDetails()?["id"] as? Int ?? 0
                details["customer_image"] = self.categories[self.selectedService].service_category_icon
                details["customer_name"] =  getUserDetails()?["first_name"] as? String ?? ""
                details["service_id"] = service.id
                details["service_name_en"] = service.name_en
                details["service_name_ar"] = service.name_ar
                details["price"] = service.amount
                
                print(details)
                
                saveCart(details: details)
              
                showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_added", comment: ""), view: (self.view)!)
                
                if let cartData = getCartData(), cartData.count > 0{
                    self.viewCart.isHidden = false
                    self.bottomSpace.constant = 80
                    self.lblCount.text = "\(cartData.count)"
                    
                    var totals = [Double]()
                    for all in cartData{
                        totals.append(Double(all["price"] as? String ?? "0.0")!)
                    }
                    
                    let sum = totals.reduce(0, +)
                    let vat = (K.User.vatValue * sum) / 100
                    
                    self.lblPrice.attributedText = self.getAttributedStringWithSum(sum: sum)
                    
                    animationScaleEffectSingle(view: self.viewCart)
               
                }else{
                    self.viewCart.isHidden = true
                    self.bottomSpace.constant = 0
                }
            }
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: false)
    //        if isEmplooyee == true{
    //            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetails) as! ServiceDetailsViewController
    //            vc.modalPresentationStyle = .popover
    //            vc.selectedEmployee = employeeList[indexPath.row]
    //            vc.parents = self
    //            vc.isWalkins = self.isWalkin
    //            self.present(vc, animated: true)
    //        }else{
    //            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetails) as! ServiceDetailsViewController
    //            vc.modalPresentationStyle = .popover
    //            let service = categories[selectedService].services
    //            vc.selectedService = service[indexPath.row]
    //            vc.parents = self
    //            vc.isWalkins = self.isWalkin
    //            self.present(vc, animated: true)
    //        }
    //
    //    }
}


extension ServiceViewController {
    
    
     func getAttributedStringWithSum(sum: Double) -> NSMutableAttributedString {
        
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
        let attributedString4 = NSMutableAttributedString(string:"SAR \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
        
        
        
        attributedString3.append(attributedString4)
     
        return attributedString3
    }
    
     func getAttributesPriceStringWithSum(sum: String) -> NSMutableAttributedString {
        
         let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 14.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
         let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 18.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
         let attributedString3 = NSMutableAttributedString(string:"SAR ", attributes:attrs3 as [NSAttributedString.Key : Any])
         //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
         let attributedString4 = NSMutableAttributedString(string:"\(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
         attributedString3.append(attributedString4)
         
         return attributedString3
    }
    
}
