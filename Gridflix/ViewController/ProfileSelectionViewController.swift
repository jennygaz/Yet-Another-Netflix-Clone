//
//  ProfileSelectionViewController.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 17/09/24.
//

import UIKit

final class ProfileSelectionViewController: UIViewController {
    // MARK: - Typealias
    private typealias DataSource = UICollectionViewDiffableDataSource<ProfileSection, ProfileItem>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileItem>

    // MARK: - Properties
    private var collectionLabel: UILabel!
    private var collectionView: UICollectionView!
    private var dataSource: DataSource? {
        didSet { loadingIndicator.stopAnimating() }
    }
    private var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    var coordinator: any Coordinator
    
    var profiles: [ProfileItem] = [] {
        didSet { addItems() }
    }

    // MARK: - Lifetime
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(with coordinator: any Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoader()
        configureNavBar()
        configureCollectionView()
        configureDataSource()
    }

    // MARK: - Private Methods
    private func configureLoader() {
        view.addSubview(loadingIndicator)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.color = .systemGray
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loadingIndicator.startAnimating()
    }

    private func configureNavBar() {
        // TODO: - Refactor asset management
        // Netflix Logo
        let netflixLogoImage = UIImage(named: "netflix_logo")
        let netflixLogoView = UIImageView(image: netflixLogoImage)
        netflixLogoView.contentMode = .scaleAspectFit
        netflixLogoView.backgroundColor = .clear
        
        self.navigationItem.titleView = netflixLogoView
        // Profile Edit Button
        let editIcon = UIImage(named: "custom.pencil.edit")?
            .withTintColor(.white, renderingMode: .alwaysTemplate)
        let editProfilesButton = UIBarButtonItem(
            image: editIcon,
            style: .plain,
            target: nil,
            action: nil)
        editProfilesButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = editProfilesButton

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureCollectionView() {
        collectionLabel = UILabel(frame: view.frame)
        collectionLabel.text = "Who's watching?"
        collectionLabel.font = .preferredFont(forTextStyle: .title2)
        collectionLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionLabel.textColor = .white
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collectionLabel)
        
        collectionView.backgroundColor = view.backgroundColor
        collectionView.register(ProfileItemViewCell.self, forCellWithReuseIdentifier: ProfileItemViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: self.navigationItem.titleView!.frame.height + 50),
            collectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor, constant: 12),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 7 * view.frame.height / 10),
            collectionView.widthAnchor.constraint(equalToConstant: 2 * view.frame.width / 3)
        ])
        collectionLabel.sizeToFit()
        view.bringSubviewToFront(loadingIndicator)
    }

    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier -> ProfileItemViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileItemViewCell.reuseIdentifier, for: indexPath) as? ProfileItemViewCell
            else { return ProfileItemViewCell() }
            let profile = self.profiles[indexPath.row]
            cell.configure(
                with: profile.name,
                color: profile.color)
            if profile.type == .default {
                cell.makeDefault()
            }
            return cell
        }
        addItems()
    }

    private func addItems() {
        addNewProfileButton()
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(profiles)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func addNewProfileButton() {
        if profiles.count < 5 && !profiles.contains(where: { $0.type == .default} ) {
            profiles.append(ProfileItem(name: "", color: .black, type: .default))
        }
    }
}

// MARK: - Navigation
extension ProfileSelectionViewController {
    public func present(with profile: ProfileItem) {
        switch profile.type {
        case .custom:
            return
        case .default:
            return
        }
    }

    public func presentAddProfileSheet() {
        
    }

    public func presentHomeView(for profile: ProfileItem) {
        
    }
}

@available(iOS 17, *)
#Preview("Profile Selection") {
    let nc = UINavigationController()
    let profileCoordinator = ProfileCoordinator(navigationController: nc)
    let vc = ProfileSelectionViewController(with: profileCoordinator)
    let items: [ProfileItem] = [
        .init(name: "Jenny", color: .systemPink),
        .init(name: "Isita", color: .systemRed),
        .init(name: "David", color: .systemBlue),
        .init(name: "TV", color: .systemGreen)
    ]
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        vc.profiles = items
    }
    return vc
}
