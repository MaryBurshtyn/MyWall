import Foundation

class HomePresenter {

    unowned var view: HomeViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    
    init(view: HomeViewProtocol,
         navigator: SceneNavigatorProtocol) {
        
        self.view = view
        self.navigator = navigator
    }
}

// MARK: - SplashPresenterProtocol

extension HomePresenter: HomePresenterProtocol {

    func handleViewDidAppear() {
    }
}
