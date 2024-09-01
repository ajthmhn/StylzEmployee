//
//  TableViewHandler_Cart.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit


//MARK: - Table view

extension CartViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let cartData = getCartData(), cartData.count > 0{
            return cartData.count
        }
        
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
        
        animationScaleEffectSingle(view: cell)
        
        if let cartData = getCartData(), cartData.count > indexPath.row{
           
            let data = cartData[indexPath.row]
            
            // cell.lblName.text = data?["customer_name"] as? String ?? ""
            
            cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? data["service_name_ar"] as? String ?? "" : data["service_name_en"] as? String ?? ""
            
            cell.lblPrice.text = "SAR \(data["price"] as? String ?? "")"
            
            if data["customer_image"] as? String == ""{
                cell.imgProduct.image = UIImage(named: "scissor")
            }else{
                print(" service img: \(data["customer_image"])")
                setImage(imageView: cell.imgProduct, url: data["customer_image"] as? String ?? "",placeholderImg: "scissor")
            }
            
            
            cell.deleteTappedActions { [self] aCell in
                
                handleDelete(index: indexPath.row)
                
                tableView.reloadData()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//MARK: - handle cart delete tap
extension CartViewController{
    
    func handleDelete(index:Int){
        var data = getCartData()
        data?.remove(at: index)
        
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "cart_details")
        defaults.synchronize()
        
        if let data{
            for all in data{
                saveCart(details: all)
            }
        }
        
        if let data, data.count > 0{
            var totals = [Double]()
            for all in data{
                totals.append(Double(all["price"] as? String ?? "0.0")!)
            }
            
            let sum = totals.reduce(0, +)
            let vat = (K.User.vatValue * sum) / 100
            self.lblVat.text = "SAR \(vat)"
            self.lblTotal.text = "SAR \(sum)"
            self.lblSub.text = "SAR \(sum - vat)"
            
            self.lblCheckout.attributedText = self.getAttributedString(sum:sum)
            
            
        }
        else{
            
            self.lblSub.text = "SAR 0.0"
            let vat = "0.0"
            self.lblVat.text = "SAR \(vat)"
            self.lblTotal.text = "SAR 0.0"
        
            self.lblCheckout.attributedText = getAttributedString(sum: 0.0)
        }
        
    }
    
}
