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
    var discoveredCharacteristic : [BTDisplayCharacteristic] { get set }
    func configureManager()
    func startScan()
    func connectTo(_ peripheral: CBPeripheral)
    func stopScan()
}


final class BLEManagerImpl: CBCentralManager, CBCentralManagerDelegate, BLEManager {

    var characteristicValue : Data?
    
    var discoveredPeripherals = Set<BTDisplayPeripheral>()
//    var services = [CBService]()
    var discoveredCharacteristic = [BTDisplayCharacteristic]()
    
    private lazy var observers = [BLEManagerObserver]()
    
    func configureManager() { delegate = self }
    
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
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
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

extension BLEManagerImpl: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
            notify()
        }

    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print(characteristic)
            
            discoveredCharacteristic.append(BTDisplayCharacteristic(uuid: characteristic.uuid, properties: characteristic.properties.rawValue, value: characteristic.value, notifying: characteristic.isNotifying, characteristic: characteristic))
            
           //MARK: - discover Descriptors
//            peripheral.discoverDescriptors(for: characteristic)
            
            notify()
            
            
            if characteristic.properties.contains(.read) {
//                print("\(characteristic.uuid): properties contain .read")
                peripheral.readValue(for: characteristic)
                
            }
            if characteristic.properties.contains(.notify) {
//                print("\(characteristic.uuid): properties contain .notify")
                
//                peripheral.setNotifyValue(true, for: characteristic)
//                print("\(characteristic.uuid) SUBSCRIBED ON")
            }
            if characteristic.properties.contains(.write) {
//                print("\(characteristic.uuid): can write ")

                let data = Data(Array("Hello".utf8))
//                print(data)

                peripheral.writeValue(data, for: characteristic, type: .withResponse)

                print("VALUE WRITTEN")
//                print("READ VALUE: ")
//                peripheral.readValue(for: characteristic)
                
//                let string = String(da characteristic.value?.debugDescription.utf8)
//                let string = String(: characteristic.value?)
                let string = String(data: characteristic.value ?? Data(), encoding: .utf8)
                
//                print("Char value: \(characteristic.value?.debugDescription ?? "nil")")
                print("Char value: \(string)")
            }

//            notify()
        }
    }
    
//
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("ERROR: \(error!.localizedDescription)")
            return
        }
        guard let value = characteristic.value else {
            print("UPDATE: NOthing happend")
            return
        }
        print("\(characteristic.uuid) VALUE UPDATED = \(value)")
        notify()
//        switch characteristic.uuid {
//        case manufacturerNameStringCharacteristicCBUUID:
//            guard let value = characteristic.value else { return }
//            print(String(decoding: value, as: UTF8.self))
//        default:
//            print("-")
//          }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard error == nil else {
            print("ERROR: \(error!.localizedDescription)")
            return
        }
        
//        print(characteristic.va)
//        switch characteristic.uuid {
//        case manufacturerNameStringCharacteristicCBUUID:
////            guard let value = characteristic.value else { return }
////            print(String(decoding: value, as: UTF8.self))
//            print("WRITTEN")
//        default:
//            print("=")
//          }
    }
    
    //MARK: - Descriptors
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
//        guard error == nil else {
//            print("ERROR Descriptor: \(error!.localizedDescription)")
//            return
//        }
//        print(characteristic.descriptors)
//    }

}
