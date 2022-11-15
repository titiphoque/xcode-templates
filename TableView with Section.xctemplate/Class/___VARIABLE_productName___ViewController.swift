//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
import Combine

class FeatureSection: Hashable {
    let value: Int
    let items: [FeatureCellItem]
    
    init(value: Int, items: [FeatureCellItem]) {
        self.value = value
        self.items = items
    }
    
    var id: String {
        items
            .compactMap { "\($0.uid)" }
            .joined(separator: "_")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: FeatureSection, rhs: FeatureSection) -> Bool {
        lhs.id == rhs.id
    }
}

class FeatureCellItem: Hashable {
    let uid: Int
    let value: Int
    
    init(uid: Int, value: Int) {
        self.uid = uid
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
    static func ==(lhs: FeatureCellItem, rhs: FeatureCellItem) -> Bool {
        return lhs.uid == rhs.uid
    }
}

class ___VARIABLE_productName___ViewController: UIViewController {
    
    enum State {
        case loading
        case `default`([FeatureSection])
        case error(Error)
    }

    // MARK: - IBOutlets
    
    @IBOutlet var defaultView: UIView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var errorView: UIView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(___VARIABLE_productName___TableViewCell.nib,
                               forCellReuseIdentifier: ___VARIABLE_productName___TableViewCell.identifier)
            tableView.register(___VARIABLE_productName___TableHeaderView.nib,
                               forHeaderFooterViewReuseIdentifier: ___VARIABLE_productName___TableHeaderView.identifier)
            
            tableView.backgroundColor = .clear
            tableView.dataSource = dataSource
            tableView.delegate = self
            
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 40
            
            if #available(iOS 15.0, *) {
                tableView.sectionHeaderTopPadding = 0
            }
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshControllerTriggered), for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    private lazy var viewModel = ___VARIABLE_productName___ViewModel()
    
    private lazy var dataSource: UITableViewDiffableDataSource<FeatureSection, FeatureCellItem> = {
        let dataSource = UITableViewDiffableDataSource<FeatureSection, FeatureCellItem>(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ___VARIABLE_productName___TableViewCell.identifier, for: indexPath) as! ___VARIABLE_productName___TableViewCell
            cell.configure(with: item)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        
        return dataSource
    }()
    @Published private var sections = [FeatureSection]()
    
    // MARK: - Life cycle
    
    var cellItems = [FeatureCellItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerToViewModelState()
        
        viewModel.getData()
    }
    
    // MARK: - State Management
    
    private func registerToViewModelState() {
        viewModel.$state
            .sink { [weak self] newState in
                guard let self = self else { return }
                
                switch newState {
                case .loading:
                    self.setupStateLoading()
                    
                case .default(let sections):
                    self.setupStateDefault(sections: sections)
                    
                case .error(let error):
                    self.setupStateError(error: error)
                }
                
                self.tableView.refreshControl?.endRefreshing()
            }
            .store(in: &cancellables)
        
        
        $sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newSections in
                guard let self = self else { return }
                
                var snapshot = NSDiffableDataSourceSnapshot<FeatureSection, FeatureCellItem>()
                snapshot.appendSections(newSections)
                newSections.forEach { section in
                    snapshot.appendItems(section.items, toSection: section)
                }
                
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &cancellables)
    }
    
    private func setupStateLoading() {
        debugPrint("[State] Setup state loading")
        transitionView(to: loadingView)
    }
    
    private func setupStateError(error: Error) {
        debugPrint("[State] Setup state error with : \(error.localizedDescription)")
        transitionView(to: errorView)
    }
    
    private func setupStateDefault(sections: [FeatureSection]) {
        debugPrint("[State] Setup state default")
        self.sections = sections.sorted(by: { lhs, rhs in
            lhs.value < rhs.value
        })
        
        transitionView(to: defaultView)
    }
    
    private func transitionView(to newView: UIView) {
        UIView.transition(with: view,
                          duration: 0.3,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: { [weak self] in
            guard let self = self else { return }
            self.view.subviews.forEach { $0.removeFromSuperview() }
            self.view.addSubview(newView)
            
            newView.translatesAutoresizingMaskIntoConstraints = false
            let views: [String: UIView] = ["subview": newView]
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|",
                                                                     options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                     metrics: nil,
                                                                     views: views)
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|",
                                                                       options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                       metrics: nil,
                                                                       views: views)
            self.view.addConstraints(verticalConstraints)
            self.view.addConstraints(horizontalConstraints)
        },
                          completion: nil)
    }
    
    // MARK: - Error actions
    
    @IBAction func errorStateRetryButtonTapped(_ sender: Any) {
        viewModel.getData()
    }
    
    // MARK: - Refresh Control
    
    @objc private func refreshControllerTriggered() {
        viewModel.pullToRefresh()
    }
}

// MARK: - UITableViewDelegate

extension ___VARIABLE_productName___ViewController: UITableViewDelegate {
    
    // MARK: - Did select row
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        debugPrint("Did select item with uid: \(item.uid)")
    }
    
    // MARK: - Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ___VARIABLE_productName___TableHeaderView.identifier) as! ___VARIABLE_productName___TableHeaderView
        
        let sectionItem = sections[section]
        headerView.configure(with: sectionItem)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        ___VARIABLE_productName___TableHeaderView.height
    }
}
