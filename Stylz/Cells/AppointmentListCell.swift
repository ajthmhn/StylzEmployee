//
//  AppointmentListCell.swift
//  Stylz
//
//  Created by WC_Macmini on 01/03/23.
//

import UIKit

class AppointmentListCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var imgBarber: UIImageView!
    @IBOutlet var viewBg: UIView!
    @IBOutlet var imgPaid: UIImageView!
    @IBOutlet var paymentStatus: UILabel!

    
    typealias deleteTapped = (AppointmentListCell) -> Void
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
