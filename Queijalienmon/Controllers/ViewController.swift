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
        
        guard let drawImage = PokeResult.drawImage else {
            self.canvasButton.setTitle("Toque para desenhar", for: .normal)
            return
        }
        
        self.canvasButton.setBackgroundImage(drawImage, for: .normal)
        self.canvasButton.setTitle("", for: .normal)
    }

    
    @IBAction func identifyDraw(_ sender: Any) {
        guard let image = PokeResult.drawImage else {
            //Tratar erro
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            PokeIdentifier.identify(draw: image)
            PokeAPI.get(name: PokeResult.name!)
            
            while PokeResult.image == nil {
                self.loadScreen()
            }
            
            DispatchQueue.main.async {
                //Remover tela de espera
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.show(nextViewController, sender: nil)
            }
        }
    }
    
    func loadScreen() {
        DispatchQueue.main.async {
            self.identifyDrawButton.isHidden = true
        }

    }
}
