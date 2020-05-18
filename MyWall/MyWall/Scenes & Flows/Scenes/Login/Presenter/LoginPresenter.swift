import Foundation

class LoginPresenter {

    unowned var view: LoginViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    unowned var api: ApiProtocol
    
    init(view: LoginViewProtocol,
         navigator: SceneNavigatorProtocol,
         api: ApiProtocol) {
        
        self.view = view
        self.navigator = navigator
        self.api = api
    }
}

// MARK: - SplashPresenterProtocol

extension LoginPresenter: LoginPresenterProtocol {
    func doLogin(email: String, password: String) {
        view.showPreloader()
        api.login(userEmail: email, password: password, completion: {[weak self] result in
            switch result {
            case .success():
                self?.view.hidePreloader()
                self?.navigator.navigateTo(.tabBar, transitionType: .root)
            case .failure(let error):
                log.error(error)
            }
        })
    }
    
    func register(email: String, password: String) {
        view.showPreloader()
        api.register(userEmail: email, password: password, completion: { [weak self] result in
            switch result {
            case .success():
                self?.view.hidePreloader()
                self?.navigator.navigateTo(.tabBar, transitionType: .root)
            case .failure(let error):
                log.error(error)
            }
        })
    }
    

}
