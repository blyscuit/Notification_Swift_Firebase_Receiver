//
//  AppDelegate.swift
//  NotificationManager
//
//  Created by Pisit W on 20/1/2563 BE.
//  Copyright © 2563 23. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

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
        UNUserNotificationCenter.current().delegate = self

        print("fcm token: \(Messaging.messaging().fcmToken)")
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(_ application:
        
        UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        // Make background notification with Firebase
        // API

//        {
//             "to" : "fcm token",
//
//            "notification":{
//                "title" : "Check this Title",
//                "subtitle" : "Subtitle",
//                "body" : "Body",
//                "mutable_content" : false,
//
//                "category" : "categoryID"
//            },
//                "content_available": true,
//
//            "data":{
//                "show": "sadf",
//                "message": "Offer!",
//                "mediaUrl":  "https://png.pngtree.com/png-clipart/20190515/original/pngtree-beautiful-hologram-water-color-frame-png-image_3643167.jpg"
//            }
//
//        }
        
        let notificationId = (userInfo["notification_id"] as? String) ?? ""
        let title = (userInfo["title"] as? String) ?? ""
        let body = (userInfo["body"] as? String) ?? ""
        let category = (userInfo["category"] as? String) ?? ""
        let action = (userInfo["action"] as? String) ?? ""
        let targetId1 = (userInfo["target_id_1"] as? String) ?? ""
        let value1 = (userInfo["value_1"] as? String) ?? ""
        let type = (userInfo["show"] as? String) ?? ""
        let message = (userInfo["message"] as? String) ?? ""
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + type)
       
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = message

        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

