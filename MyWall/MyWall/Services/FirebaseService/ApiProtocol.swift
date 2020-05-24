import Foundation

protocol ApiProtocol: class {
    var isSignedIn: Bool { get }

    func login(userEmail: String, password: String, completion: @escaping CommonBlock.EmptyResultCompletionBlock)
//    func signIn(adalToken: String,
//                userEmail: String,
//                completion: @escaping CommonBlock.EmptyResultCompletionBlock)
    func signOut()
    func register(userEmail: String, password: String, completion: @escaping CommonBlock.EmptyResultCompletionBlock)
    func refresh(completion: @escaping CommonBlock.EmptyResultCompletionBlock)
    func getExpenses(completion: @escaping CommonBlock.ResultCompletionBlock<[CostDB]>)
    func getIncomes(completion: @escaping CommonBlock.ResultCompletionBlock<[IncomeDB]>)
    func sendExpenses(_ expenses: [CostDB])
    func sendIncomes(_ incomes: [IncomeDB])
    func getEmail() -> String?
    func deleteExpense(with id: String)
    func deleteIncome(with id: String)
//    func getCurrentUserUid() -> Result<String, CommonError>
//    func setInvalidUserErrorObserverBlock(_ block: @escaping (() -> Void))
//    func setUserLocation(locationPoint: LocationPoint, completion: @escaping CommonBlock.EmptyResultCompletionBlock)
//    func getActivitiesPreviews(completion: @escaping CommonBlock.ResultCompletionBlock<[ActivityPreview]>)
//    func getActivity(activityId: String, completion: @escaping CommonBlock.ResultCompletionBlock<Activity>)
//    func getShuttleSchedules(completion: @escaping CommonBlock.ResultCompletionBlock<[ShuttleSchedule]>)
//    func getEvents(completion: @escaping CommonBlock.ResultCompletionBlock<[CommonEvent]>)
//    func getEvent(eventId: String, completion: @escaping CommonBlock.ResultCompletionBlock<CommonEvent>)
//    func getCurrentEvent(completion: @escaping CommonBlock.ResultCompletionBlock<String?>)
//    func getCurrentEvents(completion: @escaping CommonBlock.ResultCompletionBlock<[CommonEvent]>)
//    func getTickets(eventId: String, email: String, completion: @escaping CommonBlock.ResultCompletionBlock<[Ticket]?>)
//    func getEmployee(eventId: String, email: String, completion: @escaping CommonBlock.ResultCompletionBlock<Employee?>)
//    func getNotifications(completion: @escaping CommonBlock.ResultCompletionBlock<[EventNotification]>)
//    func getActivityNotifications(completion: @escaping CommonBlock.ResultCompletionBlock<[ActivityNotification]>)
//    func addEventNotificationChangesHandler(_ handler: @escaping CommonBlock.ChangeHandler)
//    func addActivityNotificationChangesHandler(_ handler: @escaping CommonBlock.ChangeHandler)
//    func submitCinemaTicket(resultData: CinemaEventRegistrationData, completion: @escaping CommonBlock.ResultCompletionBlock<[String: Any]>)
}
