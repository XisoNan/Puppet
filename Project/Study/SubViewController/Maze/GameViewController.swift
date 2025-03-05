//
//  GameViewController.swift
//  Sprike1
//
//  Created by 1234 on 2024/4/8.
//

import UIKit
import SpriteKit
//import GameplayKit
import SwiftyJSON
import SnapKit
import AVFoundation

class GameViewController: UIViewController {
    
    let scene=GameScene(size: CGSize(width:1024,height:1800))
    var player:AVAudioPlayer?
    
    var WallsLocation:[WallLocation] = []
    let Max_x=860
    let Max_y=1540
    let Min_x=200
    let Min_y=427
    
    let inlet_min_x=395
    let enter_min_x=400
    
    lazy var left:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var right:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var up:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var down:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpNav()
        getWallLocation()
        let skView=SKView(frame: self.view.frame)
        skView.showsFPS=false
        skView.showsNodeCount=false
        skView.ignoresSiblingOrder=false
        scene.scaleMode = .aspectFit
        scene.isUserInteractionEnabled=true
        scene.GetData(WallsLocation)
        skView.presentScene(scene)
        self.view.addSubview(skView)
        print(WallsLocation)
        self.view.addSubview(skView)
        self.view.addSubview(left)

        self.view.addSubview(right)
        self.view.addSubview(up)
        self.view.addSubview(down)
        left.image=UIImage(named: "left")
        right.image=UIImage(named: "right")
        up.image=UIImage(named: "up")
        down.image=UIImage(named: "down")
        
        
        
        left.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.left.equalToSuperview().offset(100)
            make.width.equalTo(48)
            make.height.equalTo(44)
        }
        up.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-168)
            make.left.equalToSuperview().offset(150)
            make.width.equalTo(48)
            make.height.equalTo(44)
        }
        down.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-75)
            make.left.equalToSuperview().offset(150)
            make.width.equalTo(48)
            make.height.equalTo(55)
        }
        right.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.left.equalToSuperview().offset(200)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
        //添加手势
        let TapLeft=UITapGestureRecognizer(target: self, action: #selector(TapAction))
        left.isUserInteractionEnabled=true
        TapLeft.name="left"
        left.addGestureRecognizer(TapLeft)
        
        let TapRight=UITapGestureRecognizer(target: self, action: #selector(TapAction))
        right.isUserInteractionEnabled=true
        TapRight.name="right"
        right.addGestureRecognizer(TapRight)
        
        let TapUp=UITapGestureRecognizer(target: self, action: #selector(TapAction))
        TapUp.name="up"
        up.isUserInteractionEnabled=true
        up.addGestureRecognizer(TapUp)
        
        let TapDown=UITapGestureRecognizer(target: self, action: #selector(TapAction))
        TapDown.name="down"
        down.isUserInteractionEnabled=true
        down.addGestureRecognizer(TapDown)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playMusic()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopMusic()
    }
    
    func setUpNav(){
        navigation.bar.isHidden=true
        navigation.bar.alpha=0
//        navigationItem.leftBarButtonItem=Back
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func Handleback(){
        navigationController?.popViewController(animated: true)
    }
    
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getWallLocation(){
        
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "WallLocation", ofType: "json")!))
            print(data)
            guard let jsonString = String(data:data,encoding: .utf8) else{return}
//            print(jsonString)
            let json=JSON(parseJSON: jsonString)
            for i in 0..<20{
                WallsLocation.append(WallLocation(
                    minX: json["\(i)","minX"].floatValue,
                    minY: json["\(i)","minY"].floatValue,
                    maxX: json["\(i)","maxX"].floatValue,
                    maxY: json["\(i)","maxY"].floatValue))
            }
        }catch{
            
        }
        
        
    }
    
    @objc func TapAction(ges:UITapGestureRecognizer){
        let cur_x=scene.player.position.x
        let cur_y=scene.player.position.y
        var flag=true
        switch ges.name{
        case "left":
            for i in 1..<20{
                if(Float(cur_x-30)>Float(Min_x)&&Float(cur_x)<=Float(Min_x)){
                    let actionMove=SKAction.moveTo(x: CGFloat(Min_x+30), duration: 0.3)
                    scene.player.run(SKAction.sequence([actionMove]))
                    return
                }
                if(Float(cur_x-30)>=WallsLocation[i].maxX&&Float(cur_x-30)-Float(scene.step)<=WallsLocation[i].maxX){
                    if(Float(cur_y-30)>WallsLocation[i].minY && Float(cur_y+30)<WallsLocation[i].maxY){
                        let actionMove=SKAction.moveTo(x: CGFloat(WallsLocation[i].maxX+30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        break
                    }
                    if(Float(cur_y-30)<WallsLocation[i].minY&&Float(cur_y+30)>WallsLocation[i].minY){
                        let actionMove=SKAction.moveTo(x: CGFloat(WallsLocation[i].maxX+30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        print("\(i)----2")
                        flag = !flag
                        break
                    }
                    if(Float(cur_y+30)>WallsLocation[i].maxY&&Float(cur_y-30)<WallsLocation[i].maxY){
                        let actionMove=SKAction.moveTo(x: CGFloat(WallsLocation[i].maxX+30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        print("\(i)----3")
                        flag = !flag
                        break
                    }
                }
            }
            if(flag){
                let actionMove=SKAction.moveTo(x: cur_x-CGFloat(scene.step), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
            }
            break
        case "right":
            if(Float(cur_x+30)>=Float(Max_x)&&Float(cur_x)<Float(Max_x)){
                let actionMove=SKAction.moveTo(x: CGFloat(Max_x-30), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
                return
            }
            for i in 1..<20{
                if(Float(cur_x+30)<=WallsLocation[i].minX&&Float(cur_x+30)+Float(scene.step)>=WallsLocation[i].minX){
                    if(Float(cur_y-30)>WallsLocation[i].minY&&Float(cur_y+30)<WallsLocation[i].maxY){
                        let actionMove=SKAction.moveTo(x: CGFloat(WallsLocation[i].minX-30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        print("\(i)----1")
                        flag = !flag
                    }
                    if(Float(cur_y-30)<WallsLocation[i].minY&&Float(cur_y+30)>WallsLocation[i].minY){
                        flag = !flag
                        let actionMove=SKAction.moveTo(x: CGFloat(WallsLocation[i].minX-30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        print("\(i)----2")
                        break
                    }
                    if(Float(cur_y+30)>WallsLocation[i].maxY&&Float(cur_y-30)<WallsLocation[i].maxY){
                        flag = !flag
                        let actionMove=SKAction.moveTo(x: CGFloat(WallsLocation[i].minX-30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        print("\(i)----3")
                        break
                    }
                    
                }
            }
            if(flag){
                let actionMove=SKAction.moveTo(x: cur_x+CGFloat(scene.step), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
            }
            break
        case "up":
            if(Float(cur_y)<Float(Max_y)&&Float(cur_y+30)>=Float(Max_y)&&(cur_x != CGFloat(enter_min_x))){
                let actionMove=SKAction.moveTo(y: CGFloat(Max_y-30), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
                return
            }
            for i in 1..<20{
                if(Float(cur_y+30)<=WallsLocation[i].minY&&Float(cur_y+30)+Float(scene.step)>=WallsLocation[i].minY){
                    //有墙
                    if(Float(cur_x-30)>WallsLocation[i].minX&&Float(cur_x+30)<WallsLocation[i].maxX){
                        let actionMove=SKAction.moveTo(y: CGFloat(WallsLocation[i].minY-30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        print("\(i)----1")
                        break
                    }
                    if(Float(cur_x-30)<WallsLocation[i].minX&&Float(cur_x+30)>WallsLocation[i].maxX)
                    {
                        let actionMove=SKAction.moveTo(y: CGFloat(WallsLocation[i].minY-30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        print("\(i)----2")
                        break
                    }
                    if(Float(cur_x+30)>WallsLocation[i].maxX&&Float(cur_x-30)<WallsLocation[i].maxX){
                        let actionMove=SKAction.moveTo(y: CGFloat(WallsLocation[i].minY-30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        print("\(i)----3")
                        break
                    }
                    
                }
            }
            if(flag){
                let actionMove=SKAction.moveTo(y: cur_y+CGFloat(scene.step), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
            }
            break
        case "down":
            if(Float(cur_y)>Float(Min_y)&&Float(cur_y-30)<=Float(Min_y)&&(                cur_x != CGFloat(inlet_min_x))){
                let actionMove=SKAction.moveTo(y: CGFloat(Min_y+30), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
                return
            }
            for i in 1..<20{
                if(Float(cur_y-30)>=WallsLocation[i].maxY&&Float(cur_y-30)-Float(scene.step)<=WallsLocation[i].maxY){
                    if(Float(cur_x-30)>WallsLocation[i].minX&&Float(cur_x+30)<WallsLocation[i].maxX){
                        let actionMove=SKAction.moveTo(y: CGFloat(WallsLocation[i].maxY+30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        print("\(i)----1")
                        break
                    }
                    if(Float(cur_x-30)<WallsLocation[i].minX&&Float(cur_x+30)>WallsLocation[i].maxX)
                    {
                        let actionMove=SKAction.moveTo(y: CGFloat(WallsLocation[i].maxY+30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        print("\(i)----2")
                        break
                    }
                    if(Float(cur_x+30)>WallsLocation[i].maxX&&Float(cur_x-30)<WallsLocation[i].maxX){
                        let actionMove=SKAction.moveTo(y: CGFloat(WallsLocation[i].maxY+30), duration: 0.3)
                        scene.player.run(SKAction.sequence([actionMove]))
                        flag = !flag
                        print("\(i)----3")
                        break
                    }
                }
            }
            if(flag){
                let actionMove=SKAction.moveTo(y: cur_y-CGFloat(scene.step), duration: 0.3)
                scene.player.run(SKAction.sequence([actionMove]))
            }
            break
        default:
            break
        }
        let x=self.scene.player.position.x
        let y=self.scene.player.position.y
        print("(\(x),\(y))")
        for i in 1...6{
            let loc=self.scene.childNode(withName: "unknow\(i)")!.position
            let t_x=loc.x
            let t_y=loc.y
            if((x >= t_x-40) && (x<=t_x+40)&&(y>=t_y-40)&&(y<=t_y+40)&&(self.scene.childNode(withName: "unknow\(i)")!.alpha==1)){
                scene.ViewToSee(i)
                return
            }
        }
    }
}

extension GameViewController{
    func playMusic(){
        if let path = Bundle.main.path(forResource: "bgm", ofType: "mp3") {
        let url = URL(fileURLWithPath: path)
            do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                        
                    player = try AVAudioPlayer(contentsOf: url)
                    guard let player = player else { return }
                    player.play()
                } catch let error {
                        print("Error playing music: \(error.localizedDescription)")
                    }
            }
    }
    func stopMusic() {
           player?.stop()
           try? AVAudioSession.sharedInstance().setActive(false)
       }
}
