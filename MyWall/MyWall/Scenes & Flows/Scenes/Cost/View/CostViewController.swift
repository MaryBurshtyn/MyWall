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
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension CostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension CostViewController: CostViewProtocol {
}
