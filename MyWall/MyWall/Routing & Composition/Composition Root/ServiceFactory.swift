import Foundation
import UserNotifications

class ServiceFactory: ServiceFactoryProtocol {
    
    //private let api: ApiProtocol
    private let bundle: Bundle
    private let dataManagerService: DataManagerServiceProtocol
    private let firebaseService: ApiProtocol
    
    init(//api: ApiProtocol,
         userDafaults: UserDefaults,
         bundle: Bundle
    ) {
        //self.api = api
        self.bundle = bundle
        self.dataManagerService = DataManagerService()
        self.firebaseService = FirebaseApiService()
    }
    
    func getDataManagerService() -> DataManagerServiceProtocol {
        return dataManagerService
    }
    
    func getFirebaseService() -> ApiProtocol {
        return firebaseService
    }

}
