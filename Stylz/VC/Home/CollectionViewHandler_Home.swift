//
//  CollectionViewHandler_Home.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit

//MARK: - collection view
extension  HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.cellId, for: indexPath) as! HomeCell
        animationScaleEffectSingle(view: cell)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.dropShadow()
        
        //cell.view_bg
        
        cell.lblItem.text = items[indexPath.item]["name"]
        cell.imgItem.image = UIImage(named: items[indexPath.item]["image"] ?? "")
        
        if selected == indexPath.row{
            cell.backgroundColor = UIColor(hexString: "1B263A")
            cell.lblItem.textColor = UIColor.white
            cell.imgItem.setImageColor(color: UIColor.white)
            cell.layer.borderWidth = 0
        }else{
            
            cell.layer.borderWidth = 0.5
            cell.backgroundColor = UIColor.white
            cell.lblItem.textColor = UIColor(hexString: "1B263A")
            cell.imgItem.setImageColor(color: UIColor(hexString: "1B263A")!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 10, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.item
        collectionView.reloadData()
        DispatchQueue.main.async {
            if indexPath.item == 0{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.appointment) as! AppointmentsViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }else if indexPath.item == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.services) as! ServiceViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }else if indexPath.item == 2{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.settings) as! SettingsViewController
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        
    }
}
