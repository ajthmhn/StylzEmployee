//
//  Constants.swift
//  StylezUser
//
//  Created by MACBOOK on 2/29/24.
//

import Foundation
import UIKit
struct K{
    
    struct User {
        
        static var isSubscribed = false
        static var userID = 0
        static var deviceToken = ""
        static var customerID = 0
        static var dicountValue = 0.0
        static var vatValue = 0.0
        
    }
    
    
    
    struct SearchTypes{
        
        static let shop = "shop"
        static let employee = "employee"
        
    }
    
    struct Color{
        static let AccentColor = UIColor(named:"AccentColor")
        static let gray = UIColor.systemGray6
        static let lightGray = UIColor(named: "lightGray")
        static let green = UIColor(named: "green")
        static let orange = UIColor(named: "orange")
        static let yellow = UIColor(named: "yellow")
        static let grayStar = UIColor(named: "starGray")
        
        static let star = UIColor(named: "Star")
        static let star5 = UIColor(named: "Star5")
        static let star3 = UIColor(named: "Star3")
        static let star2 = UIColor(named: "Star2")
        static let cart = UIColor(named: "Cart")
    }
    
    struct DateFormats{
        
        static let dateLocale = "d/MMM/yyyy"
        static let _dateLocale = "dd-MM-yyyy"
        static let timeLocale = "hh:mm a"
        static let serverDataFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    }
    
    struct placeHolderImage{
        static let employee = "" //test_7 //test_7" //book_stylie
        static let user = "user"
        static let service = "test_2"
        static let scissor = "test_5"
    }
    
    struct UserDefaultsKeys{
        static let isSubscribed = "isSuscribed"
        static let userID = "userID"
        static let user_details = "user_details"
    }
    
    struct Error{
        static let someThingWentWrong = "Something went wrong try again..."
        static let netWorkError = "network Error"
        static let noLocation = "No location found. Please select any location first"
        static let enterValidNum = "Please enter a valid number"
        static let verifyYourEmaiil = "Verify your email address"
        
        //
        static let passwordError = "Password must be at least 8 characters long"
        
        static let timingError = "Please select a time"
        
    }
    
    struct MYStrings{
        static let areYouSure = "Are you sure"
        
        static let yes = "Yes"
        
        
        static let orderID = "Order ID:"
        static let  cancelPremium = "Cancel"
        
        
        //static let     =   "Subscription";
        
        
        static let wantToLogOut = "Are you sure you want to signout?"
        //   static let logout = "Are you sure you want to logout?"
        static let imageUploaded = "Image updated"
        static let verified  = "Verified"
        static let unVerified  = "Unverified"
        static let chooseLoc = "Please choose location"
        static let enterPromoCode = "Please enter promo code"
        
        static let Upload = "Upload"
        
        //unlocaliizee
        
        static let updateYourEmail = "Update your email"
        static let updateYourNumber = "Update your mobile number"
        
        static let updateYourNumberSubHead = "We will send a code to your new mobile number to verify your account"
        
        static let updateYourEmailSubHead = "We will send a code to your new email to verify your account"
        static let email = "Email"
        static let phone = "Phone"
        static let discount  = "discount"
        
        //
        
        
        
        //
        
        static let fogotPAssMsg = "Enter the email address or phone number with your account and we'll send an email with confirmation to reset your password"
       
        //  static mobile
        
        static let continueBtn = "Continue"
        static let notNowBtn = "Not now"
        
        static let sendOTP = "Send OTP"
        
        static let All = "All"
        static let clietAdded = "Client Added"
        
        
        static let clietFound = "Client found"
        
    //    static let vat = "VAT"
        
        
        static let paid = "Paid"
        static let unPaid = "Un Paid"
        
   static let branchISClosed = "Branch is closed on this day"
   
        static let cartIsEmpty = "Your Cart is Empty"
    }
    
    
}
