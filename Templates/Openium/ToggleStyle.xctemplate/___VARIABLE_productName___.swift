//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftUI

extension ToggleStyle where Self == ___VARIABLE_productName___ {
    static var <#styleName#>: ___VARIABLE_productName___ { ___VARIABLE_productName___() }
}

struct ___VARIABLE_productName___: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // Example: checkbox toggle style
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn
                      ? "checkmark.circle.fill"
                      : "circle")
                configuration.label
            }
        }
    }
}

struct ___VARIABLE_productName____Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    private struct Preview: View {
        @State private var isOn: Bool = true
        
        var body: some View {
            // Toggle("", isOn: $isOn)
            Toggle(isOn: $isOn, label: {
                Text("IsOn ?")
                    .font(.callout)
                
            })
            .toggleStyle(.checkitem)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
    }
}