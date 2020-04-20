import Foundation

class SplashPresenter {

    unowned var view: SplashViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    
    init(view: SplashViewProtocol,
         navigator: SceneNavigatorProtocol) {
        
        self.view = view
        self.navigator = navigator
    }
}

// MARK: - SplashPresenterProtocol

extension SplashPresenter: SplashPresenterProtocol {

    func handleViewDidAppear() {
    }
}
