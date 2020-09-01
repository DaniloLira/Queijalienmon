//
//  ViewController.swift
//  Queijalienmon
//
//  Created by Danilo Araújo on 28/08/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import UIKit
import PencilKit
import PhotosUI

class DrawViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    @IBOutlet weak var buttonSaveDraw: UIButton!
    @IBOutlet weak var canvas: PKCanvasView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var newCanvasButton: UIButton!
    
    var draw = PKDrawing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.delegate = self
        canvas.drawing = draw
        canvas.allowsFingerDrawing = true
        canvas.alwaysBounceVertical = true
        
        if let window = parent?.view.window,
        let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            
            canvas.becomeFirstResponder()
        }
    }

    @IBAction func saveDraw(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(canvas.bounds.size, false , UIScreen.main.scale)
        canvas.drawHierarchy(in: canvas.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: {success, error in
                print(error)
            })

            // Para colocar a imagem do canvas no quadro da tela anterior
//            if let topMostViewController = UIApplication.shared.topMostViewController() as? ViewController{
//                topMostViewController.canvasView.image = image
//            }
            
        }
    }
    
    
    @IBAction func tapCancelButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapNewCanvasButton() {
        self.draw = PKDrawing()
        self.canvas.drawing = draw
    }
    
}
