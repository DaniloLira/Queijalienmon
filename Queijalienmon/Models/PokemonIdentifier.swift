//
//  PokemonIdentifier.swift
//  Queijalienmon
//
//  Created by Danilo Araújo on 01/09/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import Foundation
import CoreML
import UIKit
import Vision

public class PokemonIdentifier {
    
    var consultResult: (VNConfidence, String)? = nil {
        didSet {
            PokeResult.shared.name = consultResult!.1
            PokeAPI.get(name: consultResult!.1)
        }
    }
    let model = Classificador_Pokemon_1().model
    static let shared = PokemonIdentifier()
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: self.model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            
            request.imageCropAndScaleOption = .centerCrop
            return request
    } catch {
       fatalError("Failed to load Vision ML model: \(error)")
    }}()
    
    
    func processClassifications(for request: VNRequest, error: Error?) {
        
        DispatchQueue.main.async {
            guard let results = request.results else {
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
        
            if classifications.isEmpty {
                print("Nothing found")
            } else {
                let topClassifications = classifications.prefix(1)
                let descriptions = topClassifications.map { classification in return (classification.confidence, classification.identifier) }
                self.consultResult = descriptions[0]
            }
        }
    }
    
    func createClassificationsRequest(for image: UIImage) {
        let orientation = CGImagePropertyOrientation.up
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        
        DispatchQueue.main.async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform \n\(error.localizedDescription)")
            }
        }
    }
    
    func identify(draw: UIImage){
        self.createClassificationsRequest(for: draw)
    }
    
    
}
