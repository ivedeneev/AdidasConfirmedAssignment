//
//  CreateReviewView.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import SwiftUI
import Combine

struct CreateReviewView: View {
    
    @State var currentRating: Int = 0
    @State private var message: String = ""
    @State private var textStyle: UIFont.TextStyle = .body
    @ObservedObject var viewModel: CreateReviewViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("add_review").font(.title)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("create_review.rating_title").font(.caption).foregroundColor(.gray)
                RatingView(initialRating: 0, rating: $currentRating).frame(height: 28)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("create_review.message_title").font(.caption).foregroundColor(.gray)
                TextView(text: $message, textStyle: $textStyle).border(Color.gray)//we need to support ios13, so we cant use TextEditor
            }
            
            VStack(alignment: .center) {
                if viewModel.isLoading {
                    ActivityIndicator().centerHorizontally()
                } else if viewModel.sentReview != nil {
                    HStack {
                        Text("review_was_sent")
                        Spacer()
                        Button("Got back") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }.padding()
                } else {
                    if viewModel.isErrorPresented {
                        HStack {
                            Text(viewModel.error!)
                            Spacer()
                            Button("Got it") {
                                viewModel.isErrorPresented = false //TODO: animation
                            }
                        }.padding()
                    }
                    ActionButton(title: "submit", style: .confirm)
                        .onTapGesture {
                            viewModel.sendReiew(text: message, rating: currentRating)
                        }
                        .centerHorizontally()
                }
            }
        }
        .padding()
        
    }
}
