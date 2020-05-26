import Foundation

enum TimePeriod {
    case week
    case month
    case year
    case custom(Date, Date)
    case quarter
    
    var stringValue: String {
        switch self {
        case .week:
            return L10n.week
        case .month:
            return L10n.month
        case .year:
            return L10n.year
        case .custom(let first, let sec):
            return L10n.customPeriod(first.month(), sec.month())
        case .quarter:
            return L10n.quarter
        }
    }
}

enum SumType: Int {
    case day
    case month
    case category
    
    var stringValue: String {
    switch self {
    case .day:
        return L10n.day
    case .month:
        return L10n.month
    case .category:
        return L10n.category
        }
    }
}

enum DataType: Int {
    case expenses
    case incomes
    
    var stringValue: String {
       switch self {
       case .expenses:
           return L10n.forcosts
       case .incomes:
           return L10n.forincomes
           }
       }
}
