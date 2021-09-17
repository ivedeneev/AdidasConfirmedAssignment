//
//  HCenter.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 17.09.2021.
//

import SwiftUI

/// Centers view horizontally
struct HCenter: ViewModifier {

    var backgroundColor: Color = Color(.systemBackground)
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

extension View {
    func centerHorizontally() -> some View {
        self.modifier(HCenter())
    }
}
