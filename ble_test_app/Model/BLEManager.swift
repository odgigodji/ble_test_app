//
//  BLEManager.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit
import CoreBluetooth


protocol BLEManager: AnyObject, BLManagerSubject {
    var discoveredPeripherals : Set<BTDisplayPeripheral> { get set }
    func configureManager()
    func startScan()
}


final class BLEManagerImpl: CBCentralManager, CBCentralManagerDelegate, BLEManager {

    var discoveredPeripherals = Set<BTDisplayPeripheral>()
    
    private lazy var observers = [BLEManagerObserver]()
    
    func configureManager() {
        delegate = self
    }
    
    func startScan() {
        DispatchQueue.global().async {
            self.scanForPeripherals(withServices: nil, options: nil)
        }
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
        notify()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
//            output.startScan()
            print("START SCAN")
            startScan()
        default:
            print("bluetooth off or problems with it")
        }
    }
    
    
    //MARK: - Observer / Subject
    /// The subscription management methods.
    func attach(_ observer: BLEManagerObserver) {
        observers.append(observer)
    }

    func detach(_ observer: BLEManagerObserver) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
        }
    }

    /// Trigger an update in each subscriber.
    func notify() {
        observers.forEach({ $0.update(subject: self)})
    }
    
}
