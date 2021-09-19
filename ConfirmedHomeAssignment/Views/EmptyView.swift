//
//  EmptyView.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import SwiftUI

struct EmptyView: View {
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message).multilineTextAlignment(.center)
        }
    }
}
