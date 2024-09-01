//
//  AppointmentsViewController.swift
//  Stylz
//
//  Created by WC_Macmini on 01/03/23.
//

import UIKit
import StylzWebkit
import FSCalendar

class AppointmentsViewController: UIViewController {
    
    struct VCConst {
        static let cellId = "appointMent_cell_id"
    }
    
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var tblServicew: UITableView!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblUpcomin: UILabel!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblNONData: UILabel!
    
    
    var appointments = [Appointments]()
    var dates = [Date]()
    var Holidays = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configCalendar()
        self.localizeView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchDataa()
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}


//MARK: - FSCalendar
extension AppointmentsViewController:FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance
{
    
    func configCalendar(){
        
        calender.select(Date())
        calender.delegate = self
        
        let loc = Locale(identifier: "en")
        calender.locale = loc
        
        calender.dataSource = self
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        getAppointments()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if dates.contains(date){
            return 1
        }
        if Holidays.contains(date){
            return 1
        }
        else{
            return 0
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if dates.contains(date){
            
            return [UIColor.black]
        }
        if Holidays.contains(date){
            
            return [UIColor.red]
        }
        else{
            return [UIColor.white]
        }
    }
}
