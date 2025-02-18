//
//  AppDelegate.swift
//  Stylz
//
//  Created by WC_Macmini on 26/02/23.
//

import UIKit
import FirebaseMessaging
import FirebaseCore
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate  {

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()

        registerForNotification(application: application)
        

        Messaging.messaging().delegate = self

        UIView.appearance().semanticContentAttribute =   LocalizationSystem.sharedInstance.getLanguage() == "ar" ? .forceRightToLeft : .forceLeftToRight

        return true
    }

  
    // MARK: UISceneSession Lifecycle
    

    private func application(application: UIApplication,
                             didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           // handler for Push Notifications
         //  Branch.getInstance().handlePushNotification(userInfo)
          
           
        if let messageID = userInfo[gcmMessageIDKey] {
                   print("Message ID: \(messageID)")
        }
        
           // Print full message.
           print(userInfo)
           completionHandler(UIBackgroundFetchResult.newData)
       }
    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


//MARK: - config notif
extension AppDelegate
{

    func registerForNotification(application:UIApplication){
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
 
        application.registerForRemoteNotifications()
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate{
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        print("HANDLING")

        // Change this to your preferred presentation option
        completionHandler([.alert, .badge, .sound])
    }
    
    
    //check point ::::
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
}


extension AppDelegate: MessagingDelegate   {
    // [START refresh_token]

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      
        NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
    }
   
}

