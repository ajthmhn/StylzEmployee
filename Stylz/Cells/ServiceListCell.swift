//
//  ServiceListCell.swift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit

class ServiceListCell: UITableViewCell {
   
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgProduct: UIImageView!
    @IBOutlet var imgClient: UIImageView!
  
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblService: UILabel!
    @IBOutlet var viewBg: UIView!
    @IBOutlet var btnAdd: UIButton!

    @IBOutlet var lblRateHead: UILabel!
    @IBOutlet var lblDurationHead: UILabel!
    @IBOutlet var mobileLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
   
    
    
    typealias deleteTapped = (ServiceListCell) -> Void
    var deleteTappedAction : deleteTapped?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func deleteTappedActions(handler:deleteTapped?) {
            deleteTappedAction = handler
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnDelete(_ sender: UISwitch) {
        deleteTappedAction!(self)
    }

}
