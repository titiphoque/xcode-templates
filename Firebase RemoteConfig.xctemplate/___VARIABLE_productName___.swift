//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import Foundation
import FirebaseRemoteConfig

class ___VARIABLE_productName___ {
    // https://firebase.google.com/docs/remote-config/get-started?authuser=1&platform=ios
    static let shared = ___VARIABLE_productName___()
    
    let remoteConfig = RemoteConfig.remoteConfig()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Variable
    
    enum Variable: String, CaseIterable {
        case someString
        case someBool
        
        var defaultValue: Any? {
            switch self {
            case .someString: return "DefaultString"
            case .someBool: return false
            }
        }
    }
    
    // MARK: - Init
    
    private init() {
#if DEBUG
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
#endif
        
        // Force loadValues every 12 hours
        Timer.publish(every: 3600 * 12, on: RunLoop.main, in: RunLoop.Mode.default)
            .sink { [weak self] _ in
                self?.loadValues()
            }
            .store(in: &cancellables)
    }
    
    func loadValues() {
        // Fetch and Activate are async. Activate may finished before Fetch.
        loadDefaultValues()
        fetchRemoteValues()
        activateValues()
    }
    
    // MARK: - Data loading
    
    private func loadDefaultValues() {
        var defaultValues = [String: Any?]()
        Variable.allCases.forEach {
            defaultValues[$0.rawValue] = $0.defaultValue
        }
        
        remoteConfig.setDefaults(defaultValues as? [String: NSObject])
    }
    
    private func fetchRemoteValues() {
        remoteConfig.fetch { status, error in
            switch status {
            case .success: debugPrint("[___VARIABLE_productName___] Fetch success")
            case .failure: debugPrint("[___VARIABLE_productName___] Fetch failed: \(error?.localizedDescription ?? "no error")")
            case .noFetchYet: debugPrint("[___VARIABLE_productName___] Fetch -> config has never been fetched. ")
            case .throttled: debugPrint("[___VARIABLE_productName___] Fetch: throtlled")
            @unknown default: debugPrint("[___VARIABLE_productName___] Fetch: @unknown")
            }
        }
    }
    
    private func activateValues() {
        remoteConfig.activate { changed, error in
            if let error = error {
                debugPrint("[___VARIABLE_productName___] Activate error: \(error)")
            } else {
                debugPrint("[___VARIABLE_productName___] Activate: success")
            }
        }
    }
    
    // MARK: - Get values
    
    func boolValue(for variable: Variable) -> Bool {
        remoteConfig.configValue(forKey: variable.rawValue).boolValue
    }
    
    func stringValue(for variable: Variable) -> String? {
        remoteConfig.configValue(forKey: variable.rawValue).stringValue
    }
    
    func intValue(for variable: Variable) -> Int {
        remoteConfig.configValue(forKey: variable.rawValue).numberValue.intValue
    }
    
    func doubleValue(for variable: Variable) -> Double {
        remoteConfig.configValue(forKey: variable.rawValue).numberValue.doubleValue
    }
}
