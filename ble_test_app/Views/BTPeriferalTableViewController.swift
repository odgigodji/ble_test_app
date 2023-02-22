//
//  BTPeriferalTableViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 17.02.23.
//

import UIKit
import CoreBluetooth


class BTPeriferalTableViewController: UITableViewController {
    var output: BTPresenterOutput!

    var discoveredPeripherals = [BTDisplayPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        view.backgroundColor = .brown
        output.startScan()
    }
    
    //MARK: - Configure
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BTTableViewCell.self, forCellReuseIdentifier: BTTableViewCell.reuseID)
    }
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        discoveredPeripherals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BTTableViewCell.reuseID)  as? BTTableViewCell else {
            return BTTableViewCell()
        }
        cell.textLabel?.numberOfLines = 2
        
//        let discoveredPeripherals = output.deviceManager.discoveredPeripherals
//        let peripheralsArray = Array(discoveredPeripherals)

        cell.nameLabel.text = "\(discoveredPeripherals[indexPath.row].peripheral.name ?? "n/a") " +   " \(discoveredPeripherals[indexPath.row].isConnectable)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(discoveredPeripherals[indexPath.row])
    }
}


extension BTPeriferalTableViewController: BTPresenterInput {
    
    func updatePeripheralsOnTableView(peripherals: [BTDisplayPeripheral]) {
        discoveredPeripherals = peripherals
        self.tableView.reloadData()
    }
}
