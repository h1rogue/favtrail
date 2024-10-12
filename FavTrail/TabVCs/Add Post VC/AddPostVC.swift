//
//  ThirdViewController.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 31/07/22.
//

import UIKit
import PhotosUI

//TODO: Upload Image Not Added Yet.

class AddPostVC: UIViewController {

    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet weak private var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak private var contentVIew: UIView!
    @IBOutlet weak private var uploadImageLabel: UILabel!
    @IBOutlet weak private var gridCollectionView: UICollectionView!
    @IBOutlet weak private var collectionViewHeight: NSLayoutConstraint!
    
    private lazy var aboutTextField: CustomInputField? = {
        guard let aboutField = ReusableView.customInputField.instantiateView() as? CustomInputField else { return nil }
        aboutField.delegate = self
        aboutField.configureView(labelTitle: AddPostConstants.labelTitle, tfPlaceHolder: AddPostConstants.labelPlaceHolder)
        return aboutField
    }()
    
    private lazy var locationTextField: CustomInputField? = {
        guard let locationTextField = ReusableView.customInputField.instantiateView() as? CustomInputField else { return nil }
        locationTextField.delegate = self
        locationTextField.configureView(labelTitle: AddPostConstants.addLocation, tfPlaceHolder: AddPostConstants.addLocationPlaceHolder, isSingleLine: true)
        return locationTextField
    }()
    
    var viewModel: AddPostVM!
    
    func initVM(viewModel: AddPostVM) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCustomTextField()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapGesture))
        contentVIew.isUserInteractionEnabled = true
        contentVIew.addGestureRecognizer(tapGesture)
        
        tapGesture.cancelsTouchesInView = false
        gridCollectionView.delegate = self
        gridCollectionView.dataSource = self
        gridCollectionView.isScrollEnabled = false
        registerCollectionViewCells()
    }
    
    private func registerCollectionViewCells() {
        gridCollectionView.register(UINib(nibName: AddPostImageUploadButtonCVC.identifier, bundle: .main), forCellWithReuseIdentifier: AddPostImageUploadButtonCVC.identifier)
        gridCollectionView.register(UINib(nibName: AddPostUploadImageCVC.identifier, bundle: .main), forCellWithReuseIdentifier: AddPostUploadImageCVC.identifier)
    }
    
    @objc private func viewTapGesture() {
        contentVIew.endEditing(true)
    }
    
    @objc private func onPostButtonClicked() {
        let about = aboutTextField?.getText()
        let location = locationTextField?.getText()
        
        if viewModel.checkPostForUpload(about: about, location: location) {
            viewModel.uploadPost(about: about, location: location)
        } else {
            //TODO: show warning somewhere
        }
    }
    
    private func setupCustomTextField() {
        guard let aboutTextField = aboutTextField else {
            return
        }
        
        stackView.addArrangedSubview(aboutTextField)
        guard let locationTextField = locationTextField else {
            return
        }
        
        stackView.addArrangedSubview(locationTextField)
        self.uploadImageLabel.font = UIFont.poppinsMedium(size: 14)
        self.uploadImageLabel.text = AddPostConstants.addImage
    }
    
    private func setupNavBar() {
        self.navigationItem.title = AddPostConstants.newPost
    }
    
    func setupTabBarItem() {
        let unselectedImage = UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate)
        self.tabBarItem = UITabBarItem(title: MainTabBarControllerItems.add.rawValue, image: unselectedImage, selectedImage: selectedImage)
    }
}

extension AddPostVC: UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 5)/3, height: (collectionViewHeight.constant - 5)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
}

extension AddPostVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cvImageLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = viewModel.cvImageLists[indexPath.row]
        
        switch cellModel.type {
        case .imageButton:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostImageUploadButtonCVC.identifier, for: indexPath) as? AddPostImageUploadButtonCVC else { return UICollectionViewCell() }
            return cell
        case .selectedImage:
            guard let cellImage = cellModel.image, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostUploadImageCVC.identifier, for: indexPath) as? AddPostUploadImageCVC else { return UICollectionViewCell() }
            cell.configureView(imgView: cellImage, indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellType = viewModel.cvImageLists[indexPath.row].type
        
        switch cellType {
        case .imageButton:
            lauchAlertView(cellType)
        default:
            break
        }
    }
    
    private func lauchAlertView(_ cellType: AddPostImageModelType) {
        let alertView = UIAlertController(title: AddPostConstants.uploadImageAlertMsg, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: AddPostConstants.uploadFromCamera, style: .default) { _ in self.triggerImagePicker(type: .camera) }
        let galleryAction = UIAlertAction(title: AddPostConstants.uploadFromGallery, style: .default) { _ in self.triggerImagePicker(type: .photoGallery) }
        let cancelAction = UIAlertAction(title: AddPostConstants.cancelAction, style: .cancel)
        
        alertView.addAction(galleryAction)
        alertView.addAction(cameraAction)
        alertView.addAction(cancelAction)
        
        present(alertView, animated: true)
    }
    
    private func triggerImagePicker(type: UploadSourceType) {
        
        if #available(iOS 14, *), type == .photoGallery {
            var imagePickerConfig = PHPickerConfiguration()
            imagePickerConfig.selectionLimit = viewModel.selectedImageLimit
            let imagePickerVC = PHPickerViewController(configuration: imagePickerConfig)
            imagePickerVC.delegate = self
            self.present(imagePickerVC, animated: true)
        } else {
            useUIImagePicker(type: type)
        }
    }
    
    private func useUIImagePicker(type: UploadSourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.isEditing = true
        switch type {
        case .camera:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
            }
        case .photoGallery:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
            }
        }
        present(imagePicker, animated: true)
    }
}

extension AddPostVC: CustomInputFieldDelegate {
    enum UploadSourceType {
        case photoGallery, camera
    }
    
    func textViewHeightDidChange(height: CGFloat) {
        stackViewHeight.constant += height
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AddPostVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    private func addImageToUpload(_ image: UIImage) {
        DispatchQueue.main.async {
            if self.viewModel.checkCVImageSpacePresent() {
                self.viewModel.cvImageLists.insert(SelectedImagePostModel(image: image), at: 0)
                self.gridCollectionView.reloadData()
            }
        }
    }
    
    @available(iOS 14.0, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard error == nil, let image = reading as? UIImage else { return }
                self.addImageToUpload(image)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.addImageToUpload(image)
        }
    }
}

extension AddPostVC: AddPostUploadImageCVCDelegate {
    func crossButtonClicked(indexPath: IndexPath) {
        viewModel.removeImage(at: indexPath)
        self.gridCollectionView.reloadData()
    }
}
