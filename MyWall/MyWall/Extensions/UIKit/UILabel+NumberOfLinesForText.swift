import Foundation
extension UILabel {
    func numberOfLinesForText(with width: CGFloat, textFontSize: CGFloat) -> Int {
        let maxSize = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font ??
            UIFont.systemFont(ofSize: textFontSize)], context: nil).height
        let lineHeight = font.lineHeight
        return Int(textHeight / lineHeight)
    }
}
