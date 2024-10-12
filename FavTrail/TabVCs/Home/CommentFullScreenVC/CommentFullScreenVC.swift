//
//  CommentFullScreenVC.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 25/04/23.
//

import UIKit

class CommentFullScreenVC: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var commentContainerView: UIView!
    @IBOutlet weak private var commentBoxHeight: NSLayoutConstraint!
    @IBOutlet weak private var bottomConstraint: NSLayoutConstraint!
    
    var viewModel: CommentFullScreenViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
        viewModel.viewDidLoad()
    }
    
    private func setupUIView() {
        
        setupNavBar()
        setupCommentView()

        //tableView setup
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: BlogCommentTVC.identifier, bundle: .main), forCellReuseIdentifier: BlogCommentTVC.identifier)
        
        registerKeyboardNotification()
    }
    
    private func setupNavBar() {
        title = "Comments"
        let backButton = UIBarButtonItem(image: UIImage(named: "back_button")?.withTintColor(.green, renderingMode: .alwaysTemplate), style: .plain, target: self, action: #selector(backButtonAction))
        backButton.tintColor = Theme.light.backGroundColor
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupCommentView() {
        guard let commentView = ReusableView.commentInputField.instantiateView() as? CommentInputField else { return }
        commentView.delegate = self
        commentContainerView.addSubview(commentView)
        commentView.translatesAutoresizingMaskIntoConstraints = false
        commentView.fillSuperView()
        commentView.setupView()
    }
    
    private func registerKeyboardNotification() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func backButtonAction() {
        self.dismiss(animated: true)
    }
}

extension CommentFullScreenVC {
    //keyboard implementation
    @objc func keyboardWillShow(notification: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if let userInfo = notification.userInfo, let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = frame.cgRectValue.height
                var timing: TimeInterval = 0.3
                var animationOption: UIView.AnimationOptions = .curveLinear
                if let time = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                    timing = time
                }
                if let option = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
                    animationOption = UIView.AnimationOptions(rawValue: option)
                }
                strongSelf.bottomConstraint.constant = height
                UIView.animate(withDuration: timing, delay: 0, options: animationOption, animations: {[weak self] in
                    self?.view.layoutIfNeeded()
                }, completion: nil)

            }

        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if let userInfo = notification.userInfo {
                var timing: TimeInterval = 0.3
                var animationOption: UIView.AnimationOptions = .curveLinear
                if let time = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                    timing = time
                }
                if let option = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
                    animationOption = UIView.AnimationOptions(rawValue: option)
                }
                strongSelf.bottomConstraint.constant = 0

                UIView.animate(withDuration: timing, delay: 0, options: animationOption, animations: {[weak self] in
                    self?.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }

}

extension CommentFullScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItemsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BlogCommentTVC.identifier, for: indexPath) as? BlogCommentTVC, let model = viewModel.getCellModelForItem(at: indexPath) {
            cell.configure(model: model)
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }

}

extension CommentFullScreenVC: BlogCommentCVCDelegate {
    func didTapLikeButton(value: Bool) {
        //TODO:
    }
}

extension CommentFullScreenVC: CommentFullScreenVMDelegate {
    func refreshCollectionView() {
        tableView.reloadData()
    }
}

extension CommentFullScreenVC: CommentInputFieldDelegate {
    func textViewHeightUpdated(by height: CGFloat) {
        commentBoxHeight.constant += height
        self.view.layoutIfNeeded()
    }
}
