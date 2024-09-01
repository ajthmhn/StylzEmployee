
//
//  CollectionViewHandler_Clients.swift
//  Stylz
//
//  Created by abcd on 22/05/2024.

import UIKit
import Foundation

//MARK: - collection view

extension ClientsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.groupCellId, for: indexPath) as! CategColCell
        
        cell.lblItem.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? groups[indexPath.item].name_ar : groups[indexPath.item].name_en
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        if  firstTime == true{
            collectionView.reloadData()
            firstTime = false
        }
        
        if selectedGroup == indexPath.item{
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
        label.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? groups[indexPath.item].name_ar : groups[indexPath.item].name_en
        label.sizeToFit()
        return CGSize(width: label.frame.width + 60, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedGroup = indexPath.item
        selectedGroupID = groups[indexPath.row].id ?? 0
        
        collectionView.reloadData()
        //  getServices()
        
        fetchData(getOnlyClients: true)
    }
}
