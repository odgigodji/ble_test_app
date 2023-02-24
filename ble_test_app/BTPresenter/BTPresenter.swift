//
//  BTPresenter.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit

protocol BTPresenterOutput: AnyObject, BLEManagerObserver  {
    var deviceManager : BLEManager! { get set }
    var detailView: BTPresenterDetailInput! { get set }
    func startScan()
    func connectTo(_ peripheral: BTDisplayPeripheral)
    func writeCharacteristic()
//    func readCharacteristic(_ characteristic: BTDisplayCharacteristic)
}

class BTPresenter: BTPresenterOutput, BLEManagerObserver {

    weak var view: BTPresenterMainInput!
    weak var detailView: BTPresenterDetailInput!
    var deviceManager : BLEManager!
    
    func startScan() {
        deviceManager.startScan()
        attachObserverTo(deviceManager)
    }
    
    private func attachObserverTo(_ deviceManager: BLEManager) {
        deviceManager.attach(self)
    }
    
    func update(subject: BLEManager) {
        let peripherals = Array(subject.discoveredPeripherals)
        view.updatePeripheralsOnTableView(peripherals: peripherals)
        
        let services = deviceManager.discoveredCharacteristic
        detailView.updateVC(services: services)
        
    }
    
    func connectTo(_ peripheral: BTDisplayPeripheral) {
       
        deviceManager.connectTo(peripheral.peripheral)
        deviceManager.stopScan()
        deviceManager.discoveredCharacteristic.removeAll()
    }
    
    func writeCharacteristic() {
        print("Debug: write to characteristic(not working right now)")
    }
//
//    func readCharacteristic(_ characteristic: BTDisplayCharacteristic) {
//    }
    
}
