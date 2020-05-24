import Foundation

class ShopListPresenter {

    unowned var view: ShopListViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    var dataManagerService: DataManagerServiceProtocol
    

    init(view: ShopListViewProtocol,
         navigator: SceneNavigatorProtocol,
         dataManagerService: DataManagerServiceProtocol) {
        self.view = view
        self.navigator = navigator
        self.dataManagerService = dataManagerService
    }

}
extension ShopListPresenter: ShopListPresenterProtocol {
    func handleViewDidLoad() {
        
    }
    
    
}
