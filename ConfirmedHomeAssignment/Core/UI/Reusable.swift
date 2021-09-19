//
//  Reusable.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 17.09.2021.
//

import UIKit

protocol ReusableCell {
    associatedtype ViewModel
    static var reuseIdentifier: String { get }
    func configure(viewModel: ViewModel)
}

extension ReusableCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
