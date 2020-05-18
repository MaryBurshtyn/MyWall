import Foundation

protocol LoginPresenterProtocol: class {

    func doLogin(email: String, password: String)
    func register(email: String, password: String)
}
