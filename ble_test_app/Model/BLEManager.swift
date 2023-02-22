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
    
    func attach(_ observer: Observer)
    func detach(_ observer: Observer)
    func notify()
}

final class BLEManagerImpl: CBCentralManager, CBCentralManagerDelegate, BLEManager {

    var discoveredPeripherals = Set<BTDisplayPeripheral>()
    
    //MARK: - observers stuff
    private lazy var observers = [Observer]()

    /// The subscription management methods.
    func attach(_ observer: Observer) {
        print("Subject: Attached an observer.\n")
        observers.append(observer)
    }

    func detach(_ observer: Observer) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
            print("Subject: Detached an observer.\n")
        }
    }

    /// Trigger an update in each subscriber.
    func notify() {
        print("Subject: Notifying observers...\n")
        observers.forEach({ $0.update(subject: self)})
    }

    /// Usually, the subscription logic is only a fraction of what a Subject can
    /// really do. Subjects commonly hold some important business logic, that
    /// triggers a notification method whenever something important is about to
    /// happen (or after it).
//    func someBusinessLogic() {
//        print("\nSubject: I'm doing something important.\n")
//        state = Int(arc4random_uniform(10))
//        print("Subject: My state has just changed to: \(state)\n")
//        notify()
//    }
    
    
    
    
    func configureManager() {
        delegate = self
//        startScan()
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
        //        }
        
//        tableView.reloadData()
        
//        print(RSSI.int16Value)
//        print(discoveredPeripherals)
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
    
}
