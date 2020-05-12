import Foundation
import UIKit

class CostViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: CostPresenterProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var costs = [CostDB]()
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerEventCell()
        setupListNavigationBar()
        presenter.handleViewDidLoad()
    }

    private func registerEventCell() {
        let nib = UINib(nibName: "CostTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "CostTableViewCell")
    }

    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.costs
        navigationController?.navigationBar.isTranslucent = true

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CostTableViewCell", for: indexPath) as? CostTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(data: costs[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
    
    func setCosts(costs: [CostDB]) {
        self.costs = costs
        tableView.reloadData()
    }
}

extension CostViewController: AddCostAlertViewDelegate {
    func okButtonTapped(costs: [CostDB]) {
        presenter.handleUpdateExpensesList(expenses: costs)
        self.costs.append(contentsOf: costs)
        self.tableView.reloadData()
    }    
}
