//
//  BTPeriferalTableViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 17.02.23.
//

import UIKit
import CoreBluetooth


class BTPeriferalTableViewController: UITableViewController {
//    private var centralManager: CBCentralManager!
//    private var deviceManager : BLEManager!
//    var services = [CBUUID]()
    
    var output: BTPresenterOutput!

    var discoveredPeripherals = Set<BTDisplayPeripheral>()
//    var discoveredPeripherals : Set<BTDisplayPeripheral> {
//        get {
//            return output.deviceManager.discoveredPeripherals
//        }
//        set(newPeripherals) {
////            self.discoveredPeripherals = newPeripherals
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        view.backgroundColor = .brown
        output.startScan { discoveredPeripherals in
            print(discoveredPeripherals)
//            self.discoveredPeripherals = discoveredPeripherals
        }
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
        let peripheralsArray = Array(discoveredPeripherals)

        cell.nameLabel.text = "\(peripheralsArray[indexPath.row].peripheral.name) " +   " \(peripheralsArray[indexPath.row].isConnectable)"
        return cell
    }
}


extension BTPeriferalTableViewController: BTPresenterInput {
    func showDevices(discoveredPeripherals: Set<BTDisplayPeripheral>) {
        print("XXXX")
//        self.discoveredPeripherals = discoveredPeripherals
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension BTPeriferalTableViewController: Observer {
    func update(subject: BLEManager) {
        discoveredPeripherals = subject.discoveredPeripherals
        self.tableView.reloadData()
    }
    
}
