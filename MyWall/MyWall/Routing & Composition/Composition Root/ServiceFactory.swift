import Foundation
import UserNotifications

class ServiceFactory: ServiceFactoryProtocol {
    
    private let bundle: Bundle
    private let dataManagerService: DataManagerServiceProtocol
    private let firebaseService: ApiProtocol
    private let currencyService: CurrencyServiceProtocol
    
    init(
         userDafaults: UserDefaults,
         bundle: Bundle
    ) {
        self.bundle = bundle
        self.firebaseService = FirebaseApiService()
        self.currencyService = CurrencyService()
        self.dataManagerService = DataManagerService(currencyService: currencyService)
        //currencyService.makeRequest()
    }
    
    func getDataManagerService() -> DataManagerServiceProtocol {
        return dataManagerService
    }
    
    func getFirebaseService() -> ApiProtocol {
        return firebaseService
    }
    func getCurrencyService() -> CurrencyServiceProtocol {
        return currencyService
    }
}
