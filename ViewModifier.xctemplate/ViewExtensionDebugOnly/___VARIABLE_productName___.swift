//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftUI

struct ___VARIABLE_productName___: ViewModifier {
    //@State var someVar: String = ""
    //let someLet: Bool
    
    func body(content: Content) -> some View {
#if DEBUG
        content
#else
        content
#endif
    }
}

extension View {
    func <#functionName#>(<#parameter#>: <#Type#>) -> some View {
        self
            .modifier(
                ___VARIABLE_productName___(<#parameter#>: <#Type#>)
            )
    }
}