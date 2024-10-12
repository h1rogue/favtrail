//
//  HomeVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import UIKit

class HomeVC: UIViewController, HomeViewProtocol, ImageScrollerVCDelegate {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak private var topNavigationBar: NavigationBarView!
    
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startActivityIndicator()
        presenter?.viewDidLoad()
    }
    
    func startActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.contentInset.top = 20
        registerCells()
        
        topNavigationBar.configure(with: self)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: BlogTVCell.identifier, bundle: .main), forCellReuseIdentifier: BlogTVCell.identifier)
        tableView.register(UINib(nibName: TrendingTVC.identifier, bundle: .main), forCellReuseIdentifier: TrendingTVC.identifier)
        tableView.register(UINib(nibName: RecentUpdatesTVC.identifier, bundle: .main), forCellReuseIdentifier: RecentUpdatesTVC.identifier)
        tableView.register(UINib(nibName: NearbyTravelTVC.identifier, bundle: .main), forCellReuseIdentifier: NearbyTravelTVC.identifier)
    }
    
    func setupTabBarItem() {
        let unselectedImage = UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
        self.tabBarItem = UITabBarItem(title: MainTabBarControllerItems.home.rawValue, image: unselectedImage, selectedImage: selectedImage)
    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = presenter?.cellModelForRowAtIndex(indexPath: indexPath) else { return UITableViewCell() }
        
        switch cellModel.type {
        case .trending:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTVC.identifier, for: indexPath) as? TrendingTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            cell.delegate = self
            return cell
        case .nearbyTravel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NearbyTravelTVC.identifier, for: indexPath) as? NearbyTravelTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            cell.delegate = self
            return cell
        case .recentUpdates:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentUpdatesTVC.identifier, for: indexPath) as? RecentUpdatesTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            cell.delegate = self
            return cell
        case .blog:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogTVCell.identifier, for: indexPath) as? BlogTVCell else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            cell.delegate = self
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension HomeVC {
    func fetchedHomeDataSuccessfully() {
        DispatchQueue.main.async {
            self.stopActivityIndicator()
            self.reloadData()
        }
    }
}

///Blog TVC delegates
extension HomeVC: BlogTVCellDelegate {
    func presentCommentVC(blogId: String) {
        presenter?.presentBlogCommentVC(blogId: blogId, view: self)
    }
    
    func presentBlogDetailVC(blogId: String) {
        presenter?.presentBlogDetailVC(blogId: blogId, view: self)
    }
    
    func presentImageScroller(itemIndex: Int, contentList: [String]) {
        presenter?.presentImageScrollerVC(itemIndex: itemIndex, delegate: self, contentList: contentList, view: self)
    }
}


extension HomeVC: GenericHomeFullCardClickDelegate {
    func onCardClick(blogId: String) {
        //TODO make this generic later> (MUST)
        presenter?.presentBlogDetailVC(blogId: blogId, view: self)
    }
}

///Nav bar delegate
extension HomeVC: NavigationBarViewDelegate {
    func seachButtonTap() {
        presenter?.searchButtonTapped(view: self)
    }
}


