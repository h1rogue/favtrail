//
//  PlaceDetailVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/12/22.
//

import UIKit

class PlaceDetailVC: UIViewController, PlaceDetailViewProtocol, ImageScrollerVCDelegate {
    
    @IBOutlet weak private var tableView: UITableView!
    
    var presenter: PlaceDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: PlaceDetailHorizontalTVC.identifier, bundle: .main), forCellReuseIdentifier: PlaceDetailHorizontalTVC.identifier)
        tableView.register(UINib(nibName: PlaceDetailHeaderTVC.identifier, bundle: .main), forCellReuseIdentifier: PlaceDetailHeaderTVC.identifier)
        
        tableView.register(UINib(nibName: BlogTVCell.identifier, bundle: .main), forCellReuseIdentifier: BlogTVCell.identifier)
        tableView.register(UINib(nibName: TrendingTVC.identifier, bundle: .main), forCellReuseIdentifier: TrendingTVC.identifier)
        tableView.register(UINib(nibName: RecentUpdatesTVC.identifier, bundle: .main), forCellReuseIdentifier: RecentUpdatesTVC.identifier)
        tableView.register(UINib(nibName: NearbyTravelTVC.identifier, bundle: .main), forCellReuseIdentifier: NearbyTravelTVC.identifier)
    }
    
    func fetchPDSuccessfully() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension PlaceDetailVC: UITableViewDataSource, UITableViewDelegate {
    
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
            cell.delegate = self
            return cell
        case .cafePDCard:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceDetailHorizontalTVC.identifier, for: indexPath) as? PlaceDetailHorizontalTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            cell.delegate = self
            return cell
        case .resortStay:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceDetailHorizontalTVC.identifier, for: indexPath) as? PlaceDetailHorizontalTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            cell.delegate = self
            return cell
        case .curatedVideo:
            return UITableViewCell() //TODO: do this later
        case .qnaCard:
            return UITableViewCell() //TODO: do this later
        case .headerPDCard:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceDetailHeaderTVC.identifier, for: indexPath) as? PlaceDetailHeaderTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
}

extension PlaceDetailVC: GenericHomeFullCardClickDelegate {
    func onCardClick(blogId: String) {
        //TODO change this later.
        presenter?.presentBlogDetailVC(blogId: blogId, view: self)
    }
}

extension PlaceDetailVC: BlogTVCellDelegate {
    
    func presentCommentVC(blogId: String) {
        presenter?.presentBlogCommentVC(blogId: blogId, view: self)
    }
    
    func presentImageScroller(itemIndex: Int, contentList: [String]) {
        presenter?.presentImageScrollerVC(itemIndex: itemIndex, delegate: self, contentList: contentList, view: self)
    }
    
    func presentBlogDetailVC(blogId: String) {
        presenter?.presentBlogDetailVC(blogId: blogId, view: self)
    }
}
