import Foundation
import FirebaseFirestore
import FirebaseAuth
import KeychainSwift

enum ChangeDocumentType {
    case added(documentId: String)
    case modified
    case removed
}

private enum Constants {
    static let refreshTokenKey = "refreshToken"
    static let emailKey = "email"
    static let userId = "userId"
}

class FirebaseApiService: ApiProtocol {
    
    private let firestore = Firestore.firestore()
    private let errorParser = FirebaseErrorParser()
    private let firestoreService: FirestoreDataService
    private let keychain = KeychainSwift()
    private let dataManegerService: DataManagerServiceProtocol
    private var cachedRefreshToken: String? {
       get {
           return keychain.get(Constants.refreshTokenKey)
       }
       set {
           if let refreshToken = newValue {
               keychain.set(refreshToken, forKey: Constants.refreshTokenKey)
           } else {
               keychain.delete(Constants.refreshTokenKey)
           }
       }
    }

    private var cachedEmail: String? {
       get {
           return keychain.get(Constants.emailKey)
       }
       set {
           if let email = newValue {
               keychain.set(email, forKey: Constants.emailKey)
           } else {
               keychain.delete(Constants.emailKey)
           }
       }
    }

    private var cachedUserId: String? {
       get {
           return keychain.get(Constants.userId)
       }
       set {
           if let userId = newValue {
               keychain.set(userId, forKey: Constants.userId)
           } else {
               keychain.delete(Constants.userId)
           }
       }
    }

    private var invalidUserErrorObserverBlock: (() -> Void)? {
        didSet {
            guard oldValue == nil else {
                fatalError("invalidUserErrorObserverBlock can be set only once -- for SessionService")
            }
        }
    }


    init(dataManager: DataManagerServiceProtocol) {
        self.firestoreService = FirestoreDataService(errorParser: errorParser)
        self.dataManegerService = dataManager
    }
}

// MARK: - Login

extension FirebaseApiService {
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func login(userEmail: String, password: String, completion: @escaping CommonBlock.EmptyResultCompletionBlock) {
        Auth.auth().signIn(withEmail: userEmail, password: password) { [weak self] authResult, error in
            guard let error = error else {
                guard let result = authResult else {
                    return
                }
                self?.cachedRefreshToken = result.user.refreshToken
                self?.cachedEmail = result.user.email
                self?.cachedUserId = result.user.uid
                completion(.success(()))
                return
            }
              completion(.failure(error))
            }
        }
    
    func register(userEmail: String, password: String, completion: @escaping CommonBlock.EmptyResultCompletionBlock) {
        Auth.auth().createUser(withEmail: userEmail, password: password) { [weak self] authResult, error in
            guard let error = error else {
                guard let result = authResult else {
                    return
                }
                self?.cachedRefreshToken = result.user.refreshToken
                self?.cachedEmail = result.user.email
                self?.cachedUserId = result.user.uid
                completion(.success(()))
                return
            }
                completion(.failure(error))
            }
    }
    
    func refresh(completion: @escaping CommonBlock.EmptyResultCompletionBlock) {
        guard let token = cachedRefreshToken else {
            completion(.failure(CommonError.appError(AppError.invalidData)))
            return
        }
        Auth.auth().signIn(withCustomToken: token) { [weak self] result, error in
            if let error = error {
                log.error(error)
                self?.cachedEmail = nil
                self?.cachedRefreshToken = nil
                self?.cachedUserId = nil
                completion(.failure(error))
            } else {
                guard let result = result else {
                    return
                }
                self?.cachedRefreshToken = result.user.refreshToken
                self?.cachedEmail = result.user.email
                completion(.success(()))
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        cachedEmail = nil
        cachedUserId = nil
        cachedRefreshToken = nil
        dataManegerService.deleteAllItems()
    }
    
    func getExpenses(completion: @escaping CommonBlock.ResultCompletionBlock<[CostDB]>) {
        guard let userId = self.cachedUserId else { return }
        let expensesCollection = self.firestore
            .collection(FirestoreCollections.usersData.reference)
            .document(userId)
            .collection(FirestoreCollections.usersData.expenses)
        firestoreService.getSnapshotItems(query: expensesCollection,
                                          parser: ExpenseParser()) { (result) in
                                            switch result {
                                            case .success(let snapshot):
                                                completion(.success(snapshot.items))
                                            case .failure(let error):
                                                completion(.failure(error))
                                            }
        }
    }
    
    func getIncomes(completion: @escaping CommonBlock.ResultCompletionBlock<[IncomeDB]>) {
        guard let userId = self.cachedUserId else { return }
        let incomesCollection = firestore.collection(FirestoreCollections.usersData.reference).document(userId)
            .collection(FirestoreCollections.usersData.incomes)
        firestoreService.getSnapshotItems(query: incomesCollection,
                                          parser: IncomeParser()) { (result) in
                                            switch result {
                                            case .success(let snapshot):
                                                completion(.success(snapshot.items))
                                            case .failure(let error):
                                                completion(.failure(error))
                                            }
        }
    }
    
    func sendExpenses(_ expenses: [CostDB]) {
        guard let userId = self.cachedUserId else { return }
        expenses.forEach { element in
            self.firestore.collection(FirestoreCollections.usersData.reference)
                .document(userId)
                .collection(FirestoreCollections.usersData.expenses)
                .document(element.objectId)
                .setData(toDictionary(cost: element)) { err in
                    if let err = err {
                        log.error("Error writing document: \(err)")
                    } else {
                        log.info("Document successfully written!")
                    }
            }
        }
        
    }
    
    func sendIncomes(_ incomes: [IncomeDB]) {
        guard let userId = self.cachedUserId else { return }
        incomes.forEach { element in
            self.firestore.collection(FirestoreCollections.usersData.reference)
                .document(userId)
                .collection(FirestoreCollections.usersData.incomes)
                .document(element.objectId)
                .setData(toDictionary(income: element)) { err in
                    if let err = err {
                        log.error("Error writing document: \(err)")
                    } else {
                        log.info("Document successfully written!")
                    }
            }
        }
        
    }
    
    func deleteExpense(with id: String) {
        guard let userId = self.cachedUserId else { return }
        self.firestore.collection(FirestoreCollections.usersData.reference)
            .document(userId)
            .collection(FirestoreCollections.usersData.expenses)
            .document(id)
            .delete() { error in
                guard let err = error else {
                    log.info("Delete successfully")
                    return
                }
                log.error("While delete error \(err.localizedDescription) happens")
            }
    }
    
    func deleteIncome(with id: String) {
        guard let userId = self.cachedUserId else { return }
        self.firestore.collection(FirestoreCollections.usersData.reference)
            .document(userId)
            .collection(FirestoreCollections.usersData.incomes)
            .document(id)
            .delete() { error in
                guard let err = error else {
                    log.info("Delete successfully")
                    return
                }
                log.error("While delete error \(err.localizedDescription) happens")
            }
    }
    
    func getEmail() -> String? {
        return cachedEmail
    }
    
    private func toDictionary(cost: CostDB) -> [String : Any] {
        guard let category = cost.category,
            let currency = cost.currency,
            let date = cost.date,
            let cost = cost.value else {
                return [String : Any]()
        }
        return ["category": category, "date": Timestamp(date: date), "value": cost, "currency": currency]
    }
    
    private func toDictionary(income: IncomeDB) -> [String : Any] {
        guard let category = income.category,
            let currency = income.currency,
            let date = income.date,
            let income = income.value else {
                return [String : Any]()
        }
        return ["category": category, "date": Timestamp(date: date), "value": income, "currency": currency]
    }
}
