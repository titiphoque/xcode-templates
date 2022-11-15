//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_productName___TableViewCell: UITableViewCell, CellIdentifiable {

    typealias Item = FeatureCellItem
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Configure
    
    func configure(with item: Item) {
        sampleLabel.text = "\(item.value) - \(item.uid)"
    }
}
