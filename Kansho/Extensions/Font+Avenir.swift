//
//  Font+Avenir.swift
//  Kansho
//
//  Created by Dason Tiovino on 24/10/24.
//

import SwiftUI

/// Avenir  Font Documentation
/// * Avenir
/// * Avenir-Book
/// * Avenir-Roman
/// * Avenir-Light
/// * Avenir-Medium
/// * Avenir-Heavy
/// * Avenir-Black

enum AvenirWeight: String {
    case light = "Avenir-Light"
    case book = "Avenir-Book"
    case medium = "Avenir-Medium"
    case semibold = "Avenir-Heavy"
    case heavy = "Avenir-Black"
}

extension Font {
    static func themeCustom(_ weight: String, size: CGFloat, relativeTo: Font.TextStyle) -> Font {
        Font.custom(weight, size: size, relativeTo: relativeTo)
    
    }
    
    static func themeLargeTitle(weight: AvenirWeight = .heavy, size: CGFloat = 34) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .largeTitle
        )
    }
    
    static func themeTitle(weight: AvenirWeight = .book, size: CGFloat = 28) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .title
        )
    }
    
    static func themeTitle2(weight: AvenirWeight = .book, size: CGFloat = 22) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .title2
        )
    }
    
    static func themeTitle3(weight: AvenirWeight = .book, size: CGFloat = 20) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .title3
        )
    }
    
    static func themeHeadline(weight: AvenirWeight = .book, size: CGFloat = 17) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .headline
        )
    }
    
    static func themeBody(weight: AvenirWeight = .book, size: CGFloat = 16) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .body
        )
    }
    
    static func themeCallout(weight: AvenirWeight = .book, size: CGFloat = 16) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .callout
        )
    }
    
    static func themeSubheadline(weight: AvenirWeight = .book, size: CGFloat = 15) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .subheadline
        )
    }
    
    static func themeFootnote(weight: AvenirWeight = .book, size: CGFloat = 13) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .footnote
        )
    }
    
    static func themeCaption(weight: AvenirWeight = .book, size: CGFloat = 12) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .caption
        )
    }
    
    static func themeCaption2(weight: AvenirWeight = .book, size: CGFloat = 11) -> Font {
        Font.custom(
            weight.rawValue,
            size: size,
            relativeTo: .caption2
        )
    }
}
