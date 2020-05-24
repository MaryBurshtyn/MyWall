import UIKit
import Reachability
class CompositionRoot {
    weak var navigator: SceneNavigatorProtocol!
    
    private let serviceFactory: ServiceFactoryProtocol
    private let appearanceConfig: AppearanceConfig
    private let dataManagerService: DataManagerServiceProtocol
    private let currencyService: CurrencyServiceProtocol
    private let reachability: Reachability?
    private let api: ApiProtocol

    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
        appearanceConfig = AppearanceConfig()
        dataManagerService = serviceFactory.getDataManagerService()
        reachability = try? Reachability()
        api = serviceFactory.getFirebaseService()
        currencyService = serviceFactory.getCurrencyService()
    }
    
    func startServices() {
        appearanceConfig.setup()
    }
    
    func stopServices() {
    }
    
    //swiftlint:disable cyclomatic_complexity function_body_length

    func composeScene(_ scene: Scene) -> UIViewController {
        switch scene {
        case .home:
            return SceneFactory.makeHomeModule(navigator: navigator)
        case .splash:
            return SceneFactory.makeSplashModule(navigator: navigator)
        case .tabBar:
            return composeTabBarScene()
        case .cost:
            return SceneFactory.makeCostModule(navigator: navigator, dataManagerService: dataManagerService, reachability: reachability, api: api, appearenceConfig: appearanceConfig)
        case .income:
            return SceneFactory.makeIncomeModule(navigator: navigator, dataManagerService: dataManagerService, reachability: reachability, api: api, appearenceConfig: appearanceConfig)
        case .login:
            return SceneFactory.makeLoginModule(navigator: navigator, appearenceConfig: appearanceConfig, api: api)
        case .settings:
            return SceneFactory.makeSettingsModule(navigator: navigator, appearenceConfig: appearanceConfig, api: api)
        case .graphics:
            return SceneFactory.makeGraphicsModule(navigator: navigator, appearenceConfig: appearanceConfig, dataManager: dataManagerService, currencyService: currencyService)
        case .list:
            return SceneFactory.makeShopListModule(navigator: navigator, dataManagerService: dataManagerService, appearenceConfig: appearanceConfig)
        }
    }

    func getAppearanceConfig() -> AppearanceConfigProtocol {
        return appearanceConfig
    }
    
    func getFirebaseApiService() -> ApiProtocol {
        return api
    }

}
    
    // MARK: - Private Compose Scenes
    
extension CompositionRoot {
        private func composeScene<T: UIViewController>(_ scene: Scene) -> T {
            guard let sceneModule = composeScene(scene) as? T else {
                fatalError("Could not compose scene: \(scene)")
            }
            return sceneModule
        }
        
        private func composeTabBarScene() -> UIViewController {
            let cost: CostViewController = composeScene(.cost)
            let income: IncomeViewController = composeScene(.income)
            let settings: SettingsViewController = composeScene(.settings)
            let graphics: GraphicsViewController = composeScene(.graphics)
            let list: ShopListViewController = composeScene(.list)
            return SceneFactory.makeTabBar(navigator: navigator, costView: cost, incomeView: income, settings: settings, graphics: graphics, list: list, appearenceConfig: appearanceConfig)
        }
        
        
}
