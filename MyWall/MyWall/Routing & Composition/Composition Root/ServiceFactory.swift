import Foundation
import UserNotifications

class ServiceFactory: ServiceFactoryProtocol {
    
    //private let api: ApiProtocol
    private let bundle: Bundle
    private let userDefaultsService: UserDefaultsServiceProtocol
    private let dataManagerService: DataManagerServiceProtocol
    
    init(//api: ApiProtocol,
         userDafaults: UserDefaults,
         bundle: Bundle
    ) {
        //self.api = api
        self.bundle = bundle
        self.userDefaultsService = UserDefaultsService(userDefaults: userDafaults)
        self.dataManagerService = DataManagerService()
    }

    func getUserDefaultsService() -> UserDefaultsServiceProtocol {
        return userDefaultsService
    }
    
    func getDataManagerService() -> DataManagerServiceProtocol {
        return dataManagerService
    }

}
