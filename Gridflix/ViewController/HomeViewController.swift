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

@MainActor
final class HomeViewController: UIViewController {
    // MARK: - Types
    private typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, Title>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<HomeSection, Title>
    
    // MARK: - Properties
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
    private var sections: [HomeSection] = []
    private var elements: [[Title]] = []
    private var highlighted: Title = .placeholder
    var coordinator: any Coordinator
    var numberOfItemsPerSection: Int { 30 }
    var presenter: HomeViewPresenter?

    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with coordinator: any Coordinator, baseSections sections: [HomeSection] = [], baseElements elements: [[Title]] = []) {
        self.coordinator = coordinator
        self.sections = sections
        self.elements = elements
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureHierarchy()
        setupDataSource()
        presenter?.loadHomeData()
        guard let dataSource else { return }
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.banner] + sections)
        if !elements.isEmpty {
            for (section, elementList) in zip(sections, elements) {
                snapshot.appendItems(elementList, toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // MARK: - Public Methods
    // MARK: - Diffing & Public Interaction
    public func addItems(_ items: [Title], toSection section: HomeSection) {
        guard let dataSource, section != .banner else { return }
        var snapshot = dataSource.snapshot()
        let uniqueItems = Set(items)
        guard let sectionIndex = sections.firstIndex(of: section) else {
            sections.append(section)
            elements.append(Array(uniqueItems))
            snapshot.appendSections([section])
            snapshot.appendItems(Array(uniqueItems), toSection: section)
            dataSource.apply(snapshot, animatingDifferences: true)
            return
        }

        let uniqueItemsToAppend = uniqueItems
            .subtracting(Set(elements[sectionIndex]))
            .map { $0 }
        elements[sectionIndex].append(contentsOf: uniqueItemsToAppend)
        snapshot.appendItems(uniqueItemsToAppend, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    public func removeItems(_ items: [Title], fromSection section: HomeSection) {
        guard let dataSource, section != .banner,
              let sectionIndex = sections.firstIndex(of: section)
        else { return }
        var snapshot: Snapshot = dataSource.snapshot()
        let uniqueItems = Set(items).intersection(elements[sectionIndex])
        snapshot.deleteItems(Array(uniqueItems))
        elements[sectionIndex].removeAll(where: { uniqueItems.contains($0) })
        if elements[sectionIndex].isEmpty {
            snapshot.deleteSections([section])
            elements.remove(at: sectionIndex)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    public func removeAllItems(fromSection section: HomeSection) {
        guard let dataSource, section != .banner,
              let sectionIndex = sections.firstIndex(of: section)
        else { return }
        var snapshot: Snapshot = dataSource.snapshot()
        sections.remove(at: sectionIndex)
        elements.remove(at: sectionIndex)
        snapshot.deleteSections([section])
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    public func updateItems(_ items: [Title], atSection section: HomeSection) {
        guard let dataSource, section != .banner,
              let sectionIndex = sections.firstIndex(of: section)
        else { return }
        var snapshot: Snapshot = dataSource.snapshot()
        let uniqueItems = Array(Set(items))
        let itemsToReplace = elements[sectionIndex]
        snapshot.deleteItems(itemsToReplace)
        snapshot.appendItems(uniqueItems, toSection: section)
        elements[sectionIndex] = uniqueItems
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    public func makeRandomHighlightedTitle() {
        guard let newTitle = elements.flatMap({ $0 }).randomElement() else { return }
        self.highlighted = newTitle
    }

    // TODO: - Add public methods to add badges
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
    
    private func setupDataSource() {
        guard let collectionView else { return }

        dataSource = DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultTitleCell.identifier, for: indexPath) as? DefaultTitleCell else { return UICollectionViewCell() }
            let sectionIndex = indexPath.section
            guard let elements = self?.elements else { return UICollectionViewCell() }
            cell.configure(with: elements[sectionIndex - 1][indexPath.row])
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
                // TODO: - Add a source to get the highlighted titles :)
                // TODO: - Get the highlighted title quickly
                guard let self else { return UICollectionReusableView() }
                header.configure(with: self.highlighted)
                return header
            case OrthogonalCollectionElementKind.sectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: sectionIdentifier,
                    withReuseIdentifier: SectionTitleHeaderView.identifier,
                    for: sectionIndex) as? SectionTitleHeaderView
                else { return UICollectionReusableView() }
                guard let sections = self?.sections else { return header }
                header.configure(with: sections[sectionIndex.section - 1].rawValue)
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
        // TODO: - Add Ranked Title Cells
        // TODO: - Add Spotlight Title Cells
        view.addSubview(collectionView)
        collectionView.delegate = self
        // TODO: - Set up the delegate if needed
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

extension HomeViewController: UICollectionViewDelegate {
    
}

@available(iOS 17, *)
#Preview("Home View Controller") {
    var items = (1...90).map {
        Title(id: $0, mediaType: "TV Series", name: "Naruto Shippuden", title: "Naruto Shippuden", posterURL: "naruto_hero_view", description: "The journey of a ninja starts now!", voteCount: 29013, voteAverage: 12.3, releaseDate: .now)
    }
    let coordinator = PreviewCoordinator()
    let vc = HomeViewController(with: coordinator)
    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
        vc.addItems(Array(items[0..<30]), toSection: .exciting)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
        vc.addItems(Array(items[30..<60]), toSection: .funnyTVAllAges)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 14) {
        vc.addItems(Array(items[60...]), toSection: .comedy)
    }
    return vc
}
