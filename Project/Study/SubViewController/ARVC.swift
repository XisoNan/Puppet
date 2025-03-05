//
//  detailViewController.swift
//  Project
//
//  Created by 1234 on 2024/2/21.
//

import UIKit
import SnapKit
import ARKit
import RealityKit

class ARVC:UIViewController{

     var arView: ARView!//AR场景
    
    var moveToLocation:Transform=Transform()
    
    let moveDuration:Double=100//运动时间
    var robot:Entity?//3d实体模型
    
    let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: ARVC.self, action: #selector(handleBackButton))
    
    lazy var forward:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem=backButton
        arView=ARView.init(frame: CGRect(x:0,y:0,width: Width,height:Height))
        self.view.addSubview(arView)
        arView.addSubview(forward)
        forward.alpha=0
        forward.image=UIImage(named:"guess")
        forward.frame=CGRect(x: 40, y: 650, width: 150, height: 80)
        //开启平面检测
        startPlaneDetection()
        
        robot=try! Entity.load(named: "robot2")
        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandleTap(recognizer:))))
        let tap=UITapGestureRecognizer(target: self, action: #selector(Tap))
        
    }
    
    
    func startPlaneDetection(){
        
//        arView.automaticallyConfigureSession=true
        let configuration=ARWorldTrackingConfiguration()
        configuration.planeDetection=[.horizontal]
        arView.addCoaching()
//        arView.debugOptions = .showAnchorGeometry
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)
    }
    
    @objc func HandleTap(recognizer:UITapGestureRecognizer){
        self.forward.alpha=1
        let location=recognizer.location(in: arView)
        let results=arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let firstResult=results.first{
            var WorldPos=simd_make_float3(firstResult.worldTransform.columns.3)

            placeObject(object:robot!,at:WorldPos)//放置模型
            print("\(WorldPos)")
        }
        
    }
    
    func placeObject(object:Entity,at location:SIMD3<Float>){
        let objectAnchor=AnchorEntity(world:location)
        let rotateToAngle=simd_quatf(angle: (GLKMathDegreesToRadians(180)), axis: SIMD3(x:0,y:1,z:0))//设置模型旋转角度
        object.setOrientation(rotateToAngle, relativeTo: object)
        objectAnchor.addChild(object)
        arView.scene.addAnchor(objectAnchor)
    }
    
    func move(){
        moveToLocation.translation=(robot?.transform.translation)!+simd_make_float3(0,0,20)
        robot?.move(to:moveToLocation,relativeTo: robot,duration:5)
        walkAnimation(movementDuration:moveDuration)
    }
    
    func walkAnimation(movementDuration:Double){
        if let robotAnimation=robot?.availableAnimations.first{
            
            robot?.playAnimation(robotAnimation.repeat(duration: moveDuration), transitionDuration: 0.5, startsPaused: false)
        }else{
            print("Have an Error")
        }
    }
    
    @objc func handleBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func Tap(){
        
        move()//移动模型
    }
    


}

extension ARView: ARCoachingOverlayViewDelegate{
    
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.frame=CGRect(x: Width/2-90, y: Height/2-75, width: 180, height: 150)
        coachingOverlay.backgroundColor = .clear
//        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        self.addSubview(coachingOverlay)
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.session = self.session
        coachingOverlay.delegate = self
    }
}




