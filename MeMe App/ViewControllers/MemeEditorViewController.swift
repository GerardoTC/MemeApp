//
//  ViewController.swift
//  MeMe App 1.0
//
//  Created by Gerardo Tarazona Caceres on 2/18/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import UIKit
import Photos
class MemeEditorViewController: UIViewController {
    // MARK:  IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var memeView: UIView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var navBar: UINavigationBar!
    // MARK:  Constants/Vars
    let pickerController = UIImagePickerController()
    let textFieldDelegate = MemeTextFieldDelegate()
    let keyboardManagement = KeyboardManagement()
    var photoLibraryPermission = false
    var cameraPermission = false
    
    // MARK:  Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDefaultView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if heightConstraint.constant > view.frame.height - (navBar.frame.height * 2){
            heightConstraint.constant = view.frame.height - (navBar.frame.height * 2.5)
        }
        if widthConstraint.constant > view.frame.width {
            widthConstraint.constant = view.frame.width - 5
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardManagement.subscribeToKeyBoardNotification()
        checkPermissions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardManagement.unsubscribeFromKeyboardNotifications()
    }
    
    // MARK:  IBAction methods
    @IBAction func gallerySelected() {
        showImagePickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func photoSelected() {
        showImagePickerController(sourceType: .camera)
    }
    
    @IBAction func setupDefaultView() {
        imageView.contentMode = .scaleAspectFit
        pickerController.delegate = self
        keyboardManagement.view = self.view
        topTextField.setupMemeText(Constants.TextFields.defaultTopText)
        bottomTextField.setupMemeText(Constants.TextFields.defaultBottomText)
        imageView.image = nil
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        shareButton.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    @IBAction func shareMeme() {
        guard photoLibraryPermission else {
            self.showAlert(title: Constants.Alert.permissionNotGranted,
                           message: Constants.Alert.instructions)
            return
        }
        let memedImage = memeView.screehShot ?? UIImage()
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {[weak self] (activityType: UIActivity.ActivityType?,
            completed: Bool,
            returnedItems: [Any]?,
            error: Error?) in
            
            if error == nil, completed {
                self?.save(memedImage: memedImage)
            }
            
            
        }
        present(activityController, animated: true)
    }
    
    // MARK:  Private methods
    private func checkPermissions() {
        //PhotoLibrary
        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            self?.photoLibraryPermission = status == .authorized ? true : false
        }
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] response in
            self?.cameraPermission = response
        }
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType)  else {
            switch sourceType {
            case .photoLibrary:
                self.showAlert(title: Constants.Alert.unavailablePhotoLibrary)
            default:
                self.showAlert(title: Constants.Alert.unkonwnError)
            }
            return
        }
        if sourceType == .camera, !cameraPermission {
            self.showAlert(title: Constants.Alert.unavailableCamera, message: Constants.Alert.cameraInstructions)
            return
        }
        pickerController.sourceType = sourceType
        pickerController.mediaTypes = [Constants.MediaTypes.imageType]
        present(pickerController, animated: true, completion: nil)
    }
    
    private func save(memedImage: UIImage) {
        let originalImage = self.imageView.image ?? UIImage()
        let topText =  topTextField.text ?? String()
        let bottomText =  bottomTextField.text ?? String()
        let meme = Meme(topText: topText,
                        bottomText: bottomText,
                        memedImage: memedImage,
                        originalImage: originalImage)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.memes.append(meme)
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK:  UImagePickerDelegate Implementation
extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
        shareButton.isEnabled = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

