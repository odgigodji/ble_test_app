//
//  BLEManager.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit
import CoreBluetooth

protocol BLEManager: AnyObject {
    var centralManager: CBCentralManager! { get set }
    var discoveredPeripherals : Set<DisplayPeripheral> { get set }
    var delegate : CBCentralManagerDelegate! { get set }
    
    func startScan()
}

final class BLEManagerImpl: BLEManager {
    var delegate: CBCentralManagerDelegate!
    
    var centralManager: CBCentralManager!
    var discoveredPeripherals = Set<DisplayPeripheral>()
    
    init(on viewController: CBCentralManagerDelegate) {
        delegate = viewController
        centralManager = CBCentralManager(delegate: viewController, queue: nil)
    }
    
    func startScan() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func getDiscoveredPeripherals(advertisementData: [String : Any], rssi RSSI: NSNumber, peripheral: CBPeripheral){
//        let isConnectable = advertisementData["kCBAdvDataIsConnectable"] as! Bool
//
//        let displayPeripheral = DisplayPeripheral(peripheral: peripheral, lastRSSI: RSSI, isConnectable: isConnectable)
//
//        if discoveredPeripherals.contains(displayPeripheral) == false {
//            discoveredPeripherals.insert(displayPeripheral)
//        }
        
    }
 
}
