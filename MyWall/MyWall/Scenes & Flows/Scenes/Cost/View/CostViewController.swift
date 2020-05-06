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
    var costs = [Cost]()
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerEventCell()
        presenter.handleViewDidLoad()
    }
    
    private func registerEventCell() {
           let nib = UINib(nibName: "CostTableViewCell", bundle: Bundle.main)
           tableView.register(nib, forCellReuseIdentifier: "CostTableViewCell")
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
    
    
}

extension CostViewController: CostViewProtocol {
    func setCosts(costs: [Cost]) {
        self.costs = costs
        tableView.reloadData()
    }
}
