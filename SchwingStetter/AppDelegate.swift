//
//  AppDelegate.swift
//  SchwingStetter
//
//  Created by TestMac on 08/10/18.
//  Copyright © 2018 TestMac. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var fcmToken_: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        
         if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self //as? UNUserNotificationCenterDelegate
            
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
        
       
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let vc_splash = storyboard.instantiateViewController(withIdentifier: "viewCont") as! ViewController
        self.window?.rootViewController = vc_splash*/
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func configureNotification() {
        /*if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { (isGranted, error) in
                print("granted:- \(isGranted),  error:- \(error!)")
            })
        }*/
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let str_deviceToken = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("str_deviceToken:- \(str_deviceToken) \n uuid:- \(UIDevice.current.identifierForVendor!.uuidString)")
        Messaging.messaging().apnsToken = deviceToken
        getFCMToken()
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APN Error:- \(error.localizedDescription)")
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func getFCMToken() {
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
                self.fcmToken_ = ""
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                //self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
                self.fcmToken_ = result.token
            }
        }
    }
    
   
   /* class func sharedInstance() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }*/
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("userinfo:- \(userInfo)")
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let defaults = UserDefaults.standard
        defaults.set(fcmToken, forKey: "deviceToken")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("receivedMsg:- \(remoteMessage.appData)")
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        print("receivedMsg1:- \(remoteMessage.appData)")
    }
}
/*Blend channels feature is missing in Android app
 A user can add multiple channels and name them as their own channel, we call it as
 Blend, We have this feature in iPhone but not on Android. we want to bring this feature to
 Android now.*/


