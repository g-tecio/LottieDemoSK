//
//  GameViewController.swift
//  LottieDemoSK
//
//  Created by Fernando Vazquez on 8/23/18.
//  Copyright © 2018 Cartwheel Galaxy Games. All rights reserved.
//

import UIKit
import Lottie
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
	
		// MARK: view
		view.backgroundColor = UIColor.white
		
		// MARK: animationView
		let animationView = LOTAnimationView(name: "servishero_loading")
		
			// Setup Lottie animaitonView
			animationView.contentMode = .scaleAspectFit
			animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
			animationView.center = self.view.center
			animationView.backgroundColor = UIColor.clear

			// Add Lottie animaitonView as Sub-View to Main View
			view.addSubview(animationView)

			// Turn looping on and Play Lottie Animation
			animationView.loopAnimation = true
			animationView.play()

		// MARK: gameView
		let gameView = SKView()

			// Setup gameView
			gameView.contentMode = .scaleToFill
			gameView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
			gameView.center = self.view.center
			gameView.allowsTransparency = true

			// Add Lottie gameView as Sub-View to Main View
			view.addSubview(gameView)
		
		// MARK: gameScene
		let gameScene = GameScene(size: gameView.bounds.size)
		
			// Setup gameScene
			gameScene.backgroundColor = UIColor.clear
			gameScene.scaleMode = .resizeFill
		
			// Present Scene
			gameView.presentScene(gameScene)
		
			// Performance monitoring of SpriteKit
			gameView.ignoresSiblingOrder = true
			gameView.showsFPS = true
			gameView.showsNodeCount = true
	}

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
