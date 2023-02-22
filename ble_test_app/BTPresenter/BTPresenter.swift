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
//    var deviceManager : BLEManager!
    
    func startScan(completed: @escaping (Set<BTDisplayPeripheral>) -> ()) {
        deviceManager.startScan()
        deviceManager.attach(view)
       
        view.discoveredPeripherals = deviceManager.discoveredPeripherals
//        let discoveredPeripherals = self.deviceManager.discoveredPeripherals
//        view.discoveredPeripherals = discoveredPeripherals
//        print(discoveredPeripherals)
        
        //experiment
//        DispatchQueue.global().asyncAfter(deadline: .now() + 3, execute: {
//            let discoveredPeripherals = self.deviceManager.discoveredPeripherals
//            self.view.showDevices(discoveredPeripherals: discoveredPeripherals)
//            print(discoveredPeripherals)
//        })
        
//        completed(discoveredPeripherals)
        
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
