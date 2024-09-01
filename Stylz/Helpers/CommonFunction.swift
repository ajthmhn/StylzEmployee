//
//  CommonFunction.swift
//  Stylz
//
//  Created by WC_Macmini on 26/02/23.
//

import Foundation
import UIKit
import StylzWebkit
import Kingfisher
import Indicate
import SwiftyJSON

struct stryBrdId {
    static let login = "LoginViewController_id"
    static let signUp = "SignUpViewController_id"
   static let updatePass = "UpdatePasswordViewController"
    
    static let otpView = "OTPViewController"
    static let retrievePass = "ForgotPasswordViewController"
    
    static let services = "ServiceViewController_id"
    static let serviceDetails = "ServiceDetailsViewController_id"
    static let search = "SearchViewController_id"
    static let cart = "CartViewController_id"
    static let selectDate = "SelectDateViewController_id"
    static let success = "SuccessViewController_id"
    static let appointment = "AppointmentsViewController_id"
    static let appointmnentDetail = "AppointmentDetailsViewController_id"
    static let settings = "SettingsViewController_id"
    static let profile = "ProfileViewController_id"
    static let clients = "ClientsViewController_id"
    static let recovery = "RecoveryViewController_id"
    static let payment = "PaymentViewController_id"
    static let resetPas = "ResetPasswordViewController_id"
    static let report = "ReportViewController_id"
    static let addClient = "AddClientViewController_id"
    static let addClientWithNumber = "AddClientWithNumberViewController"
    static let notification = "NotificationsViewController_id"
}

var languageChange =  false
extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars = ["F","F"] + chars
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}

func getThemeColor() -> UIColor{
   // if checkIfNotMale() == true{
     //   return UIColor(hexString: "F35F5D")!
    //}else{
        return UIColor(hexString: "61AB9A")!
    //}
}

func getDarkColor(red:Bool) -> UIColor{
    if red == true{
        return UIColor(hexString: "F35F5D")!
    }else{
        return UIColor(hexString: "61AB9A")!
    }
}


func getErrMsg(json:JSON?)->String{
    if let err = json?["message"].stringValue, err != ""  {
        return err
    }
    else{
        return     LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "")
    }
}

func saveUserDetails(userDetails:User){
    let dict = userDetails.dicValue()
    UserDefaults.standard.set(dict, forKey: "user_details")
    UserDefaults.standard.synchronize()
}

func saveCart(details:[String:Any]){
    var isSame = false
    var cartData = [[String:Any]]()
   
    if getCartData() != nil{
        cartData.append(contentsOf: getCartData()!)
    }
    
    if cartData.count > 0{
        for all in cartData{
            //all["customer_id"] as? Int == details["customer_id"] as? Int &&
            if all["service_id"] as? Int == details["service_id"] as? Int{
                isSame = true
            }
        }
    }
    
    if isSame == false{
        cartData.append(details)
    }
    
    UserDefaults.standard.set(cartData, forKey: "cart_details")
    UserDefaults.standard.synchronize()
}

func clearCart(){
    UserDefaults.standard.set(nil, forKey: "cart_details")
    UserDefaults.standard.synchronize()
}


func getCartData() -> [[String:Any]]?{
    return UserDefaults.standard.array(forKey: "cart_details") as? [[String:Any]]
}

func getUserDetails() -> [String:Any]?{
    return UserDefaults.standard.dictionary(forKey: "user_details") ?? nil
}

func deleteUserDetails(){
    let defaults = UserDefaults.standard
    defaults.set(nil, forKey: "user_details")
    defaults.synchronize()
}

func showAlert(title:String,subTitle:String,sender:UIViewController){
    let alertController = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style: UIAlertAction.Style.default) {
                UIAlertAction in
        }
    alertController.addAction(okAction)
    sender.present(alertController, animated: true, completion: nil)
}


func showNetworkError(sender:UIViewController){
    let alert = UIAlertController(title: "" , message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "network_error", comment: ""), preferredStyle: .alert)
    let OkButton = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""),style: .cancel) { (alert) -> Void in
    }
    alert.addAction(OkButton)
    sender.present(alert, animated: true, completion: nil)
}


func setImage(imageView : UIImageView, url : String, placeholderImg:String = "" ){
    let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let imagepath =  URL(string:urlString)
   
    if placeholderImg == ""{
        imageView.kf.setImage(with: imagepath)}
    else{
        let placeHolder = UIImage(named: placeholderImg)
      imageView.kf.setImage(with: imagepath,placeholder:placeHolder )
    
    }
}

func showSuccess(title:String, subTitle:String, view:UIView){
    // STEP 1: Define the content
    let content = Indicate.Content(title: .init(value: LocalizationSystem.sharedInstance.localizedStringForKey(key: "success", comment: ""), alignment: .natural),
                                   subtitle: .init(value: subTitle, alignment: .natural),
                                   attachment: .emoji(.init(value: "✅", alignment: .natural)))
    // STEP 2: Configure the presentation
    let config = Indicate.Configuration()
        .with(tap: { controller in
            controller.dismiss()
        })

    // STEP 3: Present the indicator
    let controller = Indicate.PresentationController(content: content, configuration: config)
    controller.present(in: (view))
}

func animationScaleEffectSingle(view:UIView)
{
    DispatchQueue.main.async {
        view.transform = view.transform.scaledBy(x: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        }, completion: nil)
    }
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

func animationScaleEffect(view:[UIView])
{
    DispatchQueue.main.async {
        for all in view{
            all.transform = all.transform.scaledBy(x: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
                all.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            }, completion: nil)
        }
    }

}

func isNotFirstTime(){
    let defaults = UserDefaults.standard
    defaults.setValue(true, forKey: "check_login")
    defaults.synchronize()
}

func isWalkin(value:Bool){
    let defaults = UserDefaults.standard
    defaults.setValue(value, forKey: "check_walkin")
    defaults.synchronize()
}

func checkWalkin() -> Bool{
    return UserDefaults.standard.bool(forKey: "check_walkin")
}

//func openSideMenu(sender:UIViewController){
//    let clinic = UIStoryboard(name: "Main", bundle: nil)
//    let menuLeftNavigationController = clinic.instantiateViewController(withIdentifier: "SideMenuNavController") as! UISideMenuNavigationController
//
//    if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
//        SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController
//        menuLeftNavigationController.navigationBar.isHidden = true
//        SideMenuManager.default.menuWidth = sender.view.frame.width
//        SideMenuManager.default.menuPresentMode = .menuDissolveIn
//        SideMenuManager.default.menuFadeStatusBar = false
//        SideMenuManager.default.menuBlurEffectStyle = .light
//        sender.present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
//
//    }else{
//        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
//        menuLeftNavigationController.navigationBar.isHidden = true
//        SideMenuManager.default.menuWidth = sender.view.frame.width
//        SideMenuManager.default.menuPresentMode = .menuDissolveIn
//        SideMenuManager.default.menuFadeStatusBar = false
//        SideMenuManager.default.menuBlurEffectStyle = .light
//      //  SideMenuManager.default.menuAnimationFadeStrength = 0.2
//       // SideMenuManager.default.menuShadowOpacity = 2.0
//        sender.present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
//    }
//
//}

extension UICollectionViewFlowLayout {

    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }

}

class RTLNavController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Adding swipe to pop viewController
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = self

        //  UINavigationControllerDelegate
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.view.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
        navigationController.navigationBar.semanticContentAttribute = UIView.isRightToLeft() ? .forceRightToLeft : .forceLeftToRight
    }

    //  Checking if the viewController is last, if not disable the gesture
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count > 1 {
            return true
        }
        
        return false
    }
}

extension UIView {
    static func isRightToLeft() -> Bool {
        return UIView.appearance().semanticContentAttribute == .forceRightToLeft
    }
}

extension UILabel {
    func addSlantLine() {
        let slantLinePath = UIBezierPath()
        slantLinePath.move(to: CGPoint(x: 0, y: self.frame.height + 5 ))
        slantLinePath.addLine(to: CGPoint(x: self.frame.width + 20, y: 9))

        let slantLineLayer = CAShapeLayer()
        slantLineLayer.path = slantLinePath.cgPath
        slantLineLayer.lineWidth = 1
        slantLineLayer.strokeColor = UIColor(hexString: "BCBCBC")?.cgColor
        layer.addSublayer(slantLineLayer)
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}

extension UIView {
    func addDashedBorder(_ color: UIColor = UIColor.black, withWidth width: CGFloat = 2, cornerRadius: CGFloat = 5, dashPattern: [NSNumber] = [3,6]) {

        let shapeLayer = CAShapeLayer()

        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath

        self.layer.addSublayer(shapeLayer)
      }
}

extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
      }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}




func getFormatedDate2(dateString:String, requiredformat:String) -> String
{
   // let dateString = "2024-04-05T09:00:00Z"

    // Create a DateFormatter instance
    let dateFormatter = DateFormatter()

    // Set the date format to match the input string
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    // Set the timezone to UTC to match the input string
    dateFormatter.timeZone = TimeZone(identifier: "UTC")

    // Parse the string into a Date object
    if let date = dateFormatter.date(from: dateString) {
        // Create another DateFormatter for extracting the time
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = requiredformat
        
        // Set the timezone to UTC to match the input string
        timeFormatter.timeZone = TimeZone(identifier: "UTC")
        timeFormatter.locale = Locale(identifier:"en")
        
        // Format the date to get the time component
        let timeString = timeFormatter.string(from: date)
        
        print("Time extracted from string:", timeString)
        return timeString
    } else {
        print("Failed to parse date string")
    }

    return dateString
    
}
