//
//  RatingView.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 17.09.2021.
//

import SwiftUI

/// RatingView. User can tap to set
struct RatingView: View {
    
    @State private var currentRating: Int = 0
    ///
    var rating: Binding<Int>?
    
    init(initialRating: Int, rating: Binding<Int>?) {
        assert(initialRating >= 0 && initialRating <= 5, "rating should be between 0 and 5")
        self._currentRating = State(initialValue: initialRating)
        self.rating = rating
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 4) {
                ForEach(Range(1...5)) { i in
                    Image(systemName: i <= currentRating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: geometry.size.height, height: geometry.size.height)
                        .onTapGesture {
                            guard rating != nil else { return }
                            currentRating = i
                            rating?.wrappedValue = i
                        }
                }
            }
        }
    }
}
