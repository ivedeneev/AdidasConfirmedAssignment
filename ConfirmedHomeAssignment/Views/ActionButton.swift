//
//  ActionButton.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import SwiftUI

struct ActionButton: View {
    let title: LocalizedStringKey
    let style: Style
    
    var body: some View {
        ZStack {
            Rectangle().fill(style.fillColor)
            HStack {
                Text(title).foregroundColor(.white).bold()
                Spacer()
                Image(systemName: style.iconName).foregroundColor(.white)
            }
            .padding()
        }
        .frame(width: 250, height: 44) // consider to use flexible width (e.g depending on screen width)
    }
    
    enum Style {
        case confirm
        case navigate
        
        var fillColor: Color {
            switch self {
            case .confirm:
                return Color.black
            case .navigate:
                return Color.blue
            }
        }
        
        var iconName: String {
            switch self {
            case .confirm:
                return "arrow.up.to.line"
            case .navigate:
                return "arrow.forward"
            }
        }
    }
}
