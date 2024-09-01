//
//  StylzAPI.swift
//  Party
//
//  Created by Isletsystems on 22/09/16.
//  Copyright © 2016 Party. All rights reserved.
//

import UIKit
import Moya

public enum StylzAPI {
    
    
    case signUp(profDetails:[String:Any])
    case login(profDetails:[String:Any])
    case logout
    case resetPassword(profDetails:[String:Any])
    case updatePassword(profDetails:[String:Any])
    case sendOtp(name:String)
    case changePassword(profDetails:[String:Any])
    case deletAccount
 
    
    //proifle
    case getEmployeeInformation
    case uploadProfileImage(profDetails:[String:Any])
    
    //appoinntment
    case getAppointMents(date:String)
    case getAllAppointmnents(month:String)
    
    
    
    case getCategories(gender:Int, keyValue:Int?, key:String)
    
    
    case getEmployees(lat:String,lon:String, gender:Int, branchId:Int?, EmployeeID:Int?,servicesID:Int?)
    
    case getservices(shopId:Int, gender : Int, employeeID:Int?, categoryID:Int?)
    case searchAll( searchTerm:String, branchID:Int)
    
    
    //  case getWalkinEmpoloyee
    case checkAvailability(date:[String:Any])
    case updateProfile(date:[String:Any])
    
    //MARK: - client
    case getClientList(id:Int,search:String?)
    case getClientGroup
    case addClient(profDetails:[String:Any])
    case VerifyOtPForClient(profDetails:[String:Any])
    case sendOTPForClient(profDetails:[String:Any])
    
    
    
    case bookAppointMent(date:[String:Any])
    case cancelAppointment(id:Int)
    case resceduleAppoint(id:Int, date:String, startTime:String)
    case getSalesReport
    case walkinCheckout(profDetails:[String:Any])
    
    case getNotifications(gender:Int)

    case getDashboardDetails(branchID:Int)
    
    case updateToken(profDetails:[String:Any])
   
}


extension StylzAPI: TargetType {
    
    public var headers: [String : String]? {
        return nil
    }
    
    var base: String {
        return  StylzAPIConfig.BaseUrl.baseServerpath
        
    }
    
    public var baseURL: URL {
        return URL(string: base)!
    }
    
    public var path: String {
        switch self {
        case .signUp(_):
            return "customer-register"
            
        case .login:
            return "/accounts/api/sign-in/"
            
        case .resetPassword(_):
            return "/accounts/api/forget-password/" //new
        case .updatePassword: //new
            return "accounts/api/reset-password/"
        case .changePassword:
            return "/accounts/api/change-password"
       
        case .deletAccount:
            return "/accounts/api/delete-account"
   
            
        case .sendOtp(_): ///accounts/api/check/otp
            return "password/send_otp"
            
            //profile
        case .getEmployeeInformation:
            return "/employee/api/details"
            
        case .uploadProfileImage:
            return "/employee/api/image/update"
            
        case .updateProfile(_):
            return "/employee/api/profile/update"
            
            
        case .logout:
            return "/accounts/api/sign-out/"
            
            
            
            //MARK: - appointment path
            
        case .getAppointMents(_):
            return "/appointment/api/employee/list"
            
        case .getAllAppointmnents:
            return "appointment/api/employee/upcoming-list"
            
     
        case .checkAvailability(_):
            return "/appointment/api/availability"
            
        case .bookAppointMent(_):
            return "/appointment/api/create"
            
        case .cancelAppointment:
            return "/appointment/api/cancel"
            
        case .resceduleAppoint:
            return "/appointment/api/reschedule"
            
    
            
            //MARK: - services - end point
            
        case .getCategories:
            return "/service/api/category/list"
            
        case .getEmployees:
            return "/employee/api/list"
            
        case .getservices:
            //            return "walkin/service-list"
            return "/service/api/employee/list"
            
            
        case .searchAll:
            return "/service/api/employee/list"
            
            
            
            // MARK: - client
            
        case .getClientList:
            return "/customer/api/list"
            
        case .getClientGroup:
            return "/customer/api/group/list"
            
        case .addClient(_):
            return "/customer/api/create"
        case .sendOTPForClient:
            return "/customer/api/send-customer-detail"
        case .VerifyOtPForClient:
            return "/customer/api/verify-customer"
            
            
            
        case .getSalesReport:
            return "/finance/sales/api/sales-report"
        case .walkinCheckout(_):
            return "/finance/sales/api/service/checkout"
            
        case .getNotifications(_):
            return "/accounts/api/notification/list"
            
        case .getDashboardDetails:
            return "/dashboard/api/"
  
         
        case .updateToken(_):
            return "/accounts/api/fcm/token/refresh"
       
          
        }
    }
    
    
    public var method: Moya.Method {
        switch self {
        case
                .signUp(_),
                .login,
                .resetPassword(_),
                .updatePassword(_),
                .sendOtp(_),
                .changePassword,
                .deletAccount,
               
                
            //profile
                .uploadProfileImage(_),
                .updateProfile(_),
            
            //APpointmnet
                .bookAppointMent,
                .checkAvailability,
                .resceduleAppoint,
            
            //     .getWalkinEmpoloyee,
               
                .getSalesReport,
                
                .walkinCheckout(_),
                
                .logout,
              
                .addClient,
                .sendOTPForClient,
                .updateToken,
                .VerifyOtPForClient:
            
              
            return .post
            
        case
                
                .getEmployeeInformation,
                
                .getCategories,
                
                .searchAll,
            
                .getEmployees,
                .getservices,
            
                .getClientList,
                .getClientGroup,
            
                .getNotifications,
            
                .getAllAppointmnents,
                .getAppointMents(_),
                .getDashboardDetails,
            
                .cancelAppointment:
            
            return .get
            
            //            return .put
            
        }
    }
    
    public var parameters: [String:Any]? {
        
        switch self {
            //MARK: - login para
            
        case .signUp(let profDet):
            return profDet
            
        case .login(let profDet): //new
            return profDet
            
        case .logout:
            return nil
            
        case .resetPassword(let data):
            return data
            
        case .updatePassword(let profDet):
            return profDet
            
        case .changePassword(let profDetails):
            return profDetails

        case .deletAccount:
            return nil
            
            
            //MARK: - profile para
        case .getEmployeeInformation: //new
            return nil
            
        case .uploadProfileImage(let profDetails)://new
            return profDetails
            
        case .updateProfile(let data):
            return data
            
            
            
            //MARK: - appoinmemt para
            
        case .getAppointMents:
            return nil
            
        case .getAllAppointmnents:
            return nil
            
        case .cancelAppointment:
            return nil
            
        case .resceduleAppoint(let id,let date,let startTime):
            return ["appointment_id":id, "date":date, "start_time":startTime]
            
            
        case .checkAvailability(let data):
            return data
            
        case .bookAppointMent(let data):
            return data
            
            
            
        case .getCategories:
            return nil
        case .getEmployees:
            return nil
        case .getservices:
            return nil
            
            
        case .searchAll:
            return nil
            
            //MARK: - clients
        case .getClientList:
            return nil
       
        case .getClientGroup:
            return nil
        case .addClient(let data):
            return data
        case .VerifyOtPForClient(let data):
            return data
        case .sendOTPForClient(let data):
            return data
    
            
            
        case .sendOtp(let date):
            return ["phone":date]
        case .getSalesReport:
            return nil
        case .walkinCheckout(let data):
            return data
            
            
        case .getNotifications:
            return nil
            
        case .getDashboardDetails:
            return nil
           
        case .updateToken(let profDetails):
            return profDetails
        }
    }
    
    
    public var sampleData: Data {
        
        switch self {
            
        case .signUp:
            return stubbedResponse("")
        case .login:
            return stubbedResponse("")
        case .logout:
            return stubbedResponse("")
            
        case .updatePassword:
            return stubbedResponse("")
        case .changePassword:
            return stubbedResponse("")
            
        case .deletAccount:
            return stubbedResponse("")
            
        
            
            //profile
        case .getEmployeeInformation:
            return stubbedResponse("")
            
        case .uploadProfileImage:
            return stubbedResponse("")
            
        
            //
        case .getCategories:
            return stubbedResponse("")
        case .getAppointMents:
            return stubbedResponse("")
        case .getEmployees:
            return stubbedResponse("")
        case .getservices:
            return stubbedResponse("")
      
            //        case .getWalkinEmpoloyee:
            //            return stubbedResponse("")
        
        case .checkAvailability:
            return stubbedResponse("")
        case .updateProfile:
            return stubbedResponse("")
        case .searchAll:
            return stubbedResponse("")
        case .getClientList:
            return stubbedResponse("")
        case .getClientGroup:
            return stubbedResponse("")
        case .bookAppointMent:
            return stubbedResponse("")
        case .sendOtp:
            return stubbedResponse("")
        case .cancelAppointment:
            return stubbedResponse("")
        case .resceduleAppoint:
            return stubbedResponse("")
        case .getSalesReport:
            return stubbedResponse("")
        case .walkinCheckout:
            return stubbedResponse("")
        case .resetPassword:
            return stubbedResponse("")
        case .addClient:
            return stubbedResponse("")
        case .sendOTPForClient:
            return stubbedResponse("")
        case .VerifyOtPForClient:
            return stubbedResponse("")
      
        case .getAllAppointmnents:
            return stubbedResponse("")
        case .getNotifications:
            return stubbedResponse("")
        case .getDashboardDetails:
            return stubbedResponse("")
        
        case .updateToken:
            return stubbedResponse("")
       
        }
    }
    
    public var task: Task {
        switch self {
       
        case let .getDashboardDetails(branchID):
            
            return .requestParameters(
            parameters: ["branch_id":branchID], encoding: URLEncoding.queryString)
           
        case .getClientList(let id, let search):
            let para = getClientParam(groupID: id, searchText: search)
            print(para)
            return  .requestParameters(
                parameters: para, encoding: URLEncoding.queryString)
                
            
            //MARK: - search
        case let .searchAll(searchTerm,branchID):
            
            print(["search_term":searchTerm, "branch_id":branchID])
          
            return .requestParameters(
            parameters: ["search_term":searchTerm,"branch_id":branchID], encoding: URLEncoding.queryString)
             
            
            //MARK: - categories
        case let .getCategories(gender, keyValue, key):
            return .requestParameters(
                parameters: getCategoriesParam(gender: gender, keyValue: keyValue, key: key), encoding: URLEncoding.queryString)
            
            //MARK: - services
        case let .getservices(shopId, gender, employeeID, categoryID):
            
            let param = getServicesParam(gender: gender, branchId: shopId, employeeID: employeeID, categoryId: categoryID)
            print("service paraam: \(param)")
            
            return .requestParameters(
                parameters: param, encoding: URLEncoding.queryString)
            
            
            
            //MARK: employee
            
        case let .getEmployees(lat, lon, gender, branchId, EmployeeID, servicesID):
            let param  = getEmployeesParam(lat: lat, lon: lon, gender: gender, branchId:branchId,employeeID: EmployeeID,servicesID: servicesID )
            print("employee paraam: \(param)")
            return .requestParameters(
                parameters:param, encoding: URLEncoding.queryString)
            
            
            //MARK: - appointment
        case .cancelAppointment(let Id):
            return .requestParameters(
                parameters: ["appointment_id":Id]
                , encoding: URLEncoding.queryString)
            
        case .getAppointMents(let date):
         print(["date":date])
            return .requestParameters(
                parameters: ["date":date]
                , encoding: URLEncoding.queryString)
            
        case .getAllAppointmnents(let month):
        print(["month":month])
            return .requestParameters(
                parameters: ["month":month]
                , encoding: URLEncoding.queryString)
            
            
        case .uploadProfileImage(let params):
            var formData = [MultipartFormData]()
            for (key, value) in params {
                if let imgData = value as? Data {
                    formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "\(randomString(length: 6)).jpg", mimeType: "image/jpeg"))
                } else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
                }
            }
            return .uploadMultipart(formData)
            
            
            //    case .updateProfile(let params):
            //        var formData = [MultipartFormData]()
            //        for (key, value) in params {
            //            if let imgData = value as? Data {
            //                formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "testImage.jpg", mimeType: "image/jpeg"))
            //            } else {
            //                formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
            //            }
            //        }
            //        return .uploadMultipart(formData)
            
            //    case .cancelAppointment(let key):
            //                return .requestParameters(parameters: ["appointment_id" : key], encoding: URLEncoding.queryString)
            
        default:
            if(parameters != nil){
                return Task.requestParameters(parameters: (parameters)!, encoding: parameterEncoding)
            }else{
                return Task.requestPlain
            }
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case  .login:
            return JSONEncoding.prettyPrinted
        default:
            return JSONEncoding.prettyPrinted
        }
    }
}


//MARK: param
func getCategoriesParam(gender:Int,keyValue:Int?, key:String)-> [String:Any]{
    
    if keyValue == nil{
        return ["gender":gender]
    }else{
        return [key:keyValue, "gender":gender]
    }
}

func getClientParam(groupID:Int,searchText:String?) -> [String:Any]{
    var param:[String:Any]  =  ["group_id":groupID]
    
    if groupID == -1  {
        return [:]
    }

    return param
}

func getServicesParam(gender:Int,branchId:Int?, employeeID:Int?, categoryId:Int?) ->[String:Any]{
    var param  =  ["gender":gender]
    
    if let branchId {
        param["branch_id"] = branchId
    }
    
    if let employeeID {
        param["employee_id"] = employeeID
    }
    
    
    if let categoryId {
        param["category_id"] = categoryId
    }
    return param
}

func getEmployeesParam(lat:String, lon:String,gender:Int,branchId:Int?, employeeID:Int?, servicesID:Int?) ->[String:Any]{
    
    if branchId == nil,employeeID == nil,servicesID==nil{
        return  [ "latitude": lat , "longitude": lon, "gender":gender]
    }else{
        
        var param  =  ["gender":gender]
        
        if let branchId {
            param["branch_id"] = branchId
        }
        
        if let employeeID {
            param["employee_id"] = employeeID
        }
        
        
        if let servicesID {
            param["service_id"] = servicesID
        }
        return param
    }
}



//MARK: -- other
func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}


func stubbedResponse(_ filename: String) -> Data! {
    let bundleURL = Bundle.main.bundleURL
    
    let path = bundleURL.appendingPathComponent("Frameworks/PartyAppKit.framework/\(filename).json") //bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: path))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}


func mimeType(for data: Data) -> String {
    
    var b: UInt8 = 0
    data.copyBytes(to: &b, count: 1)
    
    switch b {
    case 0xFF:
        return "image/jpeg"
    case 0x89:
        return "image/png"
    case 0x47:
        return "image/gif"
    case 0x4D, 0x49:
        return "image/tiff"
    case 0x25:
        return "application/pdf"
    case 0xD0:
        return "application/vnd"
    case 0x46:
        return "text/plain"
    default:
        return "text/plain"
    }
}


