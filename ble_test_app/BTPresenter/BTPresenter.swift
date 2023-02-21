//
//  BTPresenter.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import Foundation

class BTPresenter: BTPresenterOutput {
    
    weak var view: BTPresenterInput!
    var deviceManager : BLEManager!
    
    func startScan(completed: @escaping (Set<BTDisplayPeripheral>) -> ()) {
        deviceManager.startScan()
       
        let discoveredPeripherals = self.deviceManager.discoveredPeripherals
//        completed(discoveredPeripherals)
        print(discoveredPeripherals)
        
//        view.showDevices()
//            if devices.isEmpty {
//                print("EMPTTY")
//            } else {
//                print("FULL")
//            }
//        }
//        let numbers = dataManager.obtainNumbers()
//        deviceManager.getDicove
//        view.showNumbers(numbers)
    }
    
    //when discoveredPeripherals - update ui
    func updatePeripherals() {
//        var devices = Set<BTDisplayPeripheral>()
//        devices = self.deviceManager.discoveredPeripherals
//        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: {
//            self.view.showDevices(devices)
//        })
    }
    
}
