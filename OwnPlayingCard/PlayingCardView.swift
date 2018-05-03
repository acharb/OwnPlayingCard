

import UIKit

@IBDesignable
class PlayingCardView: UIView {

    // MARK: constants
    
    private struct SizeRatioConstants {
        static let cornerFontSizeFromBoundsHeight: CGFloat = 0.085
    }
    
    // MARK: properties
    @IBInspectable
    var suit: String = "♥️" { didSet{ setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var rank: Int = 9 { didSet{ setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var isFaceUp:Bool = true { didSet{ setNeedsDisplay(); setNeedsLayout() } }
    
    lazy var upperLeftLabel: UILabel = createLabel()
    lazy var lowerRightLabel: UILabel = createLabel()
    
    var cornerString: NSAttributedString {
        return convertStringToAttributedString(rankString + "\n" + suit, cornerFontSize)
    }
    
    var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
    var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatioConstants.cornerFontSizeFromBoundsHeight
    }
    
    // MARK: private functions
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel){
        label.attributedText = cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    private func convertStringToAttributedString(_ str: String, _ fontSize: CGFloat) -> NSAttributedString {
        // creating font
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        // creating style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        return NSAttributedString(string: str, attributes: [.paragraphStyle: paragraphStyle, .font:font])
    }
    

    // MARK: override functions
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: 16.0)
        UIColor.white.setFill()
        roundedRect.fill()
        
        if !isFaceUp {
            if let image = UIImage(named: "cardback",in: Bundle(for: self.classForCoder), compatibleWith: traitCollection){
                image.draw(in: bounds)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCornerLabel(upperLeftLabel)
        
        configureCornerLabel(lowerRightLabel)
        let frameX = lowerRightLabel.frame.size.width
        let frameY = lowerRightLabel.frame.size.height
        lowerRightLabel.frame.origin = CGPoint(x: bounds.maxX - frameX, y: bounds.maxY - frameY)
        lowerRightLabel.transform = CGAffineTransform.identity
            .rotated(by: CGFloat.pi)
    }
}
