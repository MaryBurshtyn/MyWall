import Foundation
//import FirebaseFunctions
import FirebaseAuth
import FirebaseFirestore

class FirebaseErrorParser {
    private enum Constants {
        static let noConnectionErrorCode = -1009
    }
    
    private var invalidUserErrorObserverBlock: (() -> Void)?
    
    func parseFirestoreError(_ error: Error) -> CommonError {
        guard let error = error as NSError?,
            let firestoreError = FirestoreErrorCode(rawValue: error.code) else {
                return .serverCommunicationError(.unknown)
        }
        switch firestoreError {
        case .deadlineExceeded, .unavailable:
            return .serverCommunicationError(.noConnection)
        case .permissionDenied, .unauthenticated:
            invalidUserErrorObserverBlock?()
            return .serverCommunicationError(.invalidUser)
        default:
            return .serverCommunicationError(.unknown)
        }
    }
    
//    func parseFunctionsError(_ error: Error) -> CommonError {
//        guard let error = error as NSError?,
//            let functionsError = FunctionsErrorCode(rawValue: error.code) else {
//                return .serverCommunicationError(.unknown)
//        }
//        switch functionsError {
//        case .deadlineExceeded, .unavailable:
//            return .serverCommunicationError(.noConnection)
//        case .permissionDenied, .unauthenticated:
//            invalidUserErrorObserverBlock?()
//            return .serverCommunicationError(.invalidUser)
//        default:
//            if error.code == Constants.noConnectionErrorCode {
//                return .serverCommunicationError(.noConnection)
//            }
//            return .serverCommunicationError(.unknown)
//        }
//    }
    
    func parseAuthError(_ error: Error) -> CommonError {
        guard let error = error as NSError?,
            let authError = AuthErrorCode(rawValue: error.code) else {
                return .serverCommunicationError(.unknown)
        }
        switch authError {
        case .networkError:
            return .serverCommunicationError(.noConnection)
        case .invalidCustomToken,
             .invalidUserToken,
             .userDisabled,
             .operationNotAllowed,
             .userNotFound,
             .userTokenExpired:
            invalidUserErrorObserverBlock?()
            return .serverCommunicationError(.invalidUser)
        default:
            return .serverCommunicationError(.unknown)
        }
    }
    
    func setInvalidUserErrorObserverBlock(_ block: @escaping (() -> Void)) {
        invalidUserErrorObserverBlock = block
    }
}
