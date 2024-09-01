//
//  UIIHandler_ServiceView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit
import AlamofireImage
import ImageSlideshow


//MARK: - ui
extension ServiceViewController{
    
    
    
    func localizeView(){
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            lblName.text = getUserDetails()?["name_ar"] as? String ?? ""
        }else{
            lblName.text = getUserDetails()?["name_en"] as? String ?? ""
        }
        
        lblAddress.text = getUserDetails()?["address"] as? String ?? ""
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_white_right" : "back_white"), for: .normal)
        
        lblRating.text = "\(getUserDetails()?["saloRating"] as? Double ?? 0.0)"
    }
    
   
    func setSliderImg(){
        let images = getUserDetails()?["images"] as? Array<String>
        
        var bannerImageList = [AlamofireSource]()
        for all in images ?? []{
            let imageURl =  AlamofireSource(urlString:all)
            if imageURl != nil{
                bannerImageList.append(imageURl!)
            }
        }
        
        self.slider.setImageInputs(bannerImageList)
        self.slider.slideshowInterval = 5.0
        self.slider.contentScaleMode = .scaleToFill
        self.slider.pageIndicator = nil
        
    }
    
    func setTabView(){
        for all in imgTabs{
            all.setImageColor(color: UIColor.darkGray)
        }
        for all in lblTabs{
            all.textColor = UIColor.darkGray
        }
        
        imgTabs[0].setImageColor(color: UIColor(hexString: "61AB9A")!)
        lblTabs[0].textColor = UIColor(hexString: "61AB9A")!
  
    }
    
    
}


//MARK: - handle cart - walking checkout

extension ServiceViewController{
    
    
    func setCartView(){
        
        if let cartData = getCartData(), cartData.count > 0{
            viewCart.isHidden = false
            bottomSpace.constant = 80
            lblCount.text = "\(cartData.count)"
            
            var totals = [Double]()
            for all in cartData{
                totals.append(Double(all["price"] as? String ?? "0.0")!)
            }
            
            let sum = totals.reduce(0, +)
            let vat = (K.User.vatValue * sum) / 100
            
//            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
//            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
//            let attributedString4 = NSMutableAttributedString(string:"SAR \(sum)", attributes:attrs4 as [NSAttributedString.Key : Any])
//            attributedString3.append(attributedString4)
//          
            lblPrice.attributedText = getAttributedStringWithSum(sum: sum)
            
        }
        else{
            viewCart.isHidden = true
            bottomSpace.constant = 0
        }
    }
    
    
    func handleWalkingCheckout(){
        //        if isWalkin == true{
        //            if checkWalkin() == true{
        //                if getCartData()?.count ?? 0 > 0{
        //                    viewCart.isHidden = false
        //                    lblCount.text = "\(getCartData()?.count ?? 0)"
        //                }else{
        //                    viewCart.isHidden = true
        //                }
        //            }else{
        //                viewCart.isHidden = true
        //            }
        //        }else{
        //            if checkWalkin() == false{
        //                if getCartData()?.count ?? 0 > 0{
        //                    viewCart.isHidden = false
        //                    lblCount.text = "\(getCartData()?.count ?? 0)"
        //                }else{
        //                    viewCart.isHidden = true
        //                }
        //            }else{
        //                viewCart.isHidden = true
        //            }
        //        }
    }
    
}
