//
//  CollectionViewHandler_ServiceView.swift
//  Stylz
//
//  Created by abcd on 23/05/2024.
//

import Foundation
import UIKit

//MARK: - collection view
extension ServiceViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.cellId, for: indexPath) as! CategColCell
        
        cell.lblItem.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? categories[indexPath.item].name_ar : categories[indexPath.item].name_en
        
        getGenderCode() == 1 ?
        setImage(imageView: cell.imgItem, url: categories[indexPath.item].service_category_icon ?? "")
        :
        setImage(imageView: cell.imgItem, url: categories[indexPath.item].service_category_icon_Female ?? "")
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
     
        if  firstTime == true{
            collectionView.reloadData()
            firstTime = false
        }
        
        
        if selectedService == indexPath.item{
            animationScaleEffectSingle(view: cell)
            cell.backgroundColor = UIColor(hexString: "61AB9A")
            cell.lblItem.textColor = UIColor.white
            cell.imgItem.setImageColor(color: UIColor.white)
            animationScaleEffectSingle(view: cell)
        }
        else{
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
            cell.lblItem.textColor = UIColor.black
            cell.imgItem.setImageColor(color: UIColor(hexString: "61AB9A")!)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? categories[indexPath.item].name_ar : categories[indexPath.item].name_en
        label.sizeToFit()
        return CGSize(width: label.frame.width + 60, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedService = indexPath.item
        selectedCategoryID = categories[indexPath.row].id ?? 0
        
        collectionView.reloadData()
        
      //  fetchData(getOnlyServices: true,showLoader: true)
        getServices(showLoader: true)
    }
}



