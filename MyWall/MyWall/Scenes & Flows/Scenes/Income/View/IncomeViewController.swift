import Foundation
import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: IncomePresenterProtocol! {
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

extension IncomeViewController: IncomeViewProtocol {
}
