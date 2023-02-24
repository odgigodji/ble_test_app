//
//  BTDeviceViewController.swift
//  ble_test_app
//
//  Created by Nikita Evdokimov on 22.02.23.
//

import UIKit


class BTDeviceTableViewController: UITableViewController {

    var output: BTPresenterOutput!
    
    var peripheral: BTDisplayPeripheral!
    var characteristics: [BTDisplayCharacteristic]!
    
    var characteristicVCisOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        configureTableView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = "echo"
        if !characteristicVCisOpen {
            characteristics.removeAll()
        }
        characteristicVCisOpen = false
        tableView.reloadData()
    }

    //MARK: - Configure
    func configureTableView() {
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 50
    }
    
    
    //MARK: - Delegate, DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return characteristics.count > 0 ? characteristics.count : 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = "UUID: \(peripheral.peripheral.identifier)"
            } else {
                cell.textLabel?.text = characteristics.isEmpty ? "STATUS: DISCONNECT" : "STATUS: CONNECTED"
            }
        default:
            cell.textLabel?.text = !characteristics.isEmpty ? characteristics[indexPath.row].uuid.debugDescription : "echo"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "DEVICE STATUS"
        case 1:
            return "CHARACTERISTICS"
        default:
            return "n/a"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            processingSelectionRow(indexPath: indexPath)
        default:
            return
        }
    }
    
    //MARK: - Actions
    private func processingSelectionRow(indexPath: IndexPath) {
        if characteristics.isEmpty {
            firstConnectToPeripheral()
        } else {
            //FIXME: - action to push view controller with characteristics without coreBluetooth stuff
            
            characteristicVCisOpen = true
            let vc = BTCharacteristicTableViewController(characteristic: characteristics[indexPath.row], delegate: self)
            navigationController?.pushViewController(vc, animated: true)
            
//            output.searchCharacteristic(from: services[indexPath.row])
            
//            let vc = BTCharacteristicsTableViewController()
//            vc.configureController(service: characteristics[indexPath.row])
            
//            showCharacteristicOnCharacteristicTVC()
//            print(services[indexPath.row])
        }
    }
    
//    private func showCharacteristicOnCharacteristicTVC() {
//    }
    
    private func firstConnectToPeripheral() {
        output.connectTo(peripheral)
        tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel?.text = "Connecting..."
        tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.text = "STATUS: CONNECTING..."
    }
}

extension BTDeviceTableViewController: BTPresenterDetailInput {
    
    func setVC(with peripheral: BTDisplayPeripheral) {
        self.peripheral = peripheral
        navigationItem.title = peripheral.peripheral.name ?? "N/A"
    }
    
    func updateVC(services: [BTDisplayCharacteristic]) {
        self.characteristics = services
        tableView.reloadData()
    }
}

