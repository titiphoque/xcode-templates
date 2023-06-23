//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
import SwiftUI

enum FontStyle {
    case title1
    case title2
    case body
    
    var font: Font {
        switch self {
        case .title1: return Font.title
        case .title2: return Font.title2
        case .body: return Font.body
        // case .<#enumValue#>: return <#Font#>
        }
    }
    
    var uiFont: UIFont {
        switch self {
        case .title1: return UIFont.preferredFont(forTextStyle: .title1)
        case .title2: return UIFont.preferredFont(forTextStyle: .title2)
        case .body: return UIFont.preferredFont(forTextStyle: .body)
        // case .<#enumValue#>: return <#UIFont#>
        }
    }
}

// MARK: - Modifier

struct FontStyleViewModifier: ViewModifier {
    let fontStyle: FontStyle
    
    func body(content: Content) -> some View {
        content
            .font(fontStyle.font)
    }
}

// MARK: - Extensions

extension Text {
    func appFont(_ style: FontStyle) -> Text {
        self.font(style.font)
    }
}

extension View {
    func appFont(_ style: FontStyle) -> some View {
        self.modifier(
            FontStyleViewModifier(fontStyle: style)
        )
    }
}
