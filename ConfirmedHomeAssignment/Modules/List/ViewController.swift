//
//  ViewController.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import UIKit
import SwiftUI
import Combine

protocol ProductListView: AnyObject {
    func didloadProducts(products: [Product])
    func didFailLoadProducts(error: CError)
}

final class ProductListViewController: UIViewController {
    
    var presenter: ProductListPresenter?
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var products = [Product]()
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProductListPresenterImpl()
        presenter?.view = self
        setupCollectionView()
        setupSearchBar()
        presenter?.loadProducts()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: ProductListCell.reuseIdentifier)
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = searchBar
        searchBar.placeholder = NSLocalizedString("search", comment: "")
        searchBar.delegate = self
    }
    
    private func emptyView(with text: String) -> UIView {
        let emptyView = UIHostingController(rootView: EmptyView(message: text))
        emptyView.view.frame = collectionView.bounds
        return emptyView.view
    }
}

extension ProductListViewController: ProductListView {
    func didloadProducts(products: [Product]) {
        self.products = products
        collectionView.reloadData()
        collectionView.backgroundView = products.isEmpty ? emptyView(with: "No products") : nil
    }
    
    func didFailLoadProducts(error: CError) {
        collectionView.backgroundView = emptyView(with: "Error")
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchProducts(query: searchText)
    }
}

extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductListCell.reuseIdentifier,
                for: indexPath
        ) as? ProductListCell else { fatalError() }
        
        cell.configure(viewModel: products[indexPath.row])
        
        return cell
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            navigationController?.pushViewController(
                UIHostingController(
                    rootView: ProductDetailView(
                        viewModel: .init(product: products[indexPath.row])
                    )
                ), animated: true
            )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.bounds.width - Constants.horizontalPadding * 2,
            height: Constants.cellHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

private struct Constants {
    static let horizontalPadding: CGFloat = 8
    static let cellHeight: CGFloat = 160
    static let lineSpacing: CGFloat = 8
}

