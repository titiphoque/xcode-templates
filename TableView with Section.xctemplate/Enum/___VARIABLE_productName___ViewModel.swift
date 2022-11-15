//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
import Combine
import Foundation

class ___VARIABLE_productName___ViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var state: ___VARIABLE_productName___ViewController.State = .loading
    private var isPullToRefreshing = false
    
    func getData() {
        debugPrint("Get your data from remote server and then call sendData()")
        
        if isPullToRefreshing == false {
            state = .loading
        }
        
        Timer.publish(every: 2, on: RunLoop.main, in: RunLoop.Mode.default)
            .autoconnect()
            .prefix(1)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isPullToRefreshing = false
                self.sendData()
            }
            .store(in: &cancellables)
    }
    
    var callCount = 0
    func sendData() {
        guard callCount > 0 else {
            callCount += 1
            state = .error(NSError(domain: "CustomDomain", code: 1))
            return
        }
        
        debugPrint("Will retreive data from database or other local sources")
        
        // To be replace. Ex: let objects = realmManager.getEvents()
        func getObjects() -> [FeatureCellItem] {
            callCount += 1
            let objects: [FeatureCellItem] = {
                var arr = [FeatureCellItem]()
                for i in 0...(10 * callCount) {
                    arr.append(FeatureCellItem(uid: i, value: i % 4))
                }
                return arr
            }()
            return objects
        }
        
        let objects = getObjects()
        let groupedItems = Dictionary(grouping: objects) { obj -> Int in
            obj.value
        }
        
        var sections = [FeatureSection]()
        for (sectionValue, sectionItems) in groupedItems {
            sections.append(FeatureSection.objects(sectionValue, sectionItems))
        }
        
        state = .default(sections)
    }
    
    func pullToRefresh() {
        debugPrint("Pull to refresh triggered. Do some stuff if you need to (reset some values...)")
        isPullToRefreshing = true
        getData()
    }
}
