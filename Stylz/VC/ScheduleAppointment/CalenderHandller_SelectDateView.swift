//
//  CalenderHandller_SelectDateView.swift
//  Stylz
//
//  Created by abcd on 26/05/2024.
//

import Foundation
import UIKit
import FSCalendar

//MARK: - handlig calender
extension SelectDateViewController:FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{
    
    func showCalender(){
        
        Bundle.main.loadNibNamed("CalenderView", owner: self)
        
        self.calenderView.frame = self.view.bounds
        self.view.addSubview(self.calenderView)
        self.view.bringSubviewToFront(self.calenderView)
        self.calender.select(Date())
        
        animationScaleEffectSingle(view: self.calender)
        
        self.calender.delegate = self
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            if languageChange == true{
                self.calender.transform = CGAffineTransform(scaleX: -1, y: 1);
                self.calender.calendarWeekdayView.transform = CGAffineTransform(scaleX: -1, y: 1);
            }
            let loc = Locale(identifier: "en")
            self.calender.locale = loc
        }else{
            let loc = Locale(identifier: "en")
            self.calender.locale = loc
        }
        
        btnDone.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "done", comment: ""), for: .normal)
        
        btnCancel.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cancel", comment: ""), for: .normal)
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("calender page did change")
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        let threeDays = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let day = Calendar.current.date(byAdding: .day, value: 1, to: date)
        
        if day! < threeDays!{
            return false
        }else{
            return true
            
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let threeDays = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let day = Calendar.current.date(byAdding: .day, value: 1, to: date)
        
        
        if day! < threeDays!{
            return UIColor.gray
        }else{
            return UIColor.black
        }
    }
}

