//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftUI

extension ButtonStyle where Self == ___VARIABLE_productName___ {
    static var <#styleName#>: ___VARIABLE_productName___ { ___VARIABLE_productName___() }
}

struct ___VARIABLE_productName___: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool

    // MARK: - Init

    let <#property#>: <#Type#>
    
    init(<#property#>: <#Type#> = <#defaultValue#>) {
        self.<#property#> = <#property#>
    }
    
    // MARK: - Body

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}

struct ___VARIABLE_productName____Previews: PreviewProvider {
    static var previews: some View {
        Button {
            debugPrint("Button action")
        } label: {
            Text("Item Item")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.<#styleName#>)
        .padding(24)
    }
}