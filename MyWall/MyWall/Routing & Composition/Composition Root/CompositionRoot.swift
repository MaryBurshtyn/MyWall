import UIKit
import Reachability
class CompositionRoot {
    weak var navigator: SceneNavigatorProtocol!
    
    private let serviceFactory: ServiceFactoryProtocol
    private let appearanceConfig: AppearanceConfig
    private let userDefaultsService: UserDefaultsServiceProtocol
    private let dataManagerService: DataManagerServiceProtocol
    private let reachability: Reachability?
    //private let api: ApiProtocol

    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
        appearanceConfig = AppearanceConfig()
        //api = FirestoreApi()
        dataManagerService = serviceFactory.getDataManagerService()
        userDefaultsService = serviceFactory.getUserDefaultsService()
        self.reachability = try? Reachability()
    }
    
    func startServices() {
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
            return SceneFactory.makeCostModule(navigator: navigator, dataManagerService: dataManagerService, reachability: reachability)
        case .income:
            return SceneFactory.makeIncomeModule(navigator: navigator)
        }
    }

    func getAppearanceConfig() -> AppearanceConfigProtocol {
        return appearanceConfig
    }

    func getUserDefaultsService() -> UserDefaultsServiceProtocol {
        return userDefaultsService
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
            let home: HomeViewController = composeScene(.home)
            let cost: CostViewController = composeScene(.cost)
            let income: IncomeViewController = composeScene(.income)
            return SceneFactory.makeTabBar(navigator: navigator, menuHomeView: home, costView: cost, incomeView: income, appearenceConfig: appearanceConfig)
        }
        
        
}
