//
//  OrthogonalCollectionViewController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 04/11/24.
//
/*
import UIKit

protocol Diffable: AnyObject {
    
}

@MainActor
final class OrthogonalCollectionViewController<SectionType: Hashable & Sendable & CustomStringConvertible, DataType: Hashable & Sendable & CarouselTitle>: UIViewController, UICollectionViewDelegate {
    // MARK: - Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, DataType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, DataType>

    // MARK: - Properties
    var dataSource: DataSource?
    var collectionView: UICollectionView?
    var coordinator: any Coordinator
    private var highlighted: [DataType] = []
    private var sections: [SectionType] = []
    private var elements: [[DataType]] = []

    var numberOfItemsPerSection: Int { 30 }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
    }

    required init?(coder: NSCoder) {
        fatalError("Deprecated in favour of dependency injection")
    }

    init(with coordinator: any Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
}

// MARK: - Inner CollectionView
extension OrthogonalCollectionViewController {
    private func configureHierarchy() {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: OrthogonalCollectionElementKind.layoutHeader, withReuseIdentifier: HomeHeaderView.identifier)
        collectionView.register(SectionTitleHeaderView.self, forSupplementaryViewOfKind: OrthogonalCollectionElementKind.sectionHeader, withReuseIdentifier: SectionTitleHeaderView.identifier)
        collectionView.register(DefaultTitleCell.self, forCellWithReuseIdentifier: DefaultTitleCell.identifier)
        collectionView.backgroundColor = .black
        // TODO: - Add Ranked Title Cells
        // TODO: - Add Spotlight Title Cells
        view.addSubview(collectionView)
        collectionView.delegate = self
        // TODO: - Set up the delegate if needed
        self.collectionView = collectionView
    }

    private func configureDataSource() {
        guard let collectionView else { return }

        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let elements = self?.elements else { return UICollectionViewCell() }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultTitleCell.identifier, for: indexPath) as? DefaultTitleCell else { return UICollectionViewCell() }
            let section = indexPath.section
            let index = indexPath.row
            cell.configure(with: elements[section][index])
            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, sectionIdentifier, sectionIndex in
            switch sectionIdentifier {
            case OrthogonalCollectionElementKind.layoutHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: sectionIdentifier,
                    withReuseIdentifier: HomeHeaderView.identifier,
                    for: sectionIndex) as? HomeHeaderView
                else { return UICollectionReusableView() }
                // TODO: - Add a source to get the highlighted titles
                // header.configure(with: ...)
                return header
            case OrthogonalCollectionElementKind.sectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: sectionIdentifier,
                    withReuseIdentifier: SectionTitleHeaderView.identifier,
                    for: sectionIndex) as? SectionTitleHeaderView
                else { return UICollectionReusableView() }
                guard let sections = self?.sections else { return header }
                header.configure(with: sections[sectionIndex.section].description)
                return header
            default:
                return UICollectionReusableView()
            }
        }
    }

    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(3.0 / 9.0),
                heightDimension: .fractionalHeight(3.0 / 4.0))
            let repeatingItem = NSCollectionLayoutItem(layoutSize: itemSize)
            repeatingItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(3.0 / 10.0))
            let group: NSCollectionLayoutGroup
            if #available(iOS 16.0, *) {
                group = .horizontal(layoutSize: groupSize, repeatingSubitem: repeatingItem, count: 3)
            } else {
                group = .horizontal(layoutSize: groupSize, subitem: repeatingItem, count: 3)
            }
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            let sectionHeader = sectionIndex == 0
            ? NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(9.0 / 10.0)),
                elementKind: OrthogonalCollectionElementKind.layoutHeader,
                alignment: .top)
            : NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(45)),
                elementKind: OrthogonalCollectionElementKind.sectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }, configuration: configuration)

        return layout
    }
}
*/
