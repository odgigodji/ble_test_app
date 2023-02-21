//
//  BLEManager.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit
import CoreBluetooth

protocol BLEManager: AnyObject {
//    var centralManager: CBCentralManager! { get set }
    var discoveredPeripherals : Set<BTDisplayPeripheral> { get set }
//    var delegate : CBCentralManagerDelegate! { get set }
    func configureManager()
    func startScan()
}

final class BLEManagerImpl: CBCentralManager, CBCentralManagerDelegate, BLEManager {

    var discoveredPeripherals = Set<BTDisplayPeripheral>()
    
    func configureManager() {
        delegate = self
//        startScan()
    }
    
    func startScan() {
        scanForPeripherals(withServices: nil, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//                self.peripheral.insert(peripheral)
        
//        DispatchQueue.global().async {[weak self] in
        //            guard let self = self else { return }
        let isConnectable = advertisementData["kCBAdvDataIsConnectable"] as! Bool
        
        let displayPeripheral = BTDisplayPeripheral(peripheral: peripheral, lastRSSI: RSSI, isConnectable: isConnectable)
        
        if self.discoveredPeripherals.contains(displayPeripheral) == false {
            self.discoveredPeripherals.insert(displayPeripheral)
//            print(displayPeripheral)
        }
        //        }
        
//        tableView.reloadData()
        
//        print(RSSI.int16Value)
//        print(discoveredPeripherals)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
//            output.startScan()
            startScan()
        default:
            print("bluetooth off or problems with it")
        }
    }
    
}
