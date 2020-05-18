// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let _1 = ImageAsset(name: "1")
  internal static let _2 = ImageAsset(name: "2")
  internal static let _3 = ImageAsset(name: "3")
  internal static let add = ImageAsset(name: "add")
  internal static let add1 = ImageAsset(name: "add1")
  internal static let add2 = ImageAsset(name: "add2")
  internal static let beauty = ImageAsset(name: "beauty")
  internal static let carService = ImageAsset(name: "carService")
  internal static let childrenExpenses = ImageAsset(name: "childrenExpenses")
  internal static let communalPayments = ImageAsset(name: "communalPayments")
  internal static let eatOuts = ImageAsset(name: "eatOuts")
  internal static let education = ImageAsset(name: "education")
  internal static let fare = ImageAsset(name: "fare")
  internal static let foodProducts = ImageAsset(name: "foodProducts")
  internal static let fuel = ImageAsset(name: "fuel")
  internal static let gifts = ImageAsset(name: "gifts")
  internal static let homeImprovement = ImageAsset(name: "homeImprovement")
  internal static let householdAppliances = ImageAsset(name: "householdAppliances")
  internal static let householdGoods = ImageAsset(name: "householdGoods")
  internal static let icBackground = ImageAsset(name: "ic_background")
  internal static let icHome = ImageAsset(name: "ic_home")
  internal static let insurance = ImageAsset(name: "insurance")
  internal static let internet = ImageAsset(name: "internet")
  internal static let loans = ImageAsset(name: "loans")
  internal static let medication = ImageAsset(name: "medication")
  internal static let mobileTelefony = ImageAsset(name: "mobileTelefony")
  internal static let noCategory = ImageAsset(name: "noCategory")
  internal static let notificationTextGradient = ImageAsset(name: "notificationTextGradient")
  internal static let parentExpenses = ImageAsset(name: "parentExpenses")
  internal static let recreation = ImageAsset(name: "recreation")
  internal static let rent = ImageAsset(name: "rent")
  internal static let repairs = ImageAsset(name: "repairs")
  internal static let sport = ImageAsset(name: "sport")
  internal static let treatment = ImageAsset(name: "treatment")
  internal static let wallet = ImageAsset(name: "wallet")
  internal static let wear = ImageAsset(name: "wear")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
