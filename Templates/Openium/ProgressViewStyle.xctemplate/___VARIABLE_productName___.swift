//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import SwiftUI

extension ProgressViewStyle where Self == ___VARIABLE_productName___ {
    static var <#style#>: ___VARIABLE_productName___ { ___VARIABLE_productName___() }
}

struct ___VARIABLE_productName___: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        // Example: gauge progression
        let fractionCompleted = configuration.fractionCompleted ?? 0.0
        
        return VStack {
            configuration.label

            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(.orange.opacity(0.2), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))

                Circle()
                    .trim(from: 0, to: fractionCompleted)
                    .stroke(.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .animation(.easeIn(duration: 0.1), value: configuration.fractionCompleted)
                    .rotationEffect(.degrees(-90))
            }
            
            configuration.currentValueLabel
        }
    }
}

struct ___VARIABLE_productName____Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    private struct Preview: View {
        @State private var progress: CGFloat = 10
        
        var body: some View {
            VStack {
                ProgressView(value: progress, total: 100) {
                    EmptyView()
                } currentValueLabel: {
                    Text("\(Int(progress))%")
                        .font(.callout)
                        .fixedSize()
                }
                .progressViewStyle(.<#style#>)
                .frame(width: 50, height: 100)
                .onTapGesture {
                    progress += 20
                }
            }
        }
    }
}