//
//  UserDefaultsService.swift
//  OnlineCheckInApp
//
//  Created on 11/04/2019

import Foundation

class UserDefaultsService: UserDefaultsServiceProtocol {

    private let userDefaults: UserDefaults

    private enum UserDefaultsKeys {
        static let selectedLocationIdKey = "UserDefaultsServiceSelectedLocationId"
        static let acceptAgreementsStateKey = "UserDefaultsServiceAcceptAgreementsState"
        static let userNameKey = "name"
        static let userSurnameKey = "surname"
        static let userEmailKey = "email"
        static let userPhotoReferenceKey = "photoReference"
        static let localNotificationsKey = "localNotificationsKey"
        static let remoteNotificationsKey = "remoteNotificationsKey"
        static let firstLaunchApplicationKey = "firstLaunchApplicationKey"
        static let itransitionDomainKey = "itransition.com"
    }

    // MARK: - Init & deinit

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    // MARK: - UserDefaultsServiceProtocol

    func setAcceptAgreementsState(_ acceptedState: Bool) {
        userDefaults.set(acceptedState, forKey: UserDefaultsKeys.acceptAgreementsStateKey)
    }

    func getAcceptAgreementsState() -> Bool {
        return userDefaults.bool(forKey: UserDefaultsKeys.acceptAgreementsStateKey)
    }

    func setSelectedLocationId(_ locationId: String?) {
        userDefaults.set(locationId, forKey: UserDefaultsKeys.selectedLocationIdKey)
    }

    func getSelectedLocationId() -> String? {
        return userDefaults.string(forKey: UserDefaultsKeys.selectedLocationIdKey)
    }

    func setUserData(name: String, surname: String, email: String, photoReference: String) {
        userDefaults.set(name, forKey: UserDefaultsKeys.userNameKey)
        userDefaults.set(surname, forKey: UserDefaultsKeys.userSurnameKey)
        userDefaults.set(email, forKey: UserDefaultsKeys.userEmailKey)
        userDefaults.set(photoReference, forKey: UserDefaultsKeys.userPhotoReferenceKey)
    }

    func getUserName() -> String? {
        return userDefaults.string(forKey: UserDefaultsKeys.userNameKey)
    }

    func getUserSurname() -> String? {
        return userDefaults.string(forKey: UserDefaultsKeys.userSurnameKey)
    }

    func getUserEmail() -> String? {
        return userDefaults.string(forKey: UserDefaultsKeys.userEmailKey)
    }

    func getUserPhotoReference() -> String? {
        return userDefaults.string(forKey: UserDefaultsKeys.userPhotoReferenceKey)
    }

    func deleteUserData() {
        userDefaults.removeObject(forKey: UserDefaultsKeys.userNameKey)
        userDefaults.removeObject(forKey: UserDefaultsKeys.userSurnameKey)
        userDefaults.removeObject(forKey: UserDefaultsKeys.userEmailKey)
        userDefaults.removeObject(forKey: UserDefaultsKeys.userPhotoReferenceKey)
    }

    func activityNotifications(isAllowed: Bool) {
        userDefaults.set(isAllowed, forKey: UserDefaultsKeys.localNotificationsKey)
    }

    func newEventsNotifications(isAllowed: Bool) {
        userDefaults.set(isAllowed, forKey: UserDefaultsKeys.remoteNotificationsKey)
    }

    func isActivityNotificationsAllowed() -> Bool {
        return userDefaults.bool(forKey: UserDefaultsKeys.localNotificationsKey)
    }

    func isNewEventsNotificationsAllowed() -> Bool {
        return userDefaults.bool(forKey: UserDefaultsKeys.remoteNotificationsKey)
    }

    func makeFirstApplicationLaunch() {
        userDefaults.set(true, forKey: UserDefaultsKeys.firstLaunchApplicationKey)
    }

    func isNotFirstLaunchApplication() -> Bool {
        return userDefaults.bool(forKey: UserDefaultsKeys.firstLaunchApplicationKey)
    }

    func isItransitionAccount() -> Bool {
        return getUserEmail()?.contains(UserDefaultsKeys.itransitionDomainKey) ?? false
    }
}
