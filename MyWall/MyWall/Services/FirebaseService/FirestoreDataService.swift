import Foundation
import FirebaseFirestore
import FirebaseFunctions

struct SnapshotItems<T> {
    let items: T
    let snapshot: QuerySnapshot
}
typealias SnapshotItemsCompletionBlock<T> = CommonBlock.ResultCompletionBlock<SnapshotItems<T>>

class FirestoreDataService {
    private lazy var functions = Functions.functions(region: "us-central1")
    private let errorParser: FirebaseErrorParser
    
    init(errorParser: FirebaseErrorParser) {
        self.errorParser = errorParser
    }
    
    func getItems<T: CommonParser>(query: Query,
                                   parser: T,
                                   completion: @escaping CommonBlock.ResultCompletionBlock<[T.OutputType]>) {
        getSnapshotItems(query: query, parser: parser) { (result) in
            switch result {
            case .success(let documents):
                completion(.success(documents.items))
            case .failure(let  error):
                completion(.failure(error))
            }
        }
    }
    
    func getItem<T: CommonParser>(document: DocumentReference,
                                  parser: T,
                                  completion: @escaping CommonBlock.ResultCompletionBlock<T.OutputType>) {
        document.getDocument(source: .server) { [weak self] (snapshot, error) in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                let serverError = strongSelf.errorParser.parseFirestoreError(error)
                strongSelf.performCompletion(completion, withResult: .failure(serverError))
                return
            }
            guard let snapshot = snapshot else {
                strongSelf.performCompletion(completion, withResult: .failure(.serverCommunicationError(.unknown)))
                return
            }
            do {
                guard let data = snapshot.data() else {
                    strongSelf.performCompletion(completion, withResult: .failure(.serverCommunicationError(.unknown)))
                    return
                }
                let item = try parser.parse(documentId: snapshot.documentID,
                                            dictionary: data)
                strongSelf.performCompletion(completion, withResult: .success(item))
            } catch {
                guard let appError = error as? AppError else {
                    fatalError("Unknown error while parsing snapshot: \(snapshot.description)")
                }
                strongSelf.performCompletion(completion, withResult: .failure(.appError(appError)))
            }
        }
    }
    
    func getSnapshotItems<T: CommonParser>(query: Query,
                                           parser: T,
                                           completion: @escaping SnapshotItemsCompletionBlock<[T.OutputType]>) {
        query.getDocuments(source: .server) { [weak self] (snapshot, error) in
            guard let strongSelf = self else {
                return
            }
            if let error = error {
                let serverError = strongSelf.errorParser.parseFirestoreError(error)
                strongSelf.performCompletion(completion, withResult: .failure(serverError))
                return
            }
            guard let snapshot = snapshot else {
                strongSelf.performCompletion(completion, withResult: .failure(.serverCommunicationError(.unknown)))
                return
            }
            
            do {
                let items = try parser.parse(snapshot: snapshot)
                let outputItem = SnapshotItems(items: items, snapshot: snapshot)
                strongSelf.performCompletion(completion, withResult: .success(outputItem))
            } catch {
                guard let appError = error as? AppError else {
                    fatalError("Unknown error while parsing snapshot: \(snapshot.description)")
                }
                strongSelf.performCompletion(completion, withResult: .failure(.appError(appError)))
            }
        }
    }
    
    // MARK: - Functions
    
//    func callFunction<T: FirestoreFunction>(_ function: T,
//                                            completion: @escaping CommonBlock.ResultCompletionBlock<T.OutputType>) {
//        functions.httpsCallable(function.name).call(function.data) { [weak self] (response, error) in
//            guard let strongSelf = self else {
//                return
//            }
//            if let error = error {
//                let serverError = strongSelf.errorParser.parseFunctionsError(error)
//                strongSelf.performCompletion(completion, withResult: .failure(serverError))
//                return
//            }
//            guard let response = response?.data as? [String: Any] else {
//                strongSelf.performCompletion(completion, withResult: .failure(.serverCommunicationError(.unknown)))
//                return
//            }
//            
//            do {
//                let item = try function.parseResult(response)
//                strongSelf.performCompletion(completion, withResult: .success(item))
//            } catch {
//                guard let appError = error as? AppError else {
//                    fatalError("Unknown error while parsing response: \(response.description)")
//                }
//                strongSelf.performCompletion(completion, withResult: .failure(.appError(appError)))
//            }
//        }
//    }
//    
    // MARK: - Private
    
    private func performCompletion<T>(_ completion: @escaping CommonBlock.ResultCompletionBlock<T>,
                                      withResult result: Result<T, CommonError>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
