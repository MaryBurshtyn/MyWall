import Foundation

enum CommonError: Error {
    case serverCommunicationError(ServerCommunicationError)
    case serverBusinessError(String)
    case appError(AppError)
}

enum ServerCommunicationError: Error {
    case noConnection
    case invalidUser
    case unknown
}

enum AppError: Error {
    case parsingFailure(String)
    case invalidData
    case cancelled
}
