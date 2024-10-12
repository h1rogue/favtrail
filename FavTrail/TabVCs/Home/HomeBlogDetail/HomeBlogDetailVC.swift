//
//  HomeBlogDetailVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 29/09/22.
//

import UIKit

class HomeBlogDetailVC: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var bottomBarStackView: UIStackView!
    @IBOutlet weak private var stackContainerView: UIView!
    @IBOutlet weak private var bottomBarHeightConstraint: NSLayoutConstraint!
    private var defaultBottomBarHeight: CGFloat!
    
    private var viewModel: HomeBlogDetailVM!
    private var lastOffset: CGPoint = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        viewModel.delegate = self
        setupTableView()
        setupBottomBar()
        viewModel.fetchBlogDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackContainerView.addShadowToView()
    }
    
    private func setupBottomBar() {
        guard let view = ReusableView.blogBottomBarView.instantiateView() as? BlogBottomBarView else { return }
        bottomBarStackView.addArrangedSubview(view)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
        
        self.defaultBottomBarHeight = (UIScreen.main.bounds.height - (keyWindow?.safeAreaLayoutGuide.layoutFrame.maxY ?? 0.0)) + 30
        bottomBarHeightConstraint.constant = self.defaultBottomBarHeight

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func configureVM(viewModel: HomeBlogDetailVM) {
        self.viewModel = viewModel
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: HomeBlogDetailImageTVC.identifier, bundle: .main), forCellReuseIdentifier: HomeBlogDetailImageTVC.identifier)
        tableView.register(UINib(nibName: HomeBlogDetailTextTVC.identifier, bundle: .main), forCellReuseIdentifier: HomeBlogDetailTextTVC.identifier)
    }
}

extension HomeBlogDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel.cellForRowAtIndexPath(indexPathRow: indexPath.row) else { return UITableViewCell() }
        switch cellModel.dataType {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeBlogDetailImageTVC.identifier, for: indexPath) as? HomeBlogDetailImageTVC {
                cell.configure(image: cellModel.data)
                return cell
            }
        case .text:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HomeBlogDetailTextTVC.identifier, for: indexPath) as? HomeBlogDetailTextTVC {
                cell.configure(text: cellModel.data)
                return cell
            }
        }
    
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDirectionTuple = scrollView.getCurrentScrollDirection(lastOffset: lastOffset)
        lastOffset = scrollDirectionTuple.1
        switch scrollDirectionTuple.0 {
        case .up:
            self.tableView.contentInset.bottom = defaultBottomBarHeight
            self.view.layoutIfNeeded()
            
            self.bottomBarHeightConstraint.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0.1) {
                self.view.layoutIfNeeded()
            }
        case .down:
            self.tableView.contentInset.bottom = 0
            self.view.layoutIfNeeded()
            
            self.bottomBarHeightConstraint.constant = defaultBottomBarHeight
            UIView.animate(withDuration: 0.3, delay: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

extension HomeBlogDetailVC: HomeBlogDetailVMDelegate {
    func refreshTable() {
        tableView.reloadData()
    }
}
