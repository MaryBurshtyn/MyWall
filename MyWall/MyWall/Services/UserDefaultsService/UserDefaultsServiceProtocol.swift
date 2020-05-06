import Foundation

protocol UserDefaultsServiceProtocol {
    func setSelectedLocationId(_ locationId: String?)
    func getSelectedLocationId() -> String?
    func setAcceptAgreementsState(_ acceptedState: Bool)
    func getAcceptAgreementsState() -> Bool
    func setUserData(name: String, surname: String, email: String, photoReference: String)
    func getUserName() -> String?
    func getUserSurname() -> String?
    func getUserEmail() -> String?
    func getUserPhotoReference() -> String?
    func deleteUserData()
    func isActivityNotificationsAllowed() -> Bool
    func isNewEventsNotificationsAllowed() -> Bool
    func activityNotifications(isAllowed: Bool)
    func newEventsNotifications(isAllowed: Bool)
    func makeFirstApplicationLaunch()
    func isNotFirstLaunchApplication() -> Bool
    func isItransitionAccount() -> Bool
}
