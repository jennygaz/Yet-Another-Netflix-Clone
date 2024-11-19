//
//  OrthogonalCollectionViewController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 04/11/24.
//
import UIKit

@MainActor
final class OrthogonalCollectionViewController<SectionType: Hashable & Sendable, DataType: Hashable & Sendable>: UIViewController {
    // MARK: - Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, DataType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, DataType>

    // MARK: - Properties
    var dataSource: DataSource?
    var collectionView: UICollectionView?
    private var elements: [String: Set<String>] = [:]

    var totalNumberOfSections: Int {
        elements.keys.count
    }

    var numberOfItemsPerSection: Int {
        30
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }
}

extension OrthogonalCollectionViewController {
    private func configureHierarchy() {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeHeaderView.identifier)
        collectionView.register(SectionTitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionTitleHeaderView.identifier)
        // TODO: - Register Collection View Cell and Collection View Section Headers
        view.addSubview(collectionView)
        // TODO: - Set up the delegate if needed
        self.collectionView = collectionView
    }

    private func configureDataSource() {
        guard let collectionView else { return }
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselItemView.identifier, for: indexPath) as? CarouselItemView else { return UICollectionViewCell() }
//            cell.configure(with: CarouselModel()) // TODO: - Fix the configure part with a Cell used for both games and movies, add styles!
            return cell
        }
        dataSource?.supplementaryViewProvider = { collectionView, sectionIdentifier, sectionIndex in
            guard sectionIndex.row == 0 else {
                // TODO: - Change the title according to the sectionIndex
                let header = SectionTitleHeaderView()
                header.configure(with: sectionIdentifier)
                return header
            }
            let header = HomeHeaderView()
            // TODO: - Add Model according to the section
            return header
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 3.0),
                heightDimension: .fractionalHeight(1.0))
            let repeatingItem = NSCollectionLayoutItem(layoutSize: itemSize)
            repeatingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(85.0 / 100.0),
                heightDimension: .fractionalHeight(1.0 / 3.0))
            let group: NSCollectionLayoutGroup
            if #available(iOS 16.0, *) {
                group = .horizontal(layoutSize: groupSize, repeatingSubitem: repeatingItem, count: self.numberOfItemsPerSection)
            } else {
                group = .horizontal(layoutSize: groupSize, subitem: repeatingItem, count: self.numberOfItemsPerSection)
            }
            // TODO: - Add check to the SectionIndex to see what kind of layout to use
            let section = NSCollectionLayoutSection(group: group)
            return section
        }, configuration: configuration) // TODO: - Update the configuration

        return layout
    }
}

struct OrthogonalCollectionElementKind {
    static let sectionBanner = "section-banner-element-kind"
    static let sectionHeader = "section-header-element-kind"
    static let layoutHeader  = "layout-header-element-kind"
}
