//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Combine
import CoreMotion
import Foundation

class ___VARIABLE_productName___: NSObject {
    static let shared = ___VARIABLE_productName___()
    
    private let motionActivityManager = CMMotionActivityManager.init()
    private let motionManager = CMMotionManager.init()
    private var cancellables = Set<AnyCancellable>()
    private let queue = OperationQueue()
    
    @Published private(set) var currentAuthorizationStatus: CMAuthorizationStatus = .notDetermined
    @Published private(set) var accelerometerData: CMAccelerometerData?
    
    // MARK: - Init
    
    private override init() {
        super.init()
        
        currentAuthorizationStatus = CMMotionActivityManager.authorizationStatus()
    }
    
    // MARK: - Accessors
    
    var isAuthorized: Bool {
        currentAuthorizationStatus == .authorized
    }
    
    // MARK: - Request authorization
    
    func requestAuthorization() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            currentAuthorizationStatus = .restricted
            return
        }
        
        let updateAuthorizationStatus = { [weak self] in
            self?.currentAuthorizationStatus = CMMotionActivityManager.authorizationStatus()
        }
        
        switch currentAuthorizationStatus {
        case .authorized, .restricted, .denied:
            updateAuthorizationStatus()
            
        case .notDetermined:
            motionActivityManager.queryActivityStarting(from: Date(), to: Date(), to: .main) { _, _ in
                updateAuthorizationStatus()
            }
        @unknown default:
            updateAuthorizationStatus()
        }
    }
    
    // MARK: - Accelerometer
    
    func startAccelerometerUpdates(updateInterval: TimeInterval = 0.01) {
        guard motionManager.isAccelerometerActive == false else {
            debugPrint("[___VARIABLE_productName___] ⚠️ You try to start accelerometer updates but it was aleady started.")
            return
        }
        
        motionManager.accelerometerUpdateInterval = updateInterval
        motionManager.startAccelerometerUpdates(to: queue) { [weak self] data, error in
            if let error = error {
                debugPrint("[___VARIABLE_productName___] ❌ Error while updating accelerometer: \(error)")
            }
            self?.accelerometerData = data
        }
    }
    
    private func stopAccelerometerUpdates() {
        motionManager.stopAccelerometerUpdates()
    }
}