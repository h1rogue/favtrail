//
//  CustomInputField.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 09/10/22.
//

import UIKit

protocol CustomInputFieldDelegate: AnyObject {
    func textViewHeightDidChange(height: CGFloat)
}

class CustomInputField: UIView {
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var label: UILabel!
    @IBOutlet weak private var warningLabel: UILabel!
   
    @IBOutlet weak private var textView: UITextView!
    @IBOutlet weak private var placeHolderText: UILabel!
    @IBOutlet weak private var textViewParent: UIView!
    
    @IBOutlet weak private var tfInput: UITextField!
    @IBOutlet weak private var tfParent: UIView!
    
    var isMandatoryField: Bool = false
    
    private let textViewHeightMax: CGFloat = 200.0
    private let textViewHeightMin: CGFloat = 80.0
    
    private var contentHeight: CGFloat = 0.0
    
    private var text: String = ""
    
    weak var delegate: CustomInputFieldDelegate?
    
    func configureView(labelTitle: String?, tfPlaceHolder: String, isSingleLine: Bool = false) {
        self.label.font = UIFont.poppinsMedium(size: 14)
        self.warningLabel.font = UIFont.poppinsBold(size: 10)
        
        if let title = labelTitle {
            self.label.text = labelTitle
        } else {
            self.label.isHidden = true
        }
        self.warningLabel.isHidden = true
        
        if isSingleLine {
            self.textViewParent.isHidden = true
            
            self.tfInput.isHidden = false
            self.tfInput.placeholder = tfPlaceHolder
            self.tfInput.font = UIFont.poppinsRegular(size: 16)
            self.tfInput.textColor = UIColor.darkGray
            self.tfInput.tintColor = Theme.light.backGroundColor
            self.tfInput.delegate = self
        } else {
            self.tfParent.isHidden = true
            
            self.textViewParent.isHidden = false
            self.textViewParent.backgroundColor = Theme.light.backGroundColor.withAlphaComponent(0.3)
            self.textView.font = UIFont.poppinsRegular(size: 16)
            self.textView.textColor = UIColor.darkGray
            self.textView.delegate = self
            self.textView.tintColor = Theme.light.backGroundColor
            self.contentHeight = self.textView.contentSize.height
            setupTextViewPlaceholderText(tfPlaceHolder: tfPlaceHolder)
            self.textViewParent.addDefaultCornerRadius()
        }
    }
    
    func getText() -> String? {
        return !text.isEmpty ? text : nil
    }
    
    private func setupTextViewPlaceholderText(tfPlaceHolder: String) {
        self.placeHolderText.text = tfPlaceHolder
        self.placeHolderText.textColor = UIColor.lightGray
        self.placeHolderText.font = UIFont.poppinsRegular(size: 16)
    }
}

extension CustomInputField: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.placeHolderText.isHidden = !textView.text.isEmpty
        self.text = textView.text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderText.isHidden = !textView.text.isEmpty
        
        if contentHeight != self.textView.contentSize.height,
           self.textView.contentSize.height <= textViewHeightMax,
           self.textView.contentSize.height >= textViewHeightMin {
            delegate?.textViewHeightDidChange(height: self.textView.contentSize.height - contentHeight)
        }
        contentHeight = self.textView.contentSize.height
        self.text = textView.text
    }
}

extension CustomInputField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.text = textField.text ?? ""
    }
}
