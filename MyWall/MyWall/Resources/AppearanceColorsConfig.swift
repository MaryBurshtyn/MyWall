import UIKit

class AppearanceColorsConfig: AppearanceColorsConfigProtocol {
    
    let appTintColor = #colorLiteral(red: 0.01864526048, green: 0.4776622653, blue: 1, alpha: 1)
    let overlayColor = #colorLiteral(red: 0.09411764706, green: 0.6590752006, blue: 0.360124588, alpha: 0.3)
    let viewBackgroundColor: UIColor = .white
    let separatorColor: UIColor = .black
    let selectedBackgroundColor = #colorLiteral(red: 0.09467499703, green: 0.6590752006, blue: 0.360124588, alpha: 0.7013919454)
    let inputBorderColor: UIColor = .black
    let navigationBarButtonColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    let shadow: UIColor = .black
    let clearColor: UIColor = .clear

    let switchOffTintColor = #colorLiteral(red: 0.9371728897, green: 0.9373078942, blue: 0.9567489028, alpha: 1)
    
    // MARK: - BarColors

    let barTintColor: UIColor = .white
    let barBackgroundColor: UIColor = .white
    let tabBarSelectedImage = #colorLiteral(red: 0.01960784314, green: 0.4784313725, blue: 1, alpha: 1)
    let tabBarUnselectedImage = #colorLiteral(red: 0.568627451, green: 0.5803921569, blue: 0.6078431373, alpha: 1)
    let tabBarSelectedText: UIColor = #colorLiteral(red: 0.01960784314, green: 0.4784313725, blue: 1, alpha: 1)
    let tabBarUnselectedText: UIColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
    let tabBarTintColor: UIColor = #colorLiteral(red: 0.6656950116, green: 1, blue: 0.9145853519, alpha: 1)

    // MARK: ButtonColor

    let buttonNormalText = UIColor.black
    let buttonHighlightedText = UIColor.white.darkerColor
    let buttonBackground = UIColor.white
    let buttonBackgroundDisabled = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
    let buttonShadow = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)
    let buttonBorder = #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
    let filledButtonTitle = UIColor.white
    let toolbarButtonBottomLabel = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1960784314, alpha: 1)
    let toolbarButtonTintColor = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1960784314, alpha: 1)
    let backButtonTintColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    
    let loginBorderColor =  #colorLiteral(red: 0.4664202505, green: 0.7799158287, blue: 0.7136617595, alpha: 1)
    let dateBackgroundColor =  #colorLiteral(red: 0.6000769009, green: 1, blue: 0.9246149459, alpha: 0.2034460616)
    let navBarColor = #colorLiteral(red: 0.6510270238, green: 0.749537766, blue: 0.989726603, alpha: 1)
    // MARK: - Login

    let hintTextColor = UIColor.white
    
    // MARK: GradientColors
    
    let pinkTileGradientArray = [#colorLiteral(red: 1, green: 0.4235294118, blue: 0.7019607843, alpha: 1), #colorLiteral(red: 0.8705882353, green: 0.1294117647, blue: 0.6196078431, alpha: 1)]
    let blueTileGradientArray = [#colorLiteral(red: 0.1019607843, green: 0.7215686275, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.03921568627, green: 0.4039215686, blue: 0.937254902, alpha: 1)]
    
    // MARK: - Search
    
    let commentTextColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    let searchBarBorderColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
    
    // MARK: - Calendar
    
    let calendarSelectionColor = #colorLiteral(red: 0.03921568627, green: 0.4039215686, blue: 0.937254902, alpha: 1)
    let calendarDayOfWeek = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1960784314, alpha: 1)
    let calendarAvailableDateBorderColor = #colorLiteral(red: 0.03921568627, green: 0.4039215686, blue: 0.937254902, alpha: 1)
    let calendarSelectionTitleColor: UIColor = .white
    let calendarTodayTitleColor = #colorLiteral(red: 0.03921568627, green: 0.4039215686, blue: 0.937254902, alpha: 1)
    let calendarEventColor: UIColor = .clear
    var disabledText = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    var defaultText = #colorLiteral(red: 0.1843137255, green: 0.1843137255, blue: 0.1960784314, alpha: 1)
    
    // MARK: - Notifications
    
    var notificationIsReadColor = UIColor.clear
    var notificationNotReadColor = #colorLiteral(red: 0.01018444262, green: 0.4784039855, blue: 0.9989792705, alpha: 1)
    
    // MARK: - Event
    
    let ticketEventDescriptionButtonColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    let ticketDisabledButtonColor = UIColor.white
    let registrationLinkColor =  #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    let eventTitleLabelColor = UIColor.black
    
    let noEventsBackgroundColor = #colorLiteral(red: 0.9727851748, green: 0.9729443192, blue: 0.9727514386, alpha: 1)
}
