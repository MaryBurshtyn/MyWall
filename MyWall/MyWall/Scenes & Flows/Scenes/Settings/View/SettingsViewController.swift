import Foundation
import UIKit
import MBProgressHUD

private struct Constants {
    static let defaultCornerRadius: CGFloat = 10.0
    static let defaultborderWidth: CGFloat = 2.0
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
      
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
    @IBOutlet weak var defaultCurrency: UILabel!
    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var logOut: UIButton!
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
        defaultCurrency.text = L10n.defCurrency
        defaultCurrency.font = UIFont(font: FontFamily.Montserrat.semiBold, size: 18)
        email.text = L10n.email
        changePassword.setTitle(L10n.changePassword, for: .normal)
        logOut.setTitle(L10n.logOut, for: .normal)
    }
    
    private func setBordered(for button: UIButton) {
        button.layer.cornerRadius = Constants.defaultCornerRadius
        button.layer.borderWidth = Constants.defaultborderWidth
        button.layer.borderColor = appearanceConfig.colors.loginBorderColor.cgColor
    }
    
    private func setupListNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = L10n.settings
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
           var pickerLabel: UILabel? = (view as? UILabel)
           if pickerLabel == nil {
               pickerLabel = UILabel()
               pickerLabel?.font = UIFont(font: FontFamily.Montserrat.semiBold, size: 14)
               pickerLabel?.textColor = appearanceConfig.colors.appTintColor
               pickerLabel?.textAlignment = .center
           }
           pickerLabel?.text = Currency.init(rawValue: row)?.stringValue

           return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(Currency.init(rawValue: row)?.stringValue, forKey: AppConstants.defCurrency)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func setEmail(_ email: String) {
        self.email.text = email
    }
}
