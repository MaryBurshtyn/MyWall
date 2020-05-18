import Foundation

enum TimePeriod {
    case week
    case month
    case year
    case custom(Date, Date)
    case quarter
}

enum SumType: Int {
    case day
    case month
    case category
}
