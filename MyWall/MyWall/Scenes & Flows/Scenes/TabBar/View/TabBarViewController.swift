import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - MVP Infractructure
    
    var presenter: TabBarPresenterProtocol! {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self
        setUpTabBarAppearance()
        presenter.handleViewWillAppear()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func setUpTabBarAppearance() {
        self.tabBar.barTintColor = appearanceConfig.colors.tabBarTintColor
        UITabBarItem.appearance().setTitleTextAttributes(
                                    [NSAttributedString.Key.foregroundColor: appearanceConfig.colors.tabBarUnselectedText],
                                    for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
                                    [NSAttributedString.Key.foregroundColor: appearanceConfig.colors.tabBarSelectedText],
                                    for: .selected)
    }
    
    func setupViewControllers(home homeViewController: HomeViewController,
                              cost costViewController: CostViewController,
                              income incomeViewController: IncomeViewController) {
        let menuHome = wrapController(homeViewController,
                                      title: L10n.home,
                                      image: #imageLiteral(resourceName: "ic_home"))
        let cost = wrapController(costViewController,
                                  title: L10n.costs,
                                      image: #imageLiteral(resourceName: "ic_home"))
        let income = wrapController(incomeViewController,
                                    title: L10n.incomes,
                                  image: #imageLiteral(resourceName: "ic_home"))
        viewControllers = [menuHome, cost, income]
    }
    
    // MARK: - Make Controllers
    
    private func wrapController(_ controller: UIViewController,
                                title: String,
                                image: UIImage? = nil,
                                selectedImage: UIImage? = nil) -> UINavigationController {
        let navigationController = UINavigationController(navigationBarClass: ShadowNavigationBar.self,
                                                          rootViewController: controller,
                                                          appearanceConfig: appearanceConfig)
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        return navigationController
    }
}

// MARK: - View Protocol

extension TabBarViewController: TabBarViewControllerProtocol {
    func showOkAlert(title: String, message: String) {
        //showOKAlert(title: title, message: message)
    }
    
    func getCurrentTabBarItem() -> TabBarItemType {
        guard let tabBarItemType = TabBarItemType(rawValue: self.selectedIndex) else {
            return TabBarItemType.home
        }
        return tabBarItemType
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
//        if tabBarController.selectedIndex != TabBarItemType.notifications.rawValue {
//            NotificationCenter.default.post(name: .DeselectNotificationsTab, object: nil)
//        } else {
//            NotificationCenter.default.post(name: .SelectNotificationsTab, object: nil)
//        }
    }
}
