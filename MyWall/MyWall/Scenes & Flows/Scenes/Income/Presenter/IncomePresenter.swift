import Foundation
class IncomePresenter {

    unowned var view: IncomeViewProtocol
    unowned var navigator: SceneNavigatorProtocol

    init(view: IncomeViewProtocol,
         navigator: SceneNavigatorProtocol) {
        
        self.view = view
        self.navigator = navigator
    }
}

// MARK: - SplashPresenterProtocol

extension IncomePresenter: IncomePresenterProtocol {
}
