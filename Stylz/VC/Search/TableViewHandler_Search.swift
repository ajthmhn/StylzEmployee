//
//  TableViewHandler_Search.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit



//MARK: - table view
extension SearchViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return servicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.serviceCellId) as! ServiceListCell
        
        animationScaleEffectSingle(view: cell)
      
        cell.dropShadow()
        
        let service = servicesList
        
        cell.lblName.text =  LocalizationSystem.sharedInstance.getLanguage() == "ar" ? service[indexPath.row].name_ar : service[indexPath.row].name_en
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            cell.lblDuration.text = "\(service[indexPath.row].duration ?? "") دقيقة"
        }else{
            cell.lblDuration.text = "\(service[indexPath.row].duration ?? "") Mins"
        }
        
        
        cell.lblDurationHead.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "duration", comment: "")):"
      
        cell.btnAdd.setTitle(" \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_basket", comment: "")) ", for: .normal)
        
        cell.lblPrice.attributedText = getAttributedStringWithAmount(amount: service[indexPath.row].amount ?? "")
        
        cell.deleteTappedActions { aCell in
            
            self.handleTapOnCellDeleteBtn(index: indexPath.row)
        }
        
        //setImage(imageView: cell.imgProduct, url: categories[selectedService].service_category_icon ?? "")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARK: - getAttributes string
extension SearchViewController{
    
    func getAttributedStringWithAmount(amount:String) -> NSMutableAttributedString{
     
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 14.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-SemiBold", size: 18.0)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributedString3 = NSMutableAttributedString(string:"SAR ", attributes:attrs3 as [NSAttributedString.Key : Any])
        //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
        
        let attributedString4 = NSMutableAttributedString(string:"\(amount)", attributes:attrs4 as [NSAttributedString.Key : Any])
      
        attributedString3.append(attributedString4)
    
        return attributedString3
    }
}

//MARK: - handle tap
extension SearchViewController{
    
    
    func handleTapOnCellDeleteBtn(index:Int){
        var details = [String:Any]()
        details["customer_id"] = getUserDetails()?["id"] as? Int ?? 0
        details["customer_image"] = ""
        details["customer_name"] =  getUserDetails()?["first_name"] as? String ?? ""
        details["service_id"] = servicesList[index].id
        details["service_name_en"] = servicesList[index].name_en
        details["service_name_ar"] = servicesList[index].name_ar
        details["price"] = servicesList[index].amount
        
        print(details)
        saveCart(details: details)
        showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "service_added", comment: ""), view: (self.view)!)
        
        if let cartData =  getCartData(), cartData.count > 0{
            self.viewCart.isHidden = false
            self.bottomSpace.constant = 80
            self.lblCount.text = "\(cartData.count)"
            
            var totals = [Double]()
            for all in cartData{
                totals.append(Double(all["price"] as? String ?? "0.0")!)
            }
            
            let sum = totals.reduce(0, +)
            let vat = (K.User.vatValue * sum) / 100
            
            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
            let attributedString4 = NSMutableAttributedString(string:"SAR \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
            attributedString3.append(attributedString4)
            self.lblPrice.attributedText = attributedString3
            
            animationScaleEffectSingle(view: self.viewCart)
        }else{
            self.bottomSpace.constant = 0
            self.viewCart.isHidden = true
        }
    }
    
}
