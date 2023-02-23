//
//  BLEManager.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit
import CoreBluetooth

let modelNumberStringCharacteristicCBUUID = CBUUID(string: "2A24")
let manufacturerNameStringCharacteristicCBUUID = CBUUID(string: "2A29")

protocol BLEManager: AnyObject, BLManagerSubject {
    var discoveredPeripherals : Set<BTDisplayPeripheral> { get set }
    var discoveredServices : [BTDisplayService] { get set }
    func configureManager()
    func startScan()
    func connectTo(_ peripheral: CBPeripheral)
    func stopScan()
}


final class BLEManagerImpl: CBCentralManager, CBCentralManagerDelegate, BLEManager {
//    var services: [BTDisplayService]
    
    

    var discoveredPeripherals = Set<BTDisplayPeripheral>()
//    var services = [CBService]()
    var discoveredServices = [BTDisplayService]()
    
    private lazy var observers = [BLEManagerObserver]()
    
    func configureManager() {
        delegate = self
    }
    
    func startScan() {
        DispatchQueue.global().async {
            self.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func connectTo(_ peripheral: CBPeripheral) {
        self.connect(peripheral)
    }
    
    
    //MARK: - Delegate methods
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let isConnectable = advertisementData["kCBAdvDataIsConnectable"] as! Bool
        
        let displayPeripheral = BTDisplayPeripheral(peripheral: peripheral, lastRSSI: RSSI, isConnectable: isConnectable)
        //MARK: - delegate service
        displayPeripheral.peripheral.delegate = self
        
        if self.discoveredPeripherals.contains(displayPeripheral) == false {
            self.discoveredPeripherals.insert(displayPeripheral)
        }
        notify()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("START SCAN")
            startScan()
        default:
            print("bluetooth off or problems with it")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("CONNECTED to \(peripheral.name ?? "N/A")!")
        peripheral.discoverServices(nil)
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

extension BLEManagerImpl: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
//        self.services = services
        
        for service in services {
//            print(service)
//            let name = service. ?? "N/A"
            print("-----")
            print(service)
            print("-----")
            
            discoveredServices.append(BTDisplayService(isPrimary: service.isPrimary, uuid: service.uuid))
            notify()
        }
//        for service in services {
//            print("-------")
//            print(service)
            
//            services.append(service)
        //MARK: - search characteristic
//            peripheral.discoverCharacteristics(nil, for: service)
            
//            print(service.characteristics ?? "characteristic is nil")
            
//            print("--------")
//        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print(characteristic)
            
//            if characteristic.properties.contains(.read) {
//                print("\(characteristic.uuid): properties contain .read")
////                peripheral.readValue(for: characteristic)
//            }
//            if characteristic.properties.contains(.notify) {
//                print("\(characteristic.uuid): properties contain .notify")
//                peripheral.setNotifyValue(true, for: characteristic)
//            }
//            if characteristic.properties.contains(.write) {
//                print("\(characteristic.uuid): can write ")
//
//                let data = Data(Array("Echo".utf8))
//                print(data)
//
//                peripheral.writeValue(data, for: characteristic, type: .withResponse)
//
////                print("READ VALUE: ")
////                peripheral.readValue(for: characteristic)
//            }

//            notify()
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case manufacturerNameStringCharacteristicCBUUID:
            guard let value = characteristic.value else { return }
            print(String(decoding: value, as: UTF8.self))
        default:
            print("-")
          }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
        case manufacturerNameStringCharacteristicCBUUID:
//            guard let value = characteristic.value else { return }
//            print(String(decoding: value, as: UTF8.self))
            print("WRITTEN")
        default:
            print("=")
          }
    }
    
    
//    private func manufacturerNameString(from characteristic: CBCharacteristic) -> String {
//      guard let characteristicData = characteristic.value,
//        let byte = characteristicData.first else { return "Error" }
//
//      switch byte {
//        case 0: return "Other"
//        case 1: return "Chest"
//        case 2: return "Wrist"
//        case 3: return "Finger"
//        case 4: return "Hand"
//        case 5: return "Ear Lobe"
//        case 6: return "Foot"
//        default:
//          return "Reserved for future use"
//      }
//    }

}
