//
//  StylzAPIFacade.swift
//  PartyManager
//
//  Created by islet on 14/12/16.
//  Copyright © 2016 islet. All rights reserved.
//

//
//  StylzAPIFacade.swift
//  Party
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Party. All rights reserved.
//

import UIKit
import SwiftyJSON

public typealias StylzAPICompletion = (StylzAPIResponse?) -> Void

public class StylzAPIFacade: NSObject {
    struct StylzAPIFacadeConst{
        static let clientId = 2
        static let clientKey = "FEZbPoNvx3vMxP2H1UsP1kCTTVmbxaNlbSuqo7J0"
    }
    public var session : StylzAPISession?
    public class var shared : StylzAPIFacade {
        struct Singleton {
            static let instance = StylzAPIFacade()
        }
        return Singleton.instance
    }
    
    override init() {
        
        StylzAPIProviderFactory.offlineMode = false
        session = StylzAPISession.init()
    }
    
    public func setOfflineMode(_ flag:Bool) {
        StylzAPIProviderFactory.offlineMode = flag
    }
  
  
    
   
    public func sendOtp(phone:String, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.sendOtp(name: phone)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
   
   
    
    
 
    
    
    public func resetSession() {
        self.session?.token = nil
    }
    
    public func extractUserSession(_ json:JSON) {
      
        self.session?.token = json["token"].stringValue
        self.session?.UserId = json["userId"].intValue
        
        print("~ token: \(self.session?.token), userid: \(self.session?.UserId)")
        
    }
    
    public func extractUsermessages(_ json:JSON) {
         let data = json["data"]
          //  if let user = data["user_messages"]?.array{
                let users = User(json: data)
                self.session?.currentUser = users
                
            //}
        
    }
    
    
    
    public func extractUsermessagesFromPofile(_ json:JSON) {
        let user = User(json:json["data"])
        self.session?.currentUser = user
    }
    
    // MARK: - image path
    public func urlForImage(imagePath:String) -> URL?{
        let path = StylzAPIConfig.BaseUrl.baseServerpath + "uploads/" + imagePath
        return URL(string: path)
    }
}

//MARK: - token, report, notification, and dashboard details
extension StylzAPIFacade{
    
    //MARK: -  dashboard
    public func getDashboardDetails( branchID:Int, completion:StylzAPICompletion?)
    {
        StylzAPIProviderFactory.sharedProvider.request(.getDashboardDetails(branchID: branchID)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - token
    public func updateToken(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updateToken(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                
                let jsonData = moyaResponse.data
                
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["detail"].stringValue == "Invalid token."{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
            
        }
    }
    
    
    //MARK: - notification
    public func getNotifications(gender:Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getNotifications(gender: gender)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: - report
    
    public func getSalesReport(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getSalesReport) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
}


//MARK: - login and authentication
extension StylzAPIFacade{
    
    
    //MARK: - signup
    public func signUp(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.signUp(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - login
    public func login(profDet:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.login(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    if YKRes.json?["status"].intValue == 200 {
                        if YKRes.json != nil{
                            self.extractUserSession(YKRes.json!)
                            //  self.extractUsermessages(YKRes.json!)
                        }
                    }
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
   
    //MARK: - updatePassword
    public func updatePassword(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updatePassword(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
   
    
    //MARK: forgot password
    public func forgotPassword(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.resetPassword(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }

    //MARK: - reset pass
    public func resetPassword(data:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.resetPassword(profDetails: data)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
}


//MARK: - profile
extension StylzAPIFacade{
 
    //MARK: - update profile
    public func updateProfile(data:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.updateProfile(date: data)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    if YKRes.json?["status"].stringValue == "true" {
                        if YKRes.json != nil{
                            self.extractUsermessages(YKRes.json!)
                        }
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    

    
    
    //MARK: upload image
    public func uploadImage(profDet:[String:Any], completion:StylzAPICompletion?) {
        
        
        
        //return .uploadMultipart(formData)
        
        StylzAPIProviderFactory.sharedProvider.request(.uploadProfileImage(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: get customer info
    public func getEmployeeInformation( completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getEmployeeInformation) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    
                    //----
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                  
                    if YKRes.json?["status"].intValue == 200 {
                        if YKRes.json != nil{
                            print("~ extrating  user id ")
                            // self.extractUserSession(YKRes.json!)
                            self.extractUsermessages(YKRes.json!)
                        }
                    }
                    //
                    
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
    
//    //MARK: - changePassword
    public func changePassword(profDet:[String:Any],  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.changePassword(profDetails: profDet)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                  
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: - logout
    public func logout(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.logout) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
  
    
    //MARK: - delete
    public func deleteAccount(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.deletAccount) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
}

//MARK: - list appointment - methods
extension StylzAPIFacade{
    
    //MARK: get appoitnment
    public func getAppointments(date:String, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getAppointMents(date: date)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - get all appoitmnets
    public func getAllAppointments(month:String,completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getAllAppointmnents(month: month)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
}


//MARK: - create appointment - checkout methods
extension StylzAPIFacade{
      
    //MARK: - caancel appointment
    public func cancelAppointment(id:Int, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.cancelAppointment(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: - reshedule
    public func resceduleAppointment(id:Int,date:String, startTime :String, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.resceduleAppoint(id: id, date: date, startTime: startTime)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
        //MARK: - get available time slot
    public func checkAvailabilityy(data:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.checkAvailability(date: data)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - book appointment
    public func bookAppointment(data:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.bookAppointMent(date: data)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - checkout
    public func walkinCheckout(data:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.walkinCheckout(profDetails: data)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
}



//MARK: - ccategories, services, employees, and search

extension StylzAPIFacade{
    
    
    //MARK: - categories
    public func getCategories( gender:Int,keyValue:Int?,key:String , completion:StylzAPICompletion?) {
        
        StylzAPIProviderFactory.sharedProvider.request(.getCategories(gender: gender,keyValue: keyValue, key: key)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    
    //MARK: -  search
    public func searchAll(searchTerm:String, branchID:Int, completion:StylzAPICompletion?)
    {
        StylzAPIProviderFactory.sharedProvider.request(.searchAll( searchTerm: searchTerm, branchID: branchID)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - services
    public func getServices(id:Int ,gender: Int , employeeId:Int?, categoryID:Int?, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getservices(shopId: id, gender: gender, employeeID:employeeId,categoryID: categoryID)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    //MARK: - employees
    public func getEmployees(lat:String,lon:String,gender:Int,branchId:Int?, employeeId:Int?, servicesID:Int?,  completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getEmployees(lat: lat, lon: lon, gender: gender,branchId:branchId ,EmployeeID: employeeId,servicesID: servicesID)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    completion?(YKRes)
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
}


//MARK: -- client
extension StylzAPIFacade{


    //MARK: - send otp client
        public func sendOTPForClient(data:[String:Any], completion:StylzAPICompletion?) {
            StylzAPIProviderFactory.sharedProvider.request(.sendOTPForClient(profDetails: data)) { result in
                switch result {
                case let .success(moyaResponse):
                    let jsonData = moyaResponse.data
                    if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                        YKRes.statusCode = moyaResponse.statusCode
                        if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("session_reset"), object: nil)
                        }
                        
                        completion?(YKRes)
                        return
                    }
                case .failure(_):
                    completion?(StylzAPIResponse(success:false, data: nil, json: nil))
                }
            }
        }
    
    //MARK: - verify otp client
        public func VerifyOtPForClient(data:[String:Any], completion:StylzAPICompletion?) {
            StylzAPIProviderFactory.sharedProvider.request(.VerifyOtPForClient(profDetails: data)) { result in
                switch result {
                case let .success(moyaResponse):
                    let jsonData = moyaResponse.data
                    if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                        YKRes.statusCode = moyaResponse.statusCode
                        if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                            let nc = NotificationCenter.default
                            nc.post(name: Notification.Name("session_reset"), object: nil)
                        }
                        
                        completion?(YKRes)
                        return
                    }
                case .failure(_):
                    completion?(StylzAPIResponse(success:false, data: nil, json: nil))
                }
            }
        }

    
    //MARK: - add client
    public func addClient(data:[String:Any], completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.addClient(profDetails: data)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: - get client list
    public func getClientList(id:Int, search:String?, completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getClientList(id: id, search: search)) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
    //MARK: - get client group
    public func getClientGroup(completion:StylzAPICompletion?) {
        StylzAPIProviderFactory.sharedProvider.request(.getClientGroup) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = moyaResponse.data
                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
                    YKRes.statusCode = moyaResponse.statusCode
                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
                        let nc = NotificationCenter.default
                        nc.post(name: Notification.Name("session_reset"), object: nil)
                    }
                    
                    completion?(YKRes)
                    return
                }
            case .failure(_):
                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
            }
        }
    }
    
    
}


//MARK: -- old services, emp, search

extension StylzAPIFacade{
    
   
    
//    public func getEmployeeList(completion:StylzAPICompletion?) {
//        StylzAPIProviderFactory.sharedProvider.request(.getEmployeeList) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let jsonData = moyaResponse.data
//                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
//                    YKRes.statusCode = moyaResponse.statusCode
//                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
//                        let nc = NotificationCenter.default
//                        nc.post(name: Notification.Name("session_reset"), object: nil)
//                    }
//                    
//                    completion?(YKRes)
//                    return
//                }
//            case .failure(_):
//                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
//            }
//        }
//    }
//    
//    public func getWalkinService(completion:StylzAPICompletion?) {
//        StylzAPIProviderFactory.sharedProvider.request(.getWalkinService) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let jsonData = moyaResponse.data
//                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
//                    YKRes.statusCode = moyaResponse.statusCode
//                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
//                        let nc = NotificationCenter.default
//                        nc.post(name: Notification.Name("session_reset"), object: nil)
//                    }
//                    
//                    completion?(YKRes)
//                    return
//                }
//            case .failure(_):
//                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
//            }
//        }
//    }
//    public func searchData(data:String, completion:StylzAPICompletion?) {
//        StylzAPIProviderFactory.sharedProvider.request(.searchData(date: data)) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let jsonData = moyaResponse.data
//                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
//                    YKRes.statusCode = moyaResponse.statusCode
//                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
//                        let nc = NotificationCenter.default
//                        nc.post(name: Notification.Name("session_reset"), object: nil)
//                    }
//                    
//                    completion?(YKRes)
//                    return
//                }
//            case .failure(_):
//                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
//            }
//        }
//    }
//    public func getWalkinEmployeeList(completion:StylzAPICompletion?) {
//        StylzAPIProviderFactory.sharedProvider.request(.getWalkinEmpoloyee) { result in
//            switch result {
//            case let .success(moyaResponse):
//                let jsonData = moyaResponse.data
//                if let YKRes = StylzAPIResponse.fromJSONData(jsonData) as? StylzAPIResponse {
//                    YKRes.statusCode = moyaResponse.statusCode
//                    if YKRes.json?["message"].stringValue == "Token is invalid or expired"{
//                        let nc = NotificationCenter.default
//                        nc.post(name: Notification.Name("session_reset"), object: nil)
//                    }
//
//                    completion?(YKRes)
//                    return
//                }
//            case .failure(_):
//                completion?(StylzAPIResponse(success:false, data: nil, json: nil))
//            }
//        }
//    }
//
}


