//
//  BTDeviceViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 22.02.23.
//

import UIKit

class BTDeviceTableViewController: UITableViewController {

    var output: BTPresenterOutput!
    var peripheral: BTDisplayPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTableView()
    }
    

    func configureTableView() {
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }
    
    
    //MARK: - Delegate, DataSource
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            output.updateDetail()
        default:
            return
        }
    }
    
}

extension BTDeviceTableViewController: BTPresenterDetailInput {
    func setVC(with peripheral: BTDisplayPeripheral) {
        self.peripheral = peripheral
        navigationItem.title = peripheral.peripheral.name ?? "N/A"
    }
    
    func updateVC() {
        print("LALAL")
    }
    
}
