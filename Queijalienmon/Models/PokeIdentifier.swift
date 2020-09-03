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

public class PokeIdentifier {
    
    static private let model = Poklassifier().model
    
    static func identify(draw image: UIImage) {
        let orientation = CGImagePropertyOrientation.up
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create \(CIImage.self) from \(image).")
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
        
        do {
            let request = PokeIdentifier.classificationRequest()
            try handler.perform([request])
            PokeIdentifier.processClassifications(for: request)
        } catch {
            print("Failed to perform \n\(error.localizedDescription)")
        }
    }
    
    static private func classificationRequest() -> VNCoreMLRequest {
        do {
            let model = try VNCoreMLModel(for: PokeIdentifier.model)
            let request = VNCoreMLRequest(model: model)
            
            return request
        } catch {
            fatalError("Failed to load Vision ML model: \(error)")
        }
    }
    
    
    static private func processClassifications(for request: VNRequest) {
        guard let results = request.results else {
            return
        }
        
        let classifications = results as! [VNClassificationObservation]

        if classifications.isEmpty {
            print("Nothing found")
        } else {
            let bestClassification = classifications.first
            PokeResult.name = bestClassification!.identifier
        }
    }
}
