//
//  UIHandler_Search.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit


//MARK: - ui
extension SearchViewController{
    
    func setSearchBar(){
        
        viewSearch.layer.cornerRadius = 10
        //viewSearch.layer.masksToBounds = true
        viewSearch.layer.borderWidth = 0.5
        viewSearch.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        viewSearch.dropShadow()
        
        
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    func localizeView(){
        txtSearch.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search_service", comment: "")
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            txtSearch.textAlignment = .right
        }else{
            txtSearch.textAlignment = .left
        }
    }
    
}



//MARK: - handle Cart
extension SearchViewController{
    
    func setInitialViewForCart(){
       
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
            
           
            self.lblPrice.attributedText = getAttributesStringWithSum(sum: sum)
            
            animationScaleEffectSingle(view: self.viewCart)
            
        }else{
            self.viewCart.isHidden = true
            self.bottomSpace.constant = 0
        }
    }
    
}
