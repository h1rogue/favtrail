//
//  CommentInputField.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 04/05/23.
//

import UIKit

protocol CommentInputFieldDelegate: AnyObject {
    func textViewHeightUpdated(by height: CGFloat)
}

class CommentInputField: UIView {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var inputFiled: UIView!
    
    weak var delegate: CommentInputFieldDelegate?
    
    private lazy var commentTextField: CustomInputField = {
        let aboutField = ReusableView.customInputField.instantiateView() as! CustomInputField
        aboutField.delegate = self
        aboutField.configureView(labelTitle: nil, tfPlaceHolder: "write your comment here")
        return aboutField
    }()
    
    func setupView() {
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendButtonTapped)))
        inputFiled.addSubview(commentTextField)
        commentTextField.fillSuperView()
    }
    
    @objc private func sendButtonTapped() {
        // TODO: get textView.text
    }
}

extension CommentInputField: CustomInputFieldDelegate {
    func textViewHeightDidChange(height: CGFloat) {
        delegate?.textViewHeightUpdated(by: height)
    }
}
