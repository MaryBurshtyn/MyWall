import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    var presenter: SplashPresenterProtocol! {
        didSet {
            guard oldValue == nil else {
                fatalError("Presenter can be set only once -- during assembling \(self.description)")
            }
        }
    }
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.handleViewDidAppear()
    }
}

extension SplashViewController: SplashViewProtocol {
}
