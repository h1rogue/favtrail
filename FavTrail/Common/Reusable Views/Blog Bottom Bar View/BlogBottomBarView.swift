//
//  BlogBottomBarView.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 07/10/22.
//

import UIKit

class BlogBottomBarView: UIView {
    @IBOutlet weak private var heartImageView: UIImageView!
    @IBOutlet weak private var commentImageView: UIImageView!
    @IBOutlet weak private var shareImageView: UIImageView!
    private var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUIView()
    }
    
    func setupUIView() {
        heartImageView.isUserInteractionEnabled = true
        heartImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onLikedClicked)))
        
        commentImageView.isUserInteractionEnabled = true
        commentImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCommentsClicked)))
        
        shareImageView.isUserInteractionEnabled = true
        shareImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onShareClicked)))
    }
    
    private func setLikeStatus() {
        if isLiked {
            heartImageView.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            self.heartImageView.tintColor = .red
        } else {
            heartImageView.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            self.heartImageView.tintColor = .black
        }
    }
    
    @objc private func onLikedClicked(_ sender: UIButton) {
        isLiked = !isLiked
        setLikeStatus()
    }
    
    @objc private func onCommentsClicked(_ sender: Any) {
    }
    
    @objc private func onShareClicked(_ sender: Any) {
    }
    
    func setupView(isLiked: Bool) {
        self.isLiked = isLiked
        
        setLikeStatus()
    }
}
