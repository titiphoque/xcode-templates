//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Combine
import CoreBluetooth
import Foundation

class ___VARIABLE_productName___: NSObject {
    static let shared = ___VARIABLE_productName___()
    
    private var centralManager: CBCentralManager?
    
    @Published var state: CBManagerState = .poweredOn
    
    // MARK: - Init
    
    private override init() {
        super.init()
        
        centralManager = CBCentralManager(delegate: self,
                                          queue: nil,
                                          options: nil)
    }
    
    // MARK: - Accessors
    
    var isPoweredOn: Bool {
#if targetEnvironment(simulator)
        return true
#else
        return centralManager?.state == .poweredOn
#endif
    }
    
    var isPoweredOff: Bool {
        centralManager?.state == .poweredOff
    }
}

// MARK: - CBCentralManagerDelegate

extension ___VARIABLE_productName___: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        debugPrint("[___VARIABLE_productName___] Status: \(central.state)")
        state = central.state
    }
}