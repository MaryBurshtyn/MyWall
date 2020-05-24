import Foundation
import UIKit
import MBProgressHUD

private struct Constants {
    static let tableSectionHeaderFontSize: CGFloat = 15
    static let tableSectionHeaderViewInsetX: CGFloat = 10
    static let tableSectionHeaderViewInsetY: CGFloat = 0
}

class CostViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: CostPresenterProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    var appearanceConfig: AppearanceConfigProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("AppearanceConfig can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var costs = [(key: String, value: [CostDB])]()
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerEventCell()
        setupListNavigationBar()
        presenter.handleViewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ic_background"))
        //tableView.backgroundColor = appearanceConfig.colors.dateBackgroundColor
    }

    private func registerEventCell() {
        let nib = UINib(nibName: "CostTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "CostTableViewCell")
    }

    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.costs
        //navigationController?.navigationBar.isTranslucent = true

        navigationItem.rightBarButtonItem = (UIBarButtonItem(
            image: #imageLiteral(resourceName: "add2"),
            style: .plain,
            target: self,
            action: #selector(handleRightNavigationItemTapped))
        )
    }

    @objc
    private func handleRightNavigationItemTapped() {
        presenter.handleAddButtonTapped()
    }
    
}

extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return costs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costs[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as? CostTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(data: costs[indexPath.section].value[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = LabelWithInsets(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                    insetX: Constants.tableSectionHeaderViewInsetX,
                                    insetY: Constants.tableSectionHeaderViewInsetY)
        label.textColor = UIColor(patternImage: #imageLiteral(resourceName: "notificationTextGradient"))
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: Constants.tableSectionHeaderFontSize, weight: .medium)
        label.text = costs[section].key
        return label
    }
}

extension CostViewController: CostViewProtocol {
    func openExpensesDialog() {
        guard let costAlert = self.storyboard?.instantiateViewController(withIdentifier: "AddCostAlertView") as? AddCostAlertView else {
            return
        }
        costAlert.providesPresentationContextTransitionStyle = true
        costAlert.definesPresentationContext = true
        costAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        costAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        costAlert.delegate = self
        self.present(costAlert, animated: true, completion: nil)
    }
    
    func setCosts(costs: [(key: String, value: [CostDB])]) {
        self.costs = costs
        tableView.reloadData()
    }
    
    func showPreloader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hidePreloader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

extension CostViewController: AddCostAlertViewDelegate {
    func okButtonTapped(costs: [CostDB]) {
        presenter.handleUpdateExpensesList(expenses: costs)
    }    
}
