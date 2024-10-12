//
//  HomeUserFeedTVCTableViewCell.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 02/08/22.
//

import UIKit
import SDWebImage

protocol BlogTVCellDelegate: AnyObject {
    func presentImageScroller(itemIndex: Int, contentList: [String])
    func presentBlogDetailVC(blogId: String)
    func presentCommentVC(blogId: String)
}

class BlogTVCell: UITableViewCell {
    
    @IBOutlet weak private var shadowContainerView: UIView!
    @IBOutlet weak private var userInfoStackInfo: UIStackView!
    @IBOutlet weak private var dotImageView: UIImageView!
    @IBOutlet weak private var userDataView: UIStackView!
    @IBOutlet weak private var likesLabel: UILabel!
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var reactionButtonStackView: UIStackView!
    @IBOutlet weak private var likeButtonImage: UIImageView!
    @IBOutlet weak private var commentButtonImage: UIImageView!
    @IBOutlet weak private var shareButtonImage: UIImageView!
    @IBOutlet weak private var detailsButton: UIButton!
    @IBOutlet weak private var blogContentView: UIView!
    
    var model: BlogContentModel?
    weak var delegate: BlogTVCellDelegate?
    var blogPostView: BlogPostView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowContainerView.addDefaultCornerRadius(6)
        addShadowToContainerView()
    }
    
    private func setupCellView() {
        self.likesLabel.font = UIFont.poppinsRegular(size: 11)
        self.commentLabel.font = UIFont.poppinsRegular(size: 11)
        self.likeButtonImage.isUserInteractionEnabled = true
        self.commentButtonImage.isUserInteractionEnabled = true
        self.shareButtonImage.isUserInteractionEnabled = true
        
        likeButtonImage.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        commentButtonImage.image = UIImage(systemName: "text.bubble")
        shareButtonImage.image = UIImage(systemName: "arrowshape.turn.up.right")
        
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        likeButtonImage.addGestureRecognizer(likeTapGesture)
        
        let commentGesture = UITapGestureRecognizer(target: self, action: #selector(commentButtonTapped))
        commentButtonImage.addGestureRecognizer(commentGesture)
        
        let shareGesture = UITapGestureRecognizer(target: self, action: #selector(shareButtonTapped))
        shareButtonImage.addGestureRecognizer(shareGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openBlogDetailAction))
        tapGesture.delegate = self
        blogContentView.addGestureRecognizer(tapGesture)
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let blogPostView = blogPostView,
           blogPostView.getCollectionViewFrame().contains(touch.location(in: blogPostView)) {
            return false
        }
        return true
    }
    
    @objc private func likeButtonTapped() {
        guard var dummyModel = model else {
            return
        }

        model?.statsInfo.isLiked = !dummyModel.statsInfo.isLiked
        configureLikeButton()
    }
    
    @objc private func commentButtonTapped() {
        //TODO: add blog ID later
        delegate?.presentCommentVC(blogId: "")
    }
    
    @objc private func shareButtonTapped() {
        
    }
    
    @objc private func openBlogDetailAction() {
        delegate?.presentBlogDetailVC(blogId:"") //TODO: revert
    }
    
    
    @IBAction func onClickDetailButton(_ sender: Any) {
        
    }
    
    private func addShadowToContainerView() {
        shadowContainerView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowContainerView.layer.shadowOpacity = 0.2
        shadowContainerView.layer.shadowOffset = .zero
        shadowContainerView.layer.shadowRadius = 6
        shadowContainerView.layer.shadowPath = UIBezierPath(rect: shadowContainerView.bounds).cgPath
        shadowContainerView.layer.shouldRasterize = true
        shadowContainerView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func configureLikeButton() {
        guard let model = model else { return }
        
        if model.statsInfo.isLiked {
            self.likeButtonImage.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            self.likeButtonImage.tintColor = .red
        } else {
            self.likeButtonImage.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            self.likeButtonImage.tintColor = .black
        }
    }
    
    private func configureUserDataView() {
        guard let userData = model?.blogData else { return }
        
        guard let view = ReusableView.blogPostView.instantiateView() as? BlogPostView else { return }
        view.configureView(model: userData)
        view.delegate = self
        blogPostView = view
        userDataView.removeAllArrangedStackView()
        userDataView.addArrangedSubview(view)

    }
    
    private func configureUserInfoView() {
        guard let userInfo = model?.userInfo, let postTime = model?.postTime, let view = ReusableView.userInfoView.instantiateView() as? UserInfoView else { return }
        view.configureView(model: userInfo, postTime: postTime)
        userInfoStackInfo.removeAllArrangedStackView()
        userInfoStackInfo.addArrangedSubview(view)
    }
    
    func configure(model: HomeGenericObjectModel) {
        guard let model = model.objects.first as? BlogContentModel else { return }
        self.likesLabel.attributedText = model.statsInfo.numberOfLikes.getAttributedString()
        self.commentLabel.attributedText = model.statsInfo.numberOfComments.getAttributedString()
        self.model = model
        configureUserInfoView()
        configureLikeButton()
        configureUserDataView()
    }
}

extension BlogTVCell: BlogPostViewDelegate {
    func didTapView(itemIndex: Int) {
        if let contentList = model?.blogData.images {
            delegate?.presentImageScroller(itemIndex: itemIndex, contentList: contentList)
        }
    }
}
