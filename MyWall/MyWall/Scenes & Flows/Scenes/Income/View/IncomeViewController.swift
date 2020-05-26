import Foundation
import UIKit
import MBProgressHUD

private struct Constants {
    static let tableSectionHeaderFontSize: CGFloat = 15
    static let tableSectionHeaderViewInsetX: CGFloat = 10
    static let tableSectionHeaderViewInsetY: CGFloat = 0
}

class IncomeViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: IncomePresenterProtocol! {
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
    var incomes = [(key: String, value: [IncomeDB])]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerEventCell()
        setupListNavigationBar()
        presenter.handleViewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "ic_background"))
        //tableView.backgroundColor = appearanceConfig.colors.dateBackgroundColor
    }

    private func registerEventCell() {
        let nib = UINib(nibName: "IncomeTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "IncomeTableViewCell")
    }

    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.incomes

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

extension IncomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return incomes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomes[section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell", for: indexPath) as? IncomeTableViewCell else {
                return UITableViewCell()
        }
        cell.configureCell(data: incomes[indexPath.section].value[indexPath.row])
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
        label.text = incomes[section].key
        return label
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        let deleted = incomes[indexPath.section].value[indexPath.row]
        incomes[indexPath.section].value.remove(at: indexPath.row)
        presenter.handleDeleteIncome(deleted)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}

extension IncomeViewController: IncomeViewProtocol {
    func setIncomes(incomes: [(key: String, value: [IncomeDB])]) {
        self.incomes = incomes
        self.tableView.reloadData()
    }
    
    func openIncomesDialog() {
        guard let incomeAlert = self.storyboard?.instantiateViewController(withIdentifier: "AddIncomeAlertView") as? AddIncomeAlertView else {
            return
        }
        incomeAlert.providesPresentationContextTransitionStyle = true
        incomeAlert.definesPresentationContext = true
        incomeAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        incomeAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        incomeAlert.delegate = self
        self.present(incomeAlert, animated: true, completion: nil)
    }
    
    func showPreloader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hidePreloader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}

extension IncomeViewController: AddIncomeAlertViewDelegate {
    func okButtonTapped(incomes: [IncomeDB]) {
        presenter.handleUpdateIncomeList(incomes: incomes)
    }
}
