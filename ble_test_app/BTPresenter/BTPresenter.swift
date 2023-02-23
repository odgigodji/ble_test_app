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
//        deviceManager.attach(detailView as! BLEManagerObserver)
    }
    
    func update(subject: BLEManager) {
        let peripherals = Array(subject.discoveredPeripherals)
        view.updatePeripheralsOnTableView(peripherals: peripherals)
        
        let services = deviceManager.discoveredServices
//        print(services)
        detailView.updateVC(services: services)
//        deviceManager.discoveredServices.removeAll()
    }
    
    func connectTo(_ peripheral: BTDisplayPeripheral) {
//        guard let name = peripheral.peripheral.name else { return }
       
        deviceManager.connectTo(peripheral.peripheral)
        deviceManager.stopScan()
        deviceManager.discoveredServices.removeAll()
//        detailView.updateVC()
    }
    
//    func createDetailView(with peripheral: BTDisplayPeripheral) -> UIViewController {
//        detailView.setVC(with: peripheral)
//        return (detailView as? UIViewController)!
//    }
}
