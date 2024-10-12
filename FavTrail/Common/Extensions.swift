//
//  Extensions.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 02/08/22.
//

import UIKit

//MARK: UIVIEW
extension UIView {
    
    func addDefaultCornerRadius(_ radius: Double = 4.0) {
        self.layer.cornerRadius = radius
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func instantiateFromNib<T: UIView>(viewType: T.Type, bundle: Bundle) -> T {
      return bundle.loadNibNamed(identifier, owner: nil, options: nil)!.first as! T
    }
    
    class func instantiateFromNib(_ bundle: Bundle) -> Self {
      return instantiateFromNib(viewType: self, bundle: bundle)
    }
    
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func addShadowToView(shadowColor: CGColor = UIColor.lightGray.cgColor, shadowOpacity: Float = 0.2, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 6) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func fillSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor)
        ])
    }
    
    private var shimmerIdentifier: String {
        return "shimmerIdentifier"
    }

    func addShimmerGradient() {
        let shimmerEffect = CAGradientLayer()
        shimmerEffect.name = shimmerIdentifier
        shimmerEffect.frame = self.bounds
        shimmerEffect.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerEffect.endPoint = CGPoint(x: 1, y: 0.5)
        
        let lightColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        let darkColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        shimmerEffect.colors = [darkColor, lightColor, darkColor]
        shimmerEffect.locations = [-1, -0.3, 0.3]
        
        let shimmerAnimation = CABasicAnimation(keyPath: "locations")
        shimmerAnimation.fromValue = [-1, -0.3, 0.3]
        shimmerAnimation.toValue = [1, 1.3, 1.6]
        shimmerAnimation.duration = 1.5
        shimmerAnimation.repeatCount = .infinity
        shimmerEffect.add(shimmerAnimation, forKey: "shimmering")
        self.layer.addSublayer(shimmerEffect)
    }

    func removeShimmerGradient() {
        if let shimmerLayer = self.layer.sublayers?.first(where: { $0.name == shimmerIdentifier }) {
            shimmerLayer.removeFromSuperlayer()
        }
    }
}

//MARK: UIVIEW-CONTROLLER

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIStackView {
    func removeAllArrangedStackView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

//MARK: UISCROLLVIEW

extension UIScrollView {
    static var direction: ViewScrollDirection = .up

    enum ViewScrollDirection {
        case up, down
    }

    func getCurrentScrollDirection(lastOffset: CGPoint) -> (ViewScrollDirection, CGPoint) {
        let currentContentOffset: CGPoint = self.contentOffset
        if  currentContentOffset.y > lastOffset.y {
            return (.down, currentContentOffset)
        } else {
            return (.up, currentContentOffset)
        }
    }
}

//MARK: UIFONT

extension UIFont {
    
    enum PoppinsFont {
        case bold
        case light
        case medium
        case semiBold
        case regular
    }
    
    static func fontBuilder(fontType: PoppinsFont, size: CGFloat = 17.0) -> UIFont {
        switch fontType {
        case .bold:
            return poppinsBold(size: size)
        case .light:
            return poppinsLight(size: size)
        case .medium:
            return poppinsMedium(size: size)
        case .semiBold:
            return poppinsSemiBold(size: size)
        case .regular:
            return poppinsRegular(size: size)
        }
    }
    // Poppins fonts
    
    static func poppinsBold(size:CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func poppinsLight(size:CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func poppinsMedium(size:CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func poppinsSemiBold(size:CGFloat)-> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func poppinsRegular(size:CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

//MARK: UICOLOR

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

//MARK: STRING

extension String {
    
    static func empty() -> String {
        return ""
    }
    
    func getAttributedString() -> NSAttributedString {
        return AttributedStringBuilder(initString: self).parseStr()
    }

}

extension NSAttributedString {
    func height(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
}
