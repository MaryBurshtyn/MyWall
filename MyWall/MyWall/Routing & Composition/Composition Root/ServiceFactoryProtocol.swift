import Foundation

protocol ServiceFactoryProtocol {
    func getUserDefaultsService() -> UserDefaultsServiceProtocol
}
