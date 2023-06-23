//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftUI

private struct ___VARIABLE_productName___: EnvironmentKey {
    static let defaultValue: <#Type#> = <#defaultValue#>
}

extension EnvironmentValues {
    var <#keyPropertyName#>: <#Type#> {
        get { self[___VARIABLE_productName___.self] }
        set { self[___VARIABLE_productName___.self] = newValue }
    }
}

// MARK: - Dedicated modifier

extension View {
    func <#keyPropertyName#>(_ value: <#Type#>) -> some View {
        environment(\.<#keyPropertyName#>, value)
    }
}

/*
Example key: IsSensitiveKey (var isSensitive)
https://sarunw.com/posts/how-to-define-custom-environment-values-in-swiftui/

struct ContentView: View {
    @Environment(\.isSensitive) var isSensitive
    
    var body: some View {
        Text("Hello")
            .environment(\.isSensitive, true)
    }
}

extension View {
    func isSensitive(_ value: Bool) -> some View {
        environment(\.isSensitive, value)
    }
}

Text("Hello")
    .isSensitive(true)
*/