//
//  UIHandler_CartView.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit

//MARK: - Handle UI

extension CartViewController{
    
    func setInitialView(){
      
        for all in btnCash{
            all.setTitleColor(UIColor.black, for: .normal)
            all.layer.cornerRadius = 10
            all.layer.masksToBounds = true
            all.layer.borderWidth = 1
            all.layer.borderColor = UIColor.black.cgColor
            all.backgroundColor = UIColor.white
            all.imageView?.setImageColor(color: UIColor.black)
        }
    }
    
    func setLanguage(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")
        lblService.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "services", comment: "")
        lblSubHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "subtotal", comment: "")
        lblTotalHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "total", comment: "")
        lblVAThead.text = "VAT \(K.User.vatValue)%"
        
    }
}



//MARK: - handle cart price labels
extension CartViewController{
    
    
    func setCartPriceLabels(){
        var totals = [Double]()
        
        if let cartData = getCartData(){
            for all in cartData{
                totals.append(Double(all["price"] as? String ?? "0.0")!)
            }
        }
        
        let sum = totals.reduce(0, +)
        let vat = (K.User.vatValue * sum) / 100
        
        lblCheckout.attributedText = getAttributedString(sum: sum)
        
        lblSub.text = "\(sum - vat) SAR"
        lblTotal.text =  "\(sum) SAR"
        lblVat.text = "\(vat) SAR"
        
    }
    
    func getAttributedString(sum:Double) -> NSMutableAttributedString{
        
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "place_order", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
        //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
        let attributedString4 = NSMutableAttributedString(string:"\(sum) SAR", attributes:attrs4 as [NSAttributedString.Key : Any])
        attributedString3.append(attributedString4)
        
        return attributedString3
    }
}
