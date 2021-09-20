//
//  ViewController.swift
//  TryPushNotifications
//
//  Created by Ilya Cherkasov on 20.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    private var notificationsTypes: [NotificationsType] = [
        NotificationsType(name: "Local Notification"),
        NotificationsType(name: "Local Notification with Action"),
        NotificationsType(name: "Local Notification with Content"),
        NotificationsType(name: "Push Notification with APNs"),
        NotificationsType(name: "Push Notification with FireBase"),
        NotificationsType(name: "Local Notification with Content"),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        title = "Notifications"
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notificationsTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notificationsTypes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = notificationsTypes[indexPath.row].name
        let alert = UIAlertController(title: name,
                                      message:  "Через 5 секунд появится нотификация",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { [weak self] action in
            self?.appDelegate?.scheduleNotification(notificationType: name)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
