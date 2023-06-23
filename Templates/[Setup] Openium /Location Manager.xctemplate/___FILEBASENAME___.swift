//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Combine
import Foundation
import CoreLocation

class ___FILEBASENAME___: NSObject {
    static let shared = ___FILEBASENAME___()
    
    private var cancellables = Set<AnyCancellable>()
    private let locationManager = CLLocationManager()
    private var isMonitoringSignificantLocationChanges: Bool = false
    
    @Published private(set) var currentAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published private(set) var lastLocation: CLLocation?
    
    // MARK: - Init
    
    private override init() {
        super.init()
        
        // Set delegate and current authorizationStatus
        locationManager.delegate = self
        if #available(iOS 14.0, *) {
            currentAuthorizationStatus = locationManager.authorizationStatus
        } else {
            currentAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
    }
    
#if DEBUG
    // Create a fake LocationManger and inject it where you need
    // Will send `locations` every second
    var fakeLocations = [CLLocation]()
    init(forTest: String?, fakeLocations: [CLLocation]) {
        super.init()
        
        self.fakeLocations = fakeLocations
        
        Timer.publish(every: 1, on: RunLoop.main, in: .default)
            .autoconnect()
            .sink { _ in
                guard self.fakeLocations.isEmpty == false  else {
                    self.lastLocation = CLLocation(latitude: 0, longitude: 0)
                    return
                }
                self.lastLocation = self.fakeLocations.removeFirst()
            }
            .store(in: &cancellables)
    }
#endif
    
    // MARK: - Accessors
    
    var allowsBackgroundLocationUpdates: Bool {
        locationManager.allowsBackgroundLocationUpdates
    }
    
    var isSystemLocationEnabled: Bool {
        CLLocationManager.locationServicesEnabled()
    }
    
    var isAuthorizationStatusAlways: Bool {
        currentAuthorizationStatus == .authorizedAlways
    }
    
    var isAuthorizationStatusNotDetermined: Bool {
        currentAuthorizationStatus == .notDetermined
    }
    
    var isFullAccuracy: Bool {
        guard #available(iOS 14.0, *) else {
            return true
        }
        
        switch locationManager.accuracyAuthorization {
        case .fullAccuracy: return true
        case .reducedAccuracy: return false
        @unknown default: return true
        }
    }
    
    // MARK: - Request authorization
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestAlwaysAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    // MARK: - Updating location and heading
    
    func startUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - Significant Location Changes
    
    func startMonitoringSignificantLocationChanges() {
        guard isMonitoringSignificantLocationChanges == false else { return }
        
        debugPrint("[___FILEBASENAME___] 🚙 Start monitoring significant location changes")
        locationManager.startMonitoringSignificantLocationChanges()
        isMonitoringSignificantLocationChanges = true
    }
    
    func stopMonitoringSignificantLocationChanges() {
        guard isMonitoringSignificantLocationChanges == true else { return }
        
        debugPrint("[___FILEBASENAME___] 🚙 Stop monitoring significant location changes")
        locationManager.stopMonitoringSignificantLocationChanges()
        isMonitoringSignificantLocationChanges = false
    }
}

// MARK: - CLLocationManagerDelegate

extension ___FILEBASENAME___: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        currentAuthorizationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("[___FILEBASENAME___] ❌ Location manager failed to get location: \(error)")
    }
}
