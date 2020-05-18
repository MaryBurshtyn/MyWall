import Foundation
extension Date {
    
    func timeWithDefaultFormat() -> String {
        return dateString(with: "HH:mm")
    }
    
    func dateWithDefaultFormat() -> String {
        return dateString(with: "dd.MM.yyyy")
    }

    func dateWithLocale() -> String {
        return dateString(with: "dd MMMM")
    }
    
    func monthYearWithLocale() -> String {
        return dateString(with: "MMMM YYYY")
    }
    
    func daysOfMonth() -> String {
        return dateString(with: "dd")
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        return dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
    }
    
    func month() -> String {
        return dateString(with: "MMMM")
    }
    
    func hasSameDay(with date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.component(.day, from: date) == calendar.component(.day, from: self)
    }
    
    private func dateString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: L10n.locale)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        if sunday.dateWithLocale() == self.dateWithLocale() {
            return gregorian.date(byAdding: .day, value: -6, to: sunday)
        }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        if sunday.dateWithLocale() == self.dateWithLocale() {
            return gregorian.date(byAdding: .day, value: 1, to: sunday)
        }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var startOfMonth: Date? {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)
    }
    
    var endOfMonth: Date? {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth!)
    }
    
    var quarter: (Date, Date) {
        guard let startOfMonth = self.startOfMonth else {return (Date(), Date()) }
        var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)

        var start: Int
        var end: Int
        switch components.month! {
        case 1,2,3:
            start = 1
            end = 3
        case 4,5,6:
            start = 4
            end = 6
        case 7,8,9:
            start = 7
            end = 9
        case 10,11,12:
            start = 10
            end = 12
        default:
            start = 1
            end = 3
        }
        components.month = start
        guard let startQuarter = Calendar.current.date(from: components) else {return (Date(), Date())}
        components.month = end
        guard let endQuarter = Calendar.current.date(from: components) else {return (Date(), Date())}
        return (startQuarter, endQuarter)
    }
    
    var yearDates: (Date, Date) {
        let year = Calendar.current.component(.year, from: self)
        guard let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)),
        let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear),
        let firstOfYear =  Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1)) else {
            return (Date(), Date())
        }
        return (firstOfYear, lastOfYear)
    }
}
