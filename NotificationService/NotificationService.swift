//
//  NotificationService.swift
//  NotificationService
//
//  Created by Pisit W on 20/1/2563 BE.
//  Copyright © 2563 23. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        // Modify
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
//
//
//            "data":{
//                "show": "sadf",
//                "message": "Offer!",
//                "mediaUrl":  "https://png.pngtree.com/png-clipart/20190515/original/pngtree-beautiful-hologram-water-color-frame-png-image_3643167.jpg"
//            }
//
//        }
        
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

//        print(bestAttemptContent?.title)
//        print(bestAttemptContent?.userInfo)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\((bestAttemptContent.userInfo["show"] as? String ?? "") == "no") \(bestAttemptContent.title)"
            if (bestAttemptContent.userInfo["show"] as? String ?? "") == "no" {
//                UNUserNotificationCenter.current().
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//                }
                contentHandler(UNMutableNotificationContent())
            } else {
                bestAttemptContent.body = "\(bestAttemptContent.userInfo)"
                contentHandler(bestAttemptContent)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
