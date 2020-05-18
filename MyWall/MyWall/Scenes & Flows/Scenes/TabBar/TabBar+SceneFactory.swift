import UIKit

extension SceneFactory {
    //swiftlint:disable function_parameter_count
    internal static func makeTabBar(navigator: SceneNavigatorProtocol,
                                    costView: CostViewController,
                                    incomeView: IncomeViewController,
                                    settings: SettingsViewController,
                                    graphics: GraphicsViewController,
                                    appearenceConfig: AppearanceConfigProtocol) -> UIViewController {
        
        let tabController: TabBarViewController = TabBarViewController.storyboardInstance()
        tabController.loadViewIfNeeded()
        tabController.appearanceConfig = appearenceConfig
        tabController.setupViewControllers(cost: costView, income: incomeView, settings: settings, graphics: graphics)
        let presenter = TabBarPresenter(view: tabController,
                                        navigator: navigator)
        tabController.presenter = presenter
        
        return tabController
    }
}
