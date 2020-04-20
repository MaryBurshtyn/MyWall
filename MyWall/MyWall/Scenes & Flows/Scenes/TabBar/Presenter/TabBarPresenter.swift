import Foundation

class TabBarPresenter {
    
    private weak var view: TabBarViewControllerProtocol?
    private weak var navigator: SceneNavigatorProtocol?
    init(view: TabBarViewControllerProtocol,
         navigator: SceneNavigatorProtocol) {
        self.view = view
        self.navigator = navigator
    }
}

// MARK: - Presenter Protocol

extension TabBarPresenter: TabBarPresenterProtocol {
    func handleViewWillAppear() {
    }
}
