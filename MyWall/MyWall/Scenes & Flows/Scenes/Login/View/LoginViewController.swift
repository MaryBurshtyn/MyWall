import Foundation
import UIKit
import MBProgressHUD

private struct Constants {
    static let defaultCornerRadius: CGFloat = 10.0
    static let defaultborderWidth: CGFloat = 2.0
}

class LoginViewController: UIViewController {
    
    // MARK: - MVP Infractructure
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var presenter: LoginPresenterProtocol! {
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
    
    // MARK: - Init & Setup

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        handleLoginButtonTapped()
    }
    @IBAction func registerTapped(_ sender: Any) {
        handleRegisterButtonTapped()
    }
    
    private func setUpView() {
        registerButton.backgroundColor = .clear
        loginButton.backgroundColor = .clear
        setBordered(for: registerButton)
        setBordered(for: loginButton)
    }
    
    private func setBordered(for button: UIButton) {
        button.layer.cornerRadius = Constants.defaultCornerRadius
        button.layer.borderWidth = Constants.defaultborderWidth
        button.layer.borderColor = appearanceConfig.colors.loginBorderColor.cgColor
    }
}

extension LoginViewController: LoginViewProtocol {
    func showPreloader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hidePreloader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func handleViewDidLoad() {
        
    }
    
    func handleRegisterButtonTapped() {
        guard let email = emailTextField.text,
            let pass = passwordTextField.text else {
            return
        }
        presenter.register(email: email, password: pass)
    }
    
    func handleLoginButtonTapped() {
        guard let email = emailTextField.text,
            let pass = passwordTextField.text else {
            return
        }
        presenter.doLogin(email: email, password: pass)
    }
    
    
}
