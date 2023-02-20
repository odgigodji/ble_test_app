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
    
    func startScan() {
        deviceManager.startScan()
        
//        let devices = deviceManager.discoveredPeripherals
//        view.showDevices(devices)
//        let numbers = dataManager.obtainNumbers()
//        deviceManager.getDicove
//        view.showNumbers(numbers)
    }
    
//    func updateDataManger() {
//        dataManager.numbers = [6, 7, 8, 9, 10]
//    }
    
}
