//
//  ViewController.swift
//  seeFood
//
//  Created by gianrico on 09/12/17.
//  Copyright © 2017 gianrico. All rights reserved.
//

import UIKit
import CoreML
import Vision

//vision processa le immagini più velocemente


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = userPickedImage
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        // -1- present()
        // rende visibile in una certa maniera il controller in questione
        // in questo caso imagepicker e lo spara a tutto schermo per default
        present(imagePicker, animated: true, completion: nil)
    }
    
}

