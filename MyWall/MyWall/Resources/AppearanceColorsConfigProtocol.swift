import UIKit

protocol AppearanceColorsConfigProtocol {
    
    var appTintColor: UIColor { get }
    var overlayColor: UIColor { get }
    var viewBackgroundColor: UIColor { get }
    var separatorColor: UIColor { get }
    var selectedBackgroundColor: UIColor { get }
    var inputBorderColor: UIColor { get }
    var navigationBarButtonColor: UIColor { get }
    var shadow: UIColor { get }
    var switchOffTintColor: UIColor { get }
    var clearColor: UIColor { get }
    
    // MARK: - BarColors
    
    var barTintColor: UIColor { get }
    var barBackgroundColor: UIColor { get }
    var tabBarSelectedImage: UIColor { get }
    var tabBarUnselectedImage: UIColor { get }
    var tabBarSelectedText: UIColor { get }
    var tabBarUnselectedText: UIColor { get }
    var tabBarTintColor: UIColor { get }
    
    // MARK: ButtonColors

    var buttonNormalText: UIColor { get }
    var buttonHighlightedText: UIColor { get }
    var buttonBackground: UIColor { get }
    var buttonBackgroundDisabled: UIColor { get }
    var buttonShadow: UIColor { get }
    var buttonBorder: UIColor { get }
    var filledButtonTitle: UIColor { get }
    var toolbarButtonBottomLabel: UIColor { get }
    var toolbarButtonTintColor: UIColor { get }
    var backButtonTintColor: UIColor { get }
    
    var loginBorderColor: UIColor { get }
    var dateBackgroundColor: UIColor { get }
    // MARK: - Login

    var hintTextColor: UIColor { get }
    
    // MARK: GradientColors
    
    var pinkTileGradientArray: [UIColor] { get }
    var blueTileGradientArray: [UIColor] { get }
    
    // MARK: - Search
    
    var commentTextColor: UIColor { get }
    var searchBarBorderColor: UIColor { get }
    
    // MARK: - Calendar
    
    var calendarSelectionColor: UIColor { get }
    var calendarDayOfWeek: UIColor { get }
    var calendarAvailableDateBorderColor: UIColor { get }
    var calendarSelectionTitleColor: UIColor { get }
    var calendarTodayTitleColor: UIColor { get }
    var calendarEventColor: UIColor { get }
    var disabledText: UIColor { get }
    var defaultText: UIColor { get }
    
    // MARK: - Notifications
    
    var notificationIsReadColor: UIColor { get }
    var notificationNotReadColor: UIColor { get }
    
    // MARK: - Event
    
    var ticketEventDescriptionButtonColor: UIColor { get }
    var ticketDisabledButtonColor: UIColor { get }
    var registrationLinkColor: UIColor { get }
    var eventTitleLabelColor: UIColor { get }
    
    var noEventsBackgroundColor: UIColor { get }
}
