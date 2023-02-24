//
//  BTCharacteristicTableViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 24.02.23.
//

import UIKit

class BTCharacteristicTableViewController: UITableViewController {

    var characteristic : BTDisplayCharacteristic!
    weak var delegate: BTDeviceTableViewController!
    
    init(characteristic: BTDisplayCharacteristic!, delegate: BTDeviceTableViewController) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
        self.characteristic = characteristic
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
    }

    func configureVC() {
        navigationItem.title = characteristic.uuid.debugDescription
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "WRITE"
//                delegate.output.writeCharacteristic()
            case 1:
                let string = String(data: characteristic.value ?? Data(), encoding: .utf8)
                cell.textLabel?.text = "(\(characteristic.value?.debugDescription ?? "nil"))  \(string ?? " ")"
            default:
                cell.textLabel?.text = "test value "
            }
        case 1:
            cell.textLabel?.text = characteristic.notifying ? "subscribe" : "not notifying"
        default:
            cell.textLabel?.text = "her "
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "VALUE"
        case 1:
            return "NOTIFY VALUE"
        default:
            return "n/a"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                delegate.output.writeCharacteristic()
            }
        default:
            return
        }
    }

}
