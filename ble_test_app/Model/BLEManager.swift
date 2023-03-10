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
    var discoveredCharacteristic : [BTDisplayCharacteristic] { get set }
    func configureManager()
    func startScan()
    func connectTo(_ peripheral: CBPeripheral)
    func stopScan()
}


final class BLEManagerImpl: CBCentralManager, CBCentralManagerDelegate, BLEManager {
    var characteristicValue : Data?
    var discoveredPeripherals       = Set<BTDisplayPeripheral>()
    var discoveredCharacteristic    = [BTDisplayCharacteristic]()
    private lazy var observers      = [BLEManagerObserver]()
       
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
    
    //MARK: - Confiugure
    func configureManager() { delegate = self }
    
    func startScan() {
        DispatchQueue.global().async {
            self.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func connectTo(_ peripheral: CBPeripheral) {
        self.connect(peripheral)
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
            discoveredCharacteristic.append(BTDisplayCharacteristic(uuid: characteristic.uuid, properties: characteristic.properties.rawValue, value: characteristic.value, notifying: characteristic.isNotifying, characteristic: characteristic))
            
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
                
            }
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
                print("\(characteristic.uuid) SUBSCRIBED ON")
            }
            if characteristic.properties.contains(.write) {
                let data = Data(Array("Hello".utf8))
                peripheral.writeValue(data, for: characteristic, type: .withResponse)
            }
            notify()
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
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard error == nil else {
            print("WRITE ERROR : \(error!.localizedDescription)")
            return
        }
        print("NEW VALUE = \"\(characteristic.value?.debugDescription ?? "nil")\" ")
    }
}
