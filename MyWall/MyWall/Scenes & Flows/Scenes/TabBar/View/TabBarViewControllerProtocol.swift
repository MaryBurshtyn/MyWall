import Foundation

protocol TabBarViewControllerProtocol: class {
    func showOkAlert(title: String, message: String)
    func getCurrentTabBarItem() -> TabBarItemType
}
