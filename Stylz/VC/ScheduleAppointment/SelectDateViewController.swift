//
//  SelectDateViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 28/02/23.
//

import UIKit
import FSCalendar
import StylzWebkit

class SelectDateViewController: BaseViewController {

    struct VCConst {
        static let cellId = "time_cell_id"
    }
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var calenderView: UIView!
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var colTimings: UICollectionView!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var btnBack: UIButton!
 
    @IBOutlet var btnDone: UIButton!
    @IBOutlet var btnCancel: UIButton!

    
    var selectedTime = -1
    var isRescedule = false
    
    var timings = [Timings]()
    var appointmentDetails : Appointments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCurrentDate()
        
        if isRescedule == true{
            getTimings()
        }else{
            getTimings()
        }
        
        localizeView()
      
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnCalenderShow(_ sender: Any) {
     showCalender()
    }
    
    @IBAction func btnCalenderActions(_ sender: UIButton) {
       print("btn calender action")
      
        if sender.tag == 1{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            dateFormat.locale  = Locale(identifier: "en")
           
            lblDate.text = dateFormat.string(from: self.calender.selectedDate ?? Date())
            
            getTimings()
            
        }
        
        self.calenderView.removeFromSuperview()
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        self.checkIfDateSelectedAndmoveToClientView()
    }
}



//MARK: - handle nextBtn and move to client view

extension SelectDateViewController{

    func checkIfDateSelectedAndmoveToClientView(){
        let timeErr = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.timingError, comment: "")
    
        if timings.count == 0{
            showAlert(title: "", subTitle: timeErr, sender: self)
            return
        }
       
        if selectedTime == -1{
            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_time", comment: ""), sender: self)
            return
        }
        
        if isRescedule == true{
            reSceuleAppointment()
        }else{
          
            //MARK: - app crashed when clicked on choose client without selecting any time slot
          
            if  timings.count < selectedTime { //new check
               print("!!! timeeings.count < selected")
                showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: ""), sender: self)
           
                return
           }
            
          moveToClientView()
        }
    }
    
    func moveToClientView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.clients) as! ClientsViewController
        vc.isRescedule = self.isRescedule
        vc.date = self.lblDate.text ?? ""
        vc.time = self.timings[selectedTime].start_time ?? ""
       
        self.navigationController?.pushViewController(vc, animated: false)

    }
}


