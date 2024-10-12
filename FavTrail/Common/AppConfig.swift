//
//  AppConfig.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 02/08/22.
//

import Foundation
import UIKit

enum Theme {
    case light
    case dark
    
    var backGroundColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 104/255, green: 176/255, blue: 171/255, alpha: 1)
        case .dark:
            //MARK: not required currently
            return UIColor.black
        }
    }
    
    var tabItemColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 78/255, green: 130/255, blue: 126/255, alpha: 1)
        case .dark:
            return UIColor(red: 104/255, green: 176/255, blue: 171/255, alpha: 1)
        }
    }
    
    var tabBarBGColor: UIColor {
        switch self {
        case .light:
            return UIColor(red: 186/255, green: 230/255, blue: 226/255, alpha: 1)
        case .dark:
            return UIColor(red: 104/255, green: 176/255, blue: 171/255, alpha: 1)
        }
    }
}


class AppConfig {
    static var theme: Theme = .light
}
