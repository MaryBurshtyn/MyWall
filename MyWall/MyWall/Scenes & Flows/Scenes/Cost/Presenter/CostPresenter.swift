import Foundation
class CostPresenter {

    unowned var view: CostViewProtocol
    unowned var navigator: SceneNavigatorProtocol

    init(view: CostViewProtocol,
         navigator: SceneNavigatorProtocol) {
        
        self.view = view
        self.navigator = navigator
    }
}

// MARK: - SplashPresenterProtocol

extension CostPresenter: CostPresenterProtocol {
}
