//
//  FontProvider.swift
//  PanCard
//
//  Created by Ha Duyen Quang Huy on 19/05/2022.
//

import Foundation
import UIKit

protocol Font {
     func of(size: CGFloat) -> UIFont?
}

extension Font where Self: RawRepresentable, Self.RawValue == String {
     func of(size: CGFloat) -> UIFont? {
          return UIFont(name: rawValue, size: size)
     }
}

enum Avenir: String, Font {
     case black = "Avenir Black"
     case blackOblique = "Avenir Black Oblique"
     case book = "Avenir Book"
     case bookOblique = "Avenir Book Oblique"
     case heavy = "Avenir Heavy"
     case heavyOblique = "Avenir Heavy Oblique"
     case light = "Avenir Light"
     case lightOblique = "Avenir Light Oblique"
     case medium = "Avenir Medium"
     case mediumOblique = "Avenir Medium Oblique"
}

struct FontProvider {
    static func defaultRegularFont(with size: Double) -> UIFont {
        return Avenir.book.of(size: size)!
    }
}
