import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: HomePresenterProtocol! {
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

extension HomeViewController: HomeViewProtocol {
}
