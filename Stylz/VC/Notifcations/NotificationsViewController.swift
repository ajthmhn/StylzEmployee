//
//  NotificationsViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 20/03/23.
//

import UIKit
import StylzWebkit

class NotificationsViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "not_cell_id"
    }
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var tblNotif: UITableView!
    @IBOutlet var btnBack: UIButton!
    
    var notifications = [NOtifications]()
    var page = 1
    var isDataLoading = true
    var dataEmpty = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back"), for: .normal)
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "notifications", comment: "")
        
        getData()
    
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}




//MARK: - table view

extension NotificationsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
       
        if page == 1{
            animationScaleEffectSingle(view: cell)
        }
        
        cell.dropShadow()
        cell.viewBg.dropShadow()
        cell.viewBg.layer.cornerRadius = 20
        cell.viewBg.layer.masksToBounds = true
       
        cell.lblName.text =  "\(notifications[indexPath.row].title ?? "")\n\n\(notifications[indexPath.row].message ?? "")"
        
        
        let dateFor = DateFormatter()
        dateFor.locale = Locale(identifier:"UTC")
        dateFor.dateFormat = K.DateFormats.serverDataFormat
        
        
        if let createdAt =  self.notifications[indexPath.row].created_at, let date = dateFor.date(from: createdAt){
         
            dateFor.dateFormat = "MMM d"
            cell.lblDuration.text = dateFor.string(from: date)
            
            dateFor.dateFormat = "h:mm a"
            cell.lblPrice.text = dateFor.string(from: date)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

