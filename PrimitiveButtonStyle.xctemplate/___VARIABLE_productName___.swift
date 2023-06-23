//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftUI

extension PrimitiveButtonStyle where Self == ___VARIABLE_productName___ {
    static var <#styleName#>: ___VARIABLE_productName___ { ___VARIABLE_productName___() }
}

struct ___VARIABLE_productName___: PrimitiveButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool

    // MARK: - Init

    let <#property#>: CGFloat
    
    init(<#property#>: <#Type#> = <#defaultValue#>) {
        self.<#property#> = <#property#>
    }
    
    // MARK: - Body

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .onTapGesture(count: 2, perform: configuration.trigger)
        /*
         Example 1: Trigger on double tap
         .onTapGesture(count: 2, perform: configuration.trigger)
         
         Example 2: Trigger on swipe
            .gesture(
                DragGesture()
                    .onEnded { _ in
                        configuration.trigger()
                    }
            )
         */
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