import Foundation
class CostPresenter {

    unowned var view: CostViewProtocol
    unowned var navigator: SceneNavigatorProtocol
    //var costs = [Cost]()
    var costs = [Cost(category: CostCategory.beauty, date: Date(), cost: "15", currency: "BYN"),
                 Cost(category: CostCategory.carService, date: Date(), cost: "50", currency: "BYN"),
                 Cost(category: CostCategory.eatOuts, date: Date(), cost: "10", currency: "BYN"),
                 Cost(category: CostCategory.fuel, date: Date(), cost: "30", currency: "BYN"),
                 Cost(category: CostCategory.insurance, date: Date(), cost: "15", currency: "BYN"),
                 Cost(category: CostCategory.sport, date: Date(), cost: "15", currency: "BYN")]
    
    init(view: CostViewProtocol,
         navigator: SceneNavigatorProtocol) {
        
        self.view = view
        self.navigator = navigator
    }
}

// MARK: - SplashPresenterProtocol

extension CostPresenter: CostPresenterProtocol {
    func handleViewDidLoad() {
        view.setCosts(costs: costs)
    }
}
