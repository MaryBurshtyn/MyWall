import UIKit

extension SceneFactory {
    //swiftlint:disable function_parameter_count
    internal static func makeTabBar(navigator: SceneNavigatorProtocol,
                                    menuHomeView: HomeViewController,
                                    costView: CostViewController,
                                    incomeView: IncomeViewController,
                                    appearenceConfig: AppearanceConfigProtocol) -> UIViewController {
        
        let tabController: TabBarViewController = TabBarViewController.storyboardInstance()
        tabController.loadViewIfNeeded()
        tabController.appearanceConfig = appearenceConfig
        tabController.setupViewControllers(home: menuHomeView, cost: costView, income: incomeView)
        let presenter = TabBarPresenter(view: tabController,
                                        navigator: navigator)
        tabController.presenter = presenter
        
        return tabController
    }
}
