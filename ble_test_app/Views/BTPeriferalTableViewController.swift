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
        tableView.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Device Manager"
    }
    
    //MARK: - Configure
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BTTableViewCell.self, forCellReuseIdentifier: BTTableViewCell.reuseID)
        tableView.rowHeight = 50
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

        cell.nameLabel.text = "\(discoveredPeripherals[indexPath.row].peripheral.name ?? "N/A") | " +   "\(discoveredPeripherals[indexPath.row].isConnectable) | " +
        "\(discoveredPeripherals[indexPath.row].lastRSSI)"
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.detailView.setVC(with: discoveredPeripherals[indexPath.row])
        let vc = output.detailView as! UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension BTPeriferalTableViewController: BTPresenterMainInput {
    
    func updatePeripheralsOnTableView(peripherals: [BTDisplayPeripheral]) {
        discoveredPeripherals = peripherals
        self.tableView.reloadData()
    }
}
