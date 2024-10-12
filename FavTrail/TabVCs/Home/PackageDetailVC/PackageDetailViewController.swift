//
//  PackageDetailViewController.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/01/23.
//

import UIKit

class PackageDetailViewController: UIViewController, PackageDetailViewProtocol {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var footerView: UIView!
    @IBOutlet weak private var footerLabel: UILabel!
    @IBOutlet weak private var footerButton: UIButton!
    @IBOutlet weak private var footerHeightConstraint: NSLayoutConstraint!
    
    var footerViewHeightConstant: CGFloat = 128
    
    var presenter: PackageDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        footerView.roundCorners([.topLeft, .topRight], radius: 10)
        addShadowToFooterView()
    }
    
    private func addShadowToFooterView() {
        footerView.layer.shadowColor = UIColor.lightGray.cgColor
        footerView.layer.shadowOpacity = 0.2
        footerView.layer.shadowRadius = 6
        footerView.layer.shadowPath = UIBezierPath(rect: footerView.bounds).cgPath
        footerView.layer.shouldRasterize = true
        footerView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupTableView() {
        footerView.backgroundColor = UIColor.init(red: 197/255, green: 217/255, blue: 201/255, alpha: 1)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: PlaceDetailHorizontalTVC.identifier, bundle: .main), forCellReuseIdentifier: PlaceDetailHorizontalTVC.identifier)
        tableView.register(UINib(nibName: PackageDetailHeaderTVC.identifier, bundle: .main), forCellReuseIdentifier: PackageDetailHeaderTVC.identifier)
        tableView.register(UINib(nibName: BlogTVCell.identifier, bundle: .main), forCellReuseIdentifier: BlogTVCell.identifier)
        tableView.register(UINib(nibName: TrendingTVC.identifier, bundle: .main), forCellReuseIdentifier: TrendingTVC.identifier)
        tableView.register(UINib(nibName: RecentUpdatesTVC.identifier, bundle: .main), forCellReuseIdentifier: RecentUpdatesTVC.identifier)
        tableView.register(UINib(nibName: NearbyTravelTVC.identifier, bundle: .main), forCellReuseIdentifier: NearbyTravelTVC.identifier)
        tableView.register(UINib(nibName: PackageTripDetailItineraryTVC.identifier, bundle: .main), forCellReuseIdentifier: PackageTripDetailItineraryTVC.identifier)
    }
    
    func fetchPDSuccessfully() {
        DispatchQueue.main.async {
            self.reloadData()
            self.setupFooterView()
        }
    }
    
    private func setupFooterView() {
        if let footer = presenter?.getFooterModel() {
            footerView.isHidden = false
            footerLabel.attributedText = footer.price.getAttributedString()
            footerButton.setTitle(footer.buttonTitle, for: .normal)
        } else {
            footerView.isHidden = true
        }
    }
    
    
    @IBAction func onBookButtonClick(_ sender: Any) {
        //TODO: delete this part later
        CommentFullScreenBuilder.buildCommentVC(blogId: "", view: self)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension PackageDetailViewController: UITableViewDataSource, UITableViewDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = presenter?.cellModelForRowAtIndex(indexPath: indexPath) else { return UITableViewCell() }
        
        switch cellModel.type {
        case .nearbyTravel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NearbyTravelTVC.identifier, for: indexPath) as? NearbyTravelTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            return cell
        case .recentUpdates:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentUpdatesTVC.identifier, for: indexPath) as? RecentUpdatesTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            return cell
        case .blog:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BlogTVCell.identifier, for: indexPath) as? BlogTVCell else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            return cell
        case .similarTripModel, .resortStay:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceDetailHorizontalTVC.identifier, for: indexPath) as? PlaceDetailHorizontalTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            return cell
        case .packageHeaderCard:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageDetailHeaderTVC.identifier, for: indexPath) as? PackageDetailHeaderTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel)
            return cell
        case .tripItineraryCard:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PackageTripDetailItineraryTVC.identifier, for: indexPath) as? PackageTripDetailItineraryTVC else {
                return UITableViewCell()
            }
            cell.configure(model: cellModel, indexPath: indexPath)
            cell.delegate = self
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension PackageDetailViewController: PackageTripDetailItineraryTVCDelegate {
    func reloadTableViewCell(indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
