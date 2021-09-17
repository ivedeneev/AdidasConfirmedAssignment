//
//  ReviewView.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import SwiftUI

struct ReviewView: View {
    
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            RatingView(initialRating: review.rating, rating: nil)
                .frame(height: 14)
            
            Text(review.text)
                .font(.body)
        }
        .padding(EdgeInsets(top: 6, leading: 16, bottom: 4, trailing: 16))
    }
}
