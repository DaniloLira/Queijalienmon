//
//  ResultViewController.swift
//  Queijalienmon
//
//  Created by Danilo Araújo on 01/09/20.
//  Copyright © 2020 mandabrasa. All rights reserved.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var drawImageView: UIImageView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var congratsLabel: UILabel!
    
    let rickAndMorty: [String] = ["Rick", "Morty", "Jerry", "Squanchy"]
    let verbos: [String] = ["comendo", "cagando", "chapado no", "derretendo"]
    let queijos: [String] = ["queijo coalho", "queijo prato", "queijo manteiga", "queijo parmesão", "queijo cheddar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.logoImageView.alpha = 0
        
        self.messageLabel.text = "Seu \(PokeResult.name ?? "") parece o \(self.rickAndMorty.randomElement()!) \(self.verbos.randomElement()!) \(self.queijos.randomElement()!)!"
        self.drawImageView.image = PokeResult.drawImage
        self.pokeImageView.image = PokeResult.image

    }
    
    @IBAction func tapBackButton() {
    
        PokeResult.clean()
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewControlle") as! ViewControlle
        nextViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.show(nextViewController, sender: nil)
        
    }
    
    @IBAction func shareDraw(_ sender: Any) {
        self.hideButtons(bool: true)
        let image = createImageFromView()
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _ , error) in
            if completed {
                print("Completed")
            } else {
                print("Treta")
            }
            self.hideButtons(bool: false)
        }
        
        present(activityController, animated: true)
    }

    func hideButtons(bool: Bool){
        self.backButton.isHidden = bool
        self.shareButton.isHidden = bool
        self.logoImageView.isHidden = !bool
        
        // Provisório (enquanto nao tem animação)
        self.logoImageView.alpha = 1
//        UIImageView.animate(withDuration: 0.3, delay: 1.0, animations: {
//            self.logoImageView.alpha = 1
//        }) { _ in
//
//        }
        
    }
    
    func createImageFromView() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
