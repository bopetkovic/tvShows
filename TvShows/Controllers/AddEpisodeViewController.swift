//
//  AddEpisodeViewController.swift
//  TvShows
//
//  Created by Bojan Petkovic on 29/09/2018.
//

import UIKit

class AddEpisodeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var showId: String?
    var imagePickerController = UIImagePickerController()
    
    @IBOutlet weak var showCover: UIImageView!
    @IBOutlet weak var uploadPhotoButton: UIButton!
    @IBOutlet weak var episodeTitleField: UITextField!
    @IBOutlet weak var episodeNumberField: UITextField!
    @IBOutlet weak var episodeDescriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationItem.title = "Add episode"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addEpisode))
        
        showCover.isHidden = true
        uploadPhotoButton.isHidden = false
        
        episodeTitleField.addBottomBorder()
        episodeNumberField.addBottomBorder()
        episodeDescriptionField.addBottomBorder()
    }
    
    @objc func returnBack() {
        performSegue(withIdentifier: "returnBack", sender: self)
    }
    
    @objc func addEpisode() {
        print("Add new episode")
    }

    @IBAction func chooseImage(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose destination", message: "Do you want to capture Showw Cover photo with camera or you want to select it from photo library?", preferredStyle: .alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.delegate = self
                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }
        
        let libraryAction = UIAlertAction(title: "PhotoLibrary", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePickerController.delegate = self
                self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.imagePickerController.allowsEditing = true
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }
        
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true) {
            self.showCover.isHidden = false
            self.showCover.contentMode = .scaleAspectFit
            self.uploadPhotoButton.isHidden = true
            print("This is info: \(info)")
            if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.showCover.image = selectedImage
            }
        }
        
    }
}
