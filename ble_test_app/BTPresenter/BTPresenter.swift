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
        attachObserverTo(deviceManager)
    }
    
    private func attachObserverTo(_ deviceManager: BLEManager) {
        deviceManager.attach(view)
        
        view.discoveredPeripherals = deviceManager.discoveredPeripherals
    }
    
}
