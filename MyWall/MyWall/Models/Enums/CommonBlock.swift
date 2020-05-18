import Foundation

enum CommonBlock {
    typealias EmptyResultCompletionBlock = (_ response: Result<Void, Error>) -> Void
    typealias ResultCompletionBlock<T> = (_ response: Result<T, CommonError>) -> Void
    typealias ChangeHandler = (_ snapshotItemIds: ChangeDocumentType) -> Void
}
