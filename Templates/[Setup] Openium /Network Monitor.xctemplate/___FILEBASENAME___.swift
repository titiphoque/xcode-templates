//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Network
import Combine
import Foundation

class ___FILEBASENAME___ {
    static let shared = ___FILEBASENAME___()
    
    private let monitor = NWPathMonitor()
    
    @Published private(set) var isNetworkAvailable: Bool = true
    
    // MARK: - Init
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            debugPrint("[___FILEBASENAME___] Internet on Other               : \(path.usesInterfaceType(.other))")
            debugPrint("[___FILEBASENAME___] Internet on Wi-Fi link          : \(path.usesInterfaceType(.wifi))")
            debugPrint("[___FILEBASENAME___] Internet on Cellular link       : \(path.usesInterfaceType(.cellular))")
            debugPrint("[___FILEBASENAME___] Internet on Wired Ethernet link : \(path.usesInterfaceType(.wiredEthernet))")
            debugPrint("[___FILEBASENAME___] Internet on Loopback Interface  : \(path.usesInterfaceType(.loopback))")
            
            if path.status == .satisfied {
                debugPrint("[___FILEBASENAME___] Internet is available")
            } else {
                debugPrint("[___FILEBASENAME___] Internet is NOT available")
            }
            
            self?.isNetworkAvailable = path.status == .satisfied
        }
    }
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Accessors
    
    func isAvailableOn(interfaceType: NWInterface.InterfaceType) -> Bool {
        monitor.currentPath.usesInterfaceType(interfaceType)
    }
    
    // MARK: - Monitoring
    
    func startMonitoring(on dispatchQueue: DispatchQueue = .global(qos: .background)) {
        monitor.start(queue: dispatchQueue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
