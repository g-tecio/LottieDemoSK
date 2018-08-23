//
//  GameScene.swift
//  LottieDemoSK
//
//  Created by Fernando Vazquez on 8/23/18.
//  Copyright © 2018 Cartwheel Galaxy Games. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var labelTitle = SKLabelNode(fontNamed: "Helvetica Bold")
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
		
		/// Label Title setup
		labelTitle.text = "This is Cool!!!"
		labelTitle.fontSize = 30
		labelTitle.fontColor = SKColor.darkGray
		labelTitle.horizontalAlignmentMode = .center
		labelTitle.verticalAlignmentMode = .center
		labelTitle.zPosition = 2
		labelTitle.position = CGPoint(x: self.size.width/2.0, y: self.size.height*(3.0/4.0))
		labelTitle.name = "Main Title"
		labelTitle.alpha = 0.0
		labelTitle.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 2), SKAction.fadeIn(withDuration: 2)])))
		self.addChild(labelTitle)
		
		/// Shape
		let shape = SKShapeNode.init(rectOf: CGSize.init(width: 60, height: 60), cornerRadius: 3)
		shape.fillColor = SKColor.red
		shape.strokeColor = SKColor.red
		shape.glowWidth = 5.0
		shape.lineWidth = 1.0
		shape.position = CGPoint(x: self.frame.width/2.0, y: self.frame.height*(1/3))
		shape.run(SKAction.repeatForever(SKAction.group([ 	SKAction.rotate(	byAngle: CGFloat(Double.pi), duration: 2),
															SKAction.sequence(	[	SKAction.fadeIn(withDuration: 1),
																					SKAction.fadeOut(withDuration: 1)
																				])
														])))
		self.addChild(shape)
		
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 1.0

            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
	
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
