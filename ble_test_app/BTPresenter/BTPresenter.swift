//
//  BTPresenter.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit

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
    }
    
    func connectTo(_ peripheral: BTDisplayPeripheral) {
//        guard let name = peripheral.peripheral.name else { return }
       
        deviceManager.connectTo(peripheral.peripheral)
//        print("PERIPHERAL IS = \(name)")
        detailView.updateVC()
    }
    
//    func createDetailView(with peripheral: BTDisplayPeripheral) -> UIViewController {
//        detailView.setVC(with: peripheral)
//        return (detailView as? UIViewController)!
//    }
}
