//
//  LoadingViewController.swift
//  Queijalienmon
//
//  Created by Matheus Andrade on 03/09/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import UIKit

class LoadingViewController : UIViewController{
    
    @IBOutlet weak var pokeballView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var drawImageView: UIImageView!
    
    let pokeballImages : [UIImage] = [UIImage(named: "Pokebola centro")!, UIImage(named: "Pokebola esquerda 1")!, UIImage(named: "Pokebola esquerda 2")!, UIImage(named: "Pokebola esquerda 1")!, UIImage(named: "Pokebola centro")!, UIImage(named: "Pokebola direita 1")!, UIImage(named: "Pokebola direita 2")!, UIImage(named: "Pokebola direita 1")!]
    
    override func viewDidLoad() {
        guard let image = PokeResult.drawImage else {
            // Do something
            return
        }
        
        self.loadingLabel.isHidden = false
        self.drawImageView.image = image
                
        self.pokeballView.animationImages = self.pokeballImages
        self.pokeballView.animationDuration = 2
        self.pokeballView.scalesLargeContentImage = true
        self.pokeballView.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            PokeIdentifier.identify(draw: image)
            PokeAPI.get(name: PokeResult.name!)
            
            while PokeResult.image == nil {
            }
            
            DispatchQueue.main.async {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                nextViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.show(nextViewController, sender: nil)
            }
        }
    }
    
}
