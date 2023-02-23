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
    var detailView          = BTDeviceTableViewController()
    let presenter           = BTPresenter()
    var dataManager         : BLEManager! = nil
    
    func createMainPresenter() {
        view.output             = presenter
        detailView.output       = presenter
        
        presenter.view          = view
        presenter.detailView    = detailView
        
        dataManager             = BLEManagerImpl()
        
        presenter.deviceManager = dataManager
        presenter.deviceManager.configureManager()
        
        presenter.startScan()
    }
    
}
