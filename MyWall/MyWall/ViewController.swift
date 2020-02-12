//
//  ViewController.swift
//  MyWall
//
//  Created by Burshtyn, Mariya on 12.02.2020.
//  Copyright © 2020 Burshtyn, Mariya. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate {
    var textRecognizer: VisionTextRecognizer!
    var frameSublayer = CALayer()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vision = Vision.vision()
        let options = VisionCloudTextRecognizerOptions()
        options.languageHints = ["en", "ru"]
        textRecognizer = vision.cloudTextRecognizer(options: options)
        guard let image1 = UIImage(named: "1.jpg") else {return}
        guard let image2 = UIImage(named: "2.jpg") else {return}
        guard let image3 = UIImage(named: "3.jpg") else {return}
        let images = [image1, image2, image3]
        for image in images {
            let visionImage = VisionImage(image: image)
            processImage(visionImage)
        }
    }
    
    private func processImage(_ visionImage: VisionImage) {
        textRecognizer.process(visionImage) { result, error in
          guard error == nil, let result = result else {
            // ...
            return
          }

          // Text recognition results
          let resultText = result.text
          // `VisionText` is made of `VisionTextBlock`s...
//          for block in resultText.blocks {
//            // ...and each `VisionTextBlock` has
//            // text, confidence level, list of recognized languages and corner points and frame in which the text was detected...
//            let blockText = block.text
//            let blockConfidence = block.confidence
//            let blockLanguages = block.recognizedLanguages
//            let blockCornerPoints = block.cornerPoints
//            let blockFrame = block.frame
//            // ...and each `VisionTextBlock` is made of `VisionTextLine`s...
//            for line in block.lines {
//                // ...which again have text, confidence level, list of recognized languages, corner points and the frame in which the text was detected...
//                let lineText = line.text
//                let lineConfidence = line.confidence
//                let lineLanguages = line.recognizedLanguages
//                let lineCornerPoints = line.cornerPoints
//                let lineFrame = line.frame
//                // ... and each `VisionTextLine` is further made of `VisionTextElement`s...
//                for element in line.elements {
//                    // ...and each `VisionTextElement` has
//                    // text, confidence level, list of recognized languages, corner points and the frame in which the text was detected.
//                    let elementText = element.text
//                    let elementConfidence = element.confidence
//                    let elementLanguages = element.recognizedLanguages
//                    let elementCornerPoints = element.cornerPoints
//                    let elementFrame = element.frame
//                }
//            }
//          }
        }
    }
}
