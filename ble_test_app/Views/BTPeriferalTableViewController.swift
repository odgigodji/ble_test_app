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
    private var centralManager: CBCentralManager!
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

//        navigationController?.title = "Device Manager"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func startScan() {
//        centralManager.scanForPeripherals(withServices: .none, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    

//MARK: - UITableViewDelegate, UITableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        discoveredPeripherals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.numberOfLines = 2
        
        let peripheralsArray = Array(discoveredPeripherals)
//        if peripheralsArray.count > indexPath.row {
//            cell.populate(displayPeripheral: peripheralsArray[indexPath.row])
//        }
        
        cell.textLabel?.text = "\(peripheralsArray[indexPath.row].peripheral.name)\n" + "\(peripheralsArray[indexPath.row].peripheral.identifier)"
        return cell
    }
}

extension BTPeriferalTableViewController: CBCentralManagerDelegate {
 
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("power on")
            startScan()
        case .poweredOff:
            print("alert user to turn on bluetooth")
            // Alert user to turn on Bluetooth
        case .resetting:
            print("ressetting")
            // Wait for next state update and consider logging interruption of Bluetooth service
        case .unauthorized:
            print("unauthorized")
            // Alert user to enable Bluetooth permission in app Settings
        case .unsupported:
            print("unsupported")
            // Alert user their device does not support Bluetooth and app will not work as expected
        case .unknown:
            print("unknown")
        @unknown default:
            print("default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //        self.peripheral.insert(peripheral)
        
        let displayPeripheral = DisplayPeripheral(peripheral: peripheral, lastRSSI: RSSI, isConnectable: true)
        
        if discoveredPeripherals.contains(displayPeripheral) == false {
            discoveredPeripherals.insert(displayPeripheral)
        }
        tableView.reloadData()
        print(RSSI.int16Value)
    }
}


extension BTPeriferalTableViewController: BTPresenterInput {
    func showNumbers(_ numbers: [Int]) {
        print("her")
    }
    
}
