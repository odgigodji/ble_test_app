//
//  Assembly.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 20.02.23.
//

import UIKit
import CoreBluetooth

class MainAssembly {
    
    var view                = BTPeriferalTableViewController()
    let presenter           = BTPresenter()
    var dataManager         : BLEManager! = nil
    
    func createMainPresenter() {
        view.output             = presenter
        
        presenter.view          = view
        dataManager = BLEManagerImpl(on: presenter.view as! CBCentralManagerDelegate)
        presenter.deviceManager = dataManager
    }
    
}
