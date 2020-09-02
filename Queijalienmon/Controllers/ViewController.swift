//
//  ViewController.swift
//  Queijalienmon
//
//  Created by Danilo Araújo on 28/08/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import UIKit
import Foundation

class ViewControlle: UIViewController{
    
    @IBOutlet weak var canvasButton: UIButton!
    @IBOutlet weak var identifyDrawButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(true)
        
        guard let drawImage = PokeResult.shared.drawImage else {
            self.canvasButton.setTitle("Toque para desenhar", for: .normal)
            return
        }
        
        self.canvasButton.setBackgroundImage(drawImage, for: .normal)
        self.canvasButton.setTitle("", for: .normal)
    }

    
    @IBAction func identifyDraw(_ sender: Any) {
        guard let image = PokeResult.shared.drawImage else {
            //Tratar erro
            return
        }
        
        PokemonIdentifier.shared.identify(draw: image)
    }
}
