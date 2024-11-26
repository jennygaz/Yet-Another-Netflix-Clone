//
//  HomeViewController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 11/10/24.
//

import UIKit

enum HomeSection: String, Hashable, Codable {
    case banner
    case recommendations
    case continueWatching
    case teenTVShows
    case downloadsForYou
    case todaysPicks
    case onlyOnNetflix
    case newOnNetflix
    case bingeworthy
    case topSearches
    case funnyTVAllAges
    case awardWinningShows
    case anime
    case myList
    case watchAgain
    case comedy
    case usMovies
    case tvDramas
    case kidsAndFamily
    case action
    case topTenInYourArea
    case horror
    case japanese
    case realityTV
    case exciting
    case awardWinningMovies
}

enum TitleCategory: String, Codable {
    case comedy
}
struct Title: Hashable, Codable {
    let id: Int
    let name: String
    var categories: [TitleCategory]
    var sections: [HomeSection]
    let imageURL: String
    let releaseDate: Date
}

struct CompactTitle: Hashable, Codable {
    let id: Int
    let name: String
    let imageURL: String
}

final class HomeViewController: UIViewController {
    // MARK: - Types
    private typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, CompactTitle>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, CompactTitle>
    
    // MARK: - Properties
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var sections: [HomeSection] = []
    private var elements: [HomeSection: Set<CompactTitle>] = [:]
    var coordinator: any Coordinator
    var titles: [Title] = []
    var numberOfItemsPerSection: Int {
        30
    }

    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with coordinator: any Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureHierarchy()
        setupCollectionView()
        setupDataSource()
        guard let dataSource else { return }
        sections = [.banner, .action, .anime, .awardWinningShows]
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Public Methods
    func addElements(_ items: [CompactTitle]) {
        guard let dataSource else { return }
        print("wahoo!")
        var snapshot = dataSource.snapshot()
        let pairs = [(HomeSection.action, items.dropLast(60)), (HomeSection.anime, items.dropFirst(30).dropLast(30)), (HomeSection.awardWinningShows,items.dropFirst(60))]
        for pair in pairs {
            if !elements.keys.contains(pair.0) {
                elements[pair.0] = Set()
            }
            elements[pair.0]?.formUnion(pair.1)
            snapshot.appendItems(Array(pair.1), toSection: pair.0)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Private Methods
    private func configureNavBar() {
        let navigationTintColor = UIColor.white.withAlphaComponent(0.75)
        // Netflix Logo
        let netflixLogoImage = UIImage(named: "netflix_n_logo")?.withRenderingMode(.alwaysOriginal)
        let netflixLogoButton = UIBarButtonItem(
            image: netflixLogoImage,
            style: .plain,
            target: nil,
            action: nil)
        netflixLogoButton.customView?.backgroundColor = .clear
        netflixLogoButton.isEnabled = false
        
        // Downloads
        let downloadsIcon = UIImage(systemName: "arrow.down.to.line.alt")?.withRenderingMode(.alwaysTemplate)
        
        var config = UIButton.Configuration.plain()
        config.image = downloadsIcon
        let badgedButton = BadgedUIButton(configuration: config)
        badgedButton.tintColor = navigationTintColor
        let downloadsButton = UIBarButtonItem(customView: badgedButton)
        
        let checkmarkIcon = UIImage(systemName: "checkmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        badgedButton.setBadgeImage(image: checkmarkIcon)
        
        // Search
        let searchIcon = UIImage(systemName: "magnifyingglass")
        config.image = searchIcon
        let searchSubButton = UIButton(configuration: config)
        searchSubButton.tintColor = navigationTintColor
        let searchButton = UIBarButtonItem(customView: searchSubButton)
        
        // Cast to TV
        let castIcon = UIImage(systemName: "tv")?.withRenderingMode(.alwaysTemplate)
        config.image = castIcon
        let castSubButton = UIButton(configuration: config)
        let castButton = UIBarButtonItem(customView: castSubButton)
        castSubButton.tintColor = navigationTintColor
        
        // Add to NavBar
        self.navigationItem.rightBarButtonItems = [searchButton, downloadsButton, castButton]
        self.navigationItem.leftBarButtonItem = netflixLogoButton
        self.navigationController?.navigationBar.backgroundColor = .black.darker()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupCollectionView() {
        
    }
    
    private func setupDataSource() {
        guard let collectionView else { return }

        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultTitleCell.identifier, for: indexPath) as? DefaultTitleCell else { return UICollectionViewCell() }
//            cell.configure(with: CarouselModel(imageName: itemIdentifier.imageURL, text: itemIdentifier.name))
            return cell
        }
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, sectionIdentifier, sectionIndex in
            print("section identifier was \(sectionIdentifier)")
            print("section index was \(sectionIndex) - data source")
            switch sectionIdentifier {
            case OrthogonalCollectionElementKind.layoutHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: sectionIdentifier,
                    withReuseIdentifier: HomeHeaderView.identifier,
                    for: sectionIndex) as? HomeHeaderView
                else { return UICollectionReusableView() }
                // TODO: - Add a source to get the highlighted titles :)
                let mockModel = HighlightMovie(
                    name: "Naruto Shippuden",
                    mainImage: "naruto_hero_view",
                    logo: "naruto_logo",
                    categories: [
                        "Ninja",
                        "Slow Pace",
                        "Fighting",
                        "Edgy",
                        "Dark"
                    ],
                    isListed: true,
                    backgroundColor: .black.withAlphaComponent(0.8))
                header.configure(with: mockModel)
                return header
            case OrthogonalCollectionElementKind.sectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: sectionIdentifier,
                    withReuseIdentifier: SectionTitleHeaderView.identifier,
                    for: sectionIndex) as? SectionTitleHeaderView
                else { return UICollectionReusableView() }
                guard let sections = self?.sections else { return header }
                header.configure(with: sections[sectionIndex.section].rawValue)
                return header
            default:
                return UICollectionReusableView()
            }
        }
    }

    private func configureHierarchy() {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(HomeHeaderView.self, forSupplementaryViewOfKind: OrthogonalCollectionElementKind.layoutHeader, withReuseIdentifier: HomeHeaderView.identifier)
        collectionView.register(SectionTitleHeaderView.self, forSupplementaryViewOfKind: OrthogonalCollectionElementKind.sectionHeader, withReuseIdentifier: SectionTitleHeaderView.identifier)
        collectionView.register(DefaultTitleCell.self, forCellWithReuseIdentifier: DefaultTitleCell.identifier)
        collectionView.backgroundColor = .black
        // TODO: - Register Collection View Cell and Collection View Section Headers
        view.addSubview(collectionView)
        collectionView.delegate = self
        self.collectionView = collectionView
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
            // TODO: - Ensure the Banner is always Section Index 0, add a mechanism to handle it
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
        }, configuration: configuration) // TODO: - Update the configuration

        return layout
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

@available(iOS 17, *)
#Preview("Home View Controller") {
    var items: [CompactTitle] = []
    items.reserveCapacity(90)
    for i in 1...90 {
        items.append(CompactTitle(id: i, name: "Naruto Shippuden", imageURL: "naruto_hero_view"))
    }
    let nc = UINavigationController()
    let launchCoordinator = LaunchCoordinator(navigationController: nc)
    let vc = HomeViewController(with: launchCoordinator)
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
        vc.addElements(items)
    }
    return vc
}
