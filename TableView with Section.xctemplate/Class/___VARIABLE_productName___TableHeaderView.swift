//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_productName___TableHeaderView: UITableViewHeaderFooterView, CellIdentifiable {
    
    typealias Item = ___VARIABLE_productName___Section
    
    static let height: CGFloat = 45
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Configure
    
    func configure(with item: Item) {
        sampleLabel.text = "Section for value \(item.value)"
    }
}
