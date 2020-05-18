import Foundation
import UIKit
import MBProgressHUD

private struct Constants {
    static let defaultCornerRadius: CGFloat = 10.0
    static let defaultborderWidth: CGFloat = 2.0
}

class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol! {
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
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
        setupListNavigationBar()
        presenter.handleViewDidLoad()
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
    }
    @IBAction func logOutTapped(_ sender: Any) {
        presenter.handleLogOutTapped()
    }
    private func setUpView() {

    }
    
    private func setBordered(for button: UIButton) {
        button.layer.cornerRadius = Constants.defaultCornerRadius
        button.layer.borderWidth = Constants.defaultborderWidth
        button.layer.borderColor = appearanceConfig.colors.loginBorderColor.cgColor
    }
    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.settings
        navigationController?.navigationBar.isTranslucent = true
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setEmail(_ email: String) {
        self.email.text = email
    }
}
