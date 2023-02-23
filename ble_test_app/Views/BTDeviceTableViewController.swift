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
    var services: [BTDisplayService]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = "echo"
        services.removeAll()
        tableView.reloadData()
    }
    

    func configureTableView() {
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }
    
    
    //MARK: - Delegate, DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return services.count > 0 ? services.count : 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = "UUID: \(peripheral.peripheral.identifier)"
            } else {
                cell.textLabel?.text = services.isEmpty ? "STATUS: DISCONNECT" : "STATUS: CONNECTED"
            }
        default:
//            cell.textLabel?.text = "echo lalal"
            cell.textLabel?.text = !services.isEmpty  ? services[indexPath.row].uuid.uuidString : "echo"
//            if !services.isEmpty {
//                cell.textLabel?.text = services[indexPath.row].uuid.uuidString
//            } else {
//                cell.textLabel?.text = "echo"
//            }
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
        case 1:
            output.connectTo(peripheral)
            tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = "Connecting..."
            tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.text = "STATUS: CONNECTING..."
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
    
    func updateVC(services: [BTDisplayService]) {
        self.services = services
        tableView.reloadData()
    }
}

