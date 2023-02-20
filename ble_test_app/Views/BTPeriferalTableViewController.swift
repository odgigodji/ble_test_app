//
//  BTPeriferalTableViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 17.02.23.
//

import UIKit
import CoreBluetooth

struct DisplayPeripheral: Hashable {
    let peripheral: CBPeripheral
    let lastRSSI: NSNumber
    let isConnectable: Bool
    
    static func ==(lhs: DisplayPeripheral, rhs: DisplayPeripheral) -> Bool {
        return lhs.peripheral == rhs.peripheral
    }
    
    func hash(into hasher: inout Hasher) { }
}

class BTPeriferalTableViewController: UITableViewController {
//    private var centralManager: CBCentralManager!
//    private var deviceManager : BLEManager!
    var services = [CBUUID]()
    
    var output: BTPresenterOutput!
    //    var peripheral = Set<CBPeripheral>()
    
//    var discoveredPeripherals = [CBPeripheral]()
    var discoveredPeripherals = Set<DisplayPeripheral>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
//        view.backgroundColor = .systemBackground
        view.backgroundColor = .brown

//        deviceManager = BLEManagerImpl(on: self)
//        deviceManager = BLEManagerImpl(on: self)
        
//        navigationController?.title = "Device Manager"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
//        deviceManager.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BTTableViewCell.self, forCellReuseIdentifier: BTTableViewCell.reuseID)
    }
    
//    func startScan() {
//        centralManager.scanForPeripherals(withServices: .none, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
//        deviceManager.startScan()
//    }
    

//MARK: - UITableViewDelegate, UITableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        discoveredPeripherals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BTTableViewCell.reuseID)  as? BTTableViewCell else {
            return BTTableViewCell()
        }
        cell.textLabel?.numberOfLines = 2
        
        let peripheralsArray = Array(discoveredPeripherals)
//        if peripheralsArray.count > indexPath.row {
//            cell.populate(displayPeripheral: peripheralsArray[indexPath.row])
//        }
        
        
//        cell.nameLabel.text = "her"
        cell.nameLabel.text = "\(peripheralsArray[indexPath.row].peripheral.name) " +   " \(peripheralsArray[indexPath.row].isConnectable)"
        return cell
    }
}

extension BTPeriferalTableViewController: CBCentralManagerDelegate {
 
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            output.startScan()
        default:
            print("bluetooth off or problems with it")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//                self.peripheral.insert(peripheral)
        
//        DispatchQueue.global().async {[weak self] in
        //            guard let self = self else { return }
        let isConnectable = advertisementData["kCBAdvDataIsConnectable"] as! Bool
        
        let displayPeripheral = DisplayPeripheral(peripheral: peripheral, lastRSSI: RSSI, isConnectable: isConnectable)
        
        if self.discoveredPeripherals.contains(displayPeripheral) == false {
            self.discoveredPeripherals.insert(displayPeripheral)
        }
        //        }
        tableView.reloadData()
//        print(RSSI.int16Value)
    }
}


extension BTPeriferalTableViewController: BTPresenterInput {
    func showDevices(_ discoveredPeripherals: Set<DisplayPeripheral>) {
//        self.discoveredPeripherals = discoveredPeripherals
//        tableView.reloadData()
    }
}
