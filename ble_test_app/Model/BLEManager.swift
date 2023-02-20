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
    
    func startScan()
}

final class BLEManagerImpl: BLEManager {
    var centralManager: CBCentralManager!
    
    init(on viewController: CBCentralManagerDelegate) {
        centralManager = CBCentralManager(delegate: viewController, queue: nil)
    }
    
    func startScan() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func centralManagerDidUpdateState() {
        
    }
 
}
