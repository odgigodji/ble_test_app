//
//  BTDeviceViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 22.02.23.
//

import UIKit

class BTDeviceTableViewController: UITableViewController {

    var peripheral: BTDisplayPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
//        navigationItem.title = "N/A"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.topItem?.title = "her"
    }
    
    func setVC(with peripheral: BTDisplayPeripheral) {
        self.peripheral = peripheral
//        navigationItem.title = peripheral.peripheral.name
        navigationItem.title = peripheral.peripheral.name ?? "N/A"
        
        configureTableView()
//        navigationController?.navigationBar.topItem?.title = "her"
    }
    
    func configureTableView() {
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            cell.textLabel?.text = "connection status"
        } else {
            cell.textLabel?.text = "echo lalal"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "DEVICE STATUS"
        case 1:
            return "ECHO"
        default:
            return "n/a"
        }
    }
    
}
