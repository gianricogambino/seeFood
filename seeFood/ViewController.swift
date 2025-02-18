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
            //convertiamo l'UIImage in un formato usabile da CoreML
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Conversion to CIImage failed.")
            }
            detect(image: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image:CIImage) {
        // assegnamo alla costante model l'oggetto mlmodel importato
        // VNCoreMLModel viene da Vision che abbiamo importato all'inizio
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML failed.")
        }
        // qui processa i dati e come esito abbiamo un array di dati elaborati
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("Request failed.")
            }
            print(result)
        }
        //l'handler prende l'immagine CIImage e la passa come request al CoreML
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        // -1- present()
        // rende visibile in una certa maniera il controller in questione
        // in questo caso imagepicker e lo spara a tutto schermo per default
        present(imagePicker, animated: true, completion: nil)
    }
    
}

