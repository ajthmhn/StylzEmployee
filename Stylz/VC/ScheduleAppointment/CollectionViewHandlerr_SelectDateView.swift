//
//  CollectionView_SelectDateView.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit



//MARK: - handlig collection view
extension SelectDateViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  timings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.cellId, for: indexPath) as! HomeCell
        
        cell.layer.cornerRadius = 18
        cell.layer.masksToBounds = true
        cell.lblItem.text = timings[indexPath.item].formatted_start_time
        
        if selectedTime == indexPath.item{
            animationScaleEffectSingle(view: cell)
            cell.lblItem.textColor = UIColor.white
            cell.backgroundColor = UIColor.init(hexString: "61AB9A")
        }else{
            cell.lblItem.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 10, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTime = indexPath.item
        collectionView.reloadData()
    }
}
