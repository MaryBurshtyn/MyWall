// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Montserrat {
    internal static let black = FontConvertible(name: "Montserrat-Black", family: "Montserrat", path: "Montserrat-Black.otf")
    internal static let blackItalic = FontConvertible(name: "Montserrat-BlackItalic", family: "Montserrat", path: "Montserrat-BlackItalic.otf")
    internal static let bold = FontConvertible(name: "Montserrat-Bold", family: "Montserrat", path: "Montserrat-Bold.otf")
    internal static let boldItalic = FontConvertible(name: "Montserrat-BoldItalic", family: "Montserrat", path: "Montserrat-BoldItalic.otf")
    internal static let extraBold = FontConvertible(name: "Montserrat-ExtraBold", family: "Montserrat", path: "Montserrat-ExtraBold.otf")
    internal static let extraBoldItalic = FontConvertible(name: "Montserrat-ExtraBoldItalic", family: "Montserrat", path: "Montserrat-ExtraBoldItalic.otf")
    internal static let extraLight = FontConvertible(name: "Montserrat-ExtraLight", family: "Montserrat", path: "Montserrat-ExtraLight.otf")
    internal static let extraLightItalic = FontConvertible(name: "Montserrat-ExtraLightItalic", family: "Montserrat", path: "Montserrat-ExtraLightItalic.otf")
    internal static let italic = FontConvertible(name: "Montserrat-Italic", family: "Montserrat", path: "Montserrat-Italic.otf")
    internal static let light = FontConvertible(name: "Montserrat-Light", family: "Montserrat", path: "Montserrat-Light.otf")
    internal static let lightItalic = FontConvertible(name: "Montserrat-LightItalic", family: "Montserrat", path: "Montserrat-LightItalic.otf")
    internal static let medium = FontConvertible(name: "Montserrat-Medium", family: "Montserrat", path: "Montserrat-Medium.otf")
    internal static let mediumItalic = FontConvertible(name: "Montserrat-MediumItalic", family: "Montserrat", path: "Montserrat-MediumItalic.otf")
    internal static let regular = FontConvertible(name: "Montserrat-Regular", family: "Montserrat", path: "Montserrat-Regular.otf")
    internal static let semiBold = FontConvertible(name: "Montserrat-SemiBold", family: "Montserrat", path: "Montserrat-SemiBold.otf")
    internal static let semiBoldItalic = FontConvertible(name: "Montserrat-SemiBoldItalic", family: "Montserrat", path: "Montserrat-SemiBoldItalic.otf")
    internal static let thin = FontConvertible(name: "Montserrat-Thin", family: "Montserrat", path: "Montserrat-Thin.otf")
    internal static let thinItalic = FontConvertible(name: "Montserrat-ThinItalic", family: "Montserrat", path: "Montserrat-ThinItalic.otf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  internal enum MontserratAlternates {
    internal static let black = FontConvertible(name: "MontserratAlternates-Black", family: "Montserrat Alternates", path: "MontserratAlternates-Black.otf")
    internal static let blackItalic = FontConvertible(name: "MontserratAlternates-BlackItalic", family: "Montserrat Alternates", path: "MontserratAlternates-BlackItalic.otf")
    internal static let bold = FontConvertible(name: "MontserratAlternates-Bold", family: "Montserrat Alternates", path: "MontserratAlternates-Bold.otf")
    internal static let boldItalic = FontConvertible(name: "MontserratAlternates-BoldItalic", family: "Montserrat Alternates", path: "MontserratAlternates-BoldItalic.otf")
    internal static let extraBold = FontConvertible(name: "MontserratAlternates-ExtraBold", family: "Montserrat Alternates", path: "MontserratAlternates-ExtraBold.otf")
    internal static let extraBoldItalic = FontConvertible(name: "MontserratAlternates-ExtraBoldItalic", family: "Montserrat Alternates", path: "MontserratAlternates-ExtraBoldItalic.otf")
    internal static let extraLight = FontConvertible(name: "MontserratAlternates-ExtraLight", family: "Montserrat Alternates", path: "MontserratAlternates-ExtraLight.otf")
    internal static let extraLightItalic = FontConvertible(name: "MontserratAlternates-ExtraLightItalic", family: "Montserrat Alternates", path: "MontserratAlternates-ExtraLightItalic.otf")
    internal static let italic = FontConvertible(name: "MontserratAlternates-Italic", family: "Montserrat Alternates", path: "MontserratAlternates-Italic.otf")
    internal static let light = FontConvertible(name: "MontserratAlternates-Light", family: "Montserrat Alternates", path: "MontserratAlternates-Light.otf")
    internal static let lightItalic = FontConvertible(name: "MontserratAlternates-LightItalic", family: "Montserrat Alternates", path: "MontserratAlternates-LightItalic.otf")
    internal static let medium = FontConvertible(name: "MontserratAlternates-Medium", family: "Montserrat Alternates", path: "MontserratAlternates-Medium.otf")
    internal static let mediumItalic = FontConvertible(name: "MontserratAlternates-MediumItalic", family: "Montserrat Alternates", path: "MontserratAlternates-MediumItalic.otf")
    internal static let regular = FontConvertible(name: "MontserratAlternates-Regular", family: "Montserrat Alternates", path: "MontserratAlternates-Regular.otf")
    internal static let semiBold = FontConvertible(name: "MontserratAlternates-SemiBold", family: "Montserrat Alternates", path: "MontserratAlternates-SemiBold.otf")
    internal static let semiBoldItalic = FontConvertible(name: "MontserratAlternates-SemiBoldItalic", family: "Montserrat Alternates", path: "MontserratAlternates-SemiBoldItalic.otf")
    internal static let thin = FontConvertible(name: "MontserratAlternates-Thin", family: "Montserrat Alternates", path: "MontserratAlternates-Thin.otf")
    internal static let thinItalic = FontConvertible(name: "MontserratAlternates-ThinItalic", family: "Montserrat Alternates", path: "MontserratAlternates-ThinItalic.otf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, extraBold, extraBoldItalic, extraLight, extraLightItalic, italic, light, lightItalic, medium, mediumItalic, regular, semiBold, semiBoldItalic, thin, thinItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [Montserrat.all, MontserratAlternates.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
