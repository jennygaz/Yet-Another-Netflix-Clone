//
//  NiblessCollectionView.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 13/09/24.
//

import UIKit
import SwiftUI

class GridCollectionView: NiblessViewController, UICollectionViewDelegate {
    // MARK: - Identifiers and Typealias
    private let reuseIdentifier = "GenericGridCell"
    internal typealias DataSource = UICollectionViewDiffableDataSource<GridSection, UIColor>
    internal typealias Snapshot = NSDiffableDataSourceSnapshot<GridSection, UIColor>

    // MARK: - Properties
    var collectionView: UICollectionView?
    var dataSource: DataSource?
    var elements: [UIColor]

    // MARK: - Lifetime
    init(elements: [UIColor]) {
        self.elements = elements
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        configureCollectionView()
        configureDataSource()
    }

    // MARK: - Private Methods
    private func configureCollectionView() {
        let layout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(GridCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
        self.collectionView = collectionView
    }

    private func configureDataSource() {
        guard let collectionView else { fatalError("Unable to configure data source") }
        self.dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, element in
            guard let reuseIdentifier = self?.reuseIdentifier
            else { return UICollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GridCollectionViewCell
            else { return GridCollectionViewCell() }
            
            cell.color = element
//            cell.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 2
            cell.contentView.layer.cornerRadius = 12
            
            return cell
        }

        var snapshot = Snapshot()
        snapshot.appendSections(GridSection.allCases)
        snapshot.appendItems(elements)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return elements.count
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

@available(iOS 17, *)
#Preview("UIKit") {
    let swiftUIViews = [UIColor.systemRed, UIColor.systemYellow, UIColor.systemBlue, UIColor.systemGreen]
    let vc = GridCollectionView(elements: swiftUIViews)
    let nc = UINavigationController(rootViewController: vc)
    nc.view.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
    return nc
}
