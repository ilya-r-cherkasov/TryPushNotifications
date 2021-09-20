//
//  AppDelegate.swift
//  TryPushNotifications
//
//  Created by Ilya Cherkasov on 20.09.2021.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAutorization()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            print("Права даны: \(granted)")
            
            guard granted else { return }
            self?.getNotificationsSettings()
        }
    }
    
    func getNotificationsSettings() {
        notificationCenter.getNotificationSettings { settings in
            print("Настройки уведомления: \(settings)")
        }
    }
    
    func scheduleNotification(notificationType: String) {
        let content = UNMutableNotificationContent()
        content.title = notificationType
        content.body = "Создано: " + notificationType
        content.sound = .default
        content.badge = 1 //количество непрочитанных сообщений
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { error in
            print("Error: \(String(describing: error?.localizedDescription))")
        }
    }
}

