//
//  ProductDetailView.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import Combine
import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    @ObservedObject var viewModel: ProductDetailViewModel
    @State private var showCreateReview = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            List {
                WebImage(url: viewModel.productImage)
                    .resizable()
                    .placeholder(Image(systemName: "photo")) // Placeholder Image
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity) // Activity Indicator
                    .transition(.fade(duration: 0.5)) // Fade Transition with duration
                    .scaledToFill()
                    .listSeparatorNone()
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(viewModel.productName).font(.title)
                        Spacer()
                        Text(viewModel.productPrice)
                            .font(.price)
                        Spacer()
                    }
                    Text(viewModel.productDescription).font(.body)
                }
                .padding()
                .listSeparatorNone()
                
                if viewModel.isLoading {
                    ActivityIndicator()
                        .centerHorizontally()
                        .listSeparatorNone()
                    
                } else {
                    if viewModel.reviews.isEmpty {
                        Text("no_reviews")
                            .centerHorizontally()
                            .listSeparatorNone()
                    } else {
                        Text("\(viewModel.reviews.count) number_of_reviews").font(.header)
                        ForEach(viewModel.reviews) { review in
                            ReviewView(review: review)
                        }
                        .listSeparatorNone()
                    }
                }
            }
            
        }.onAppear {
            // MVP implementation. We should consider to reload reviews more efficiently
            viewModel.loadReviews()
        }
        
        NavigationLink(
            destination: CreateReviewView(viewModel: CreateReviewViewModel(productId: viewModel.productId)),
            label: {
                ActionButton(title: "add_review", style: .navigate)
            })
            .centerHorizontally()
    }
}
