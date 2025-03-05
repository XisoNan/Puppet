//
//  ViewController.swift
//  Quizzier
//
//  Created by liyuehang on 2023/11/14.
//

import UIKit
import HandyJSON
import SwiftyJSON
import SnapKit


class MedalViewController: UIViewController,UIScrollViewDelegate {
    
    var medalName:[String]=["提线","布袋","杖头","铁枝"]
    
    var img:UIImage!
    var index=0
    var scrollView=UIScrollView()
    lazy var medal:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.view.frame
        effectView.alpha=0.6
        return effectView
    }()
    
    lazy var leftP:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var rightP:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.init(patternImage: img)
        self.view.addSubview(effectView)
        scrollView=UIScrollView()
        
        scrollView.delegate=self
        scrollView.contentSize=CGSizeMake(CGFloat(Width*4), 0)
        scrollView.isPagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.scrollsToTop=false
        
        for i in 0..<4{
            let left=UIImageView()
            left.contentMode = .scaleAspectFit
            left.image = isFsh[medalName[i]+"_left"]! ? UIImage(named: medalName[i]+"_left") : UIImage(named: medalName[i]+"黑白_left")
            scrollView.addSubview(left)
            left.snp.makeConstraints { make in
                make.centerX.equalToSuperview().offset(Width*CGFloat(i)-Width/4+30)
                make.width.equalTo(210)
                make.top.equalToSuperview().offset(220)
                make.height.equalTo(280)
            }
            let right=UIImageView()
            right.contentMode = .scaleAspectFit
            right.image = isFsh[medalName[i]+"_right"]! ? UIImage(named: medalName[i]+"_right") : UIImage(named: medalName[i]+"黑白_right")
            scrollView.addSubview(right)
            right.snp.makeConstraints { make in
                make.left.equalTo(left.snp.right).offset(-70)
                make.width.equalTo(210)
                make.top.equalToSuperview().offset(220)
                make.height.equalTo(280)
            }
        }
        
        self.view.addSubview(scrollView)
        self.view.addSubview(leftP)
        self.view.addSubview(rightP)
        scrollView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(Width)
            make.top.equalToSuperview().offset(100)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        leftP.image=UIImage(named: "leftA")
        rightP.image=UIImage(named: "rightA")
        
        leftP.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(120)
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
        rightP.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.equalTo(120)
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
        
        //添加手势
        let tapView=UITapGestureRecognizer(target: self, action: #selector(TapBack))
        let TapLeftP=UITapGestureRecognizer(target: self, action: #selector(TapLeft))
        let TapRightP=UITapGestureRecognizer(target: self, action: #selector(TapRight))
        self.view.addGestureRecognizer(tapView)
        self.leftP.isUserInteractionEnabled=true
        self.rightP.isUserInteractionEnabled=true
        self.leftP.addGestureRecognizer(TapLeftP)
        self.rightP.addGestureRecognizer(TapRightP)
    }
    
    @objc func TapBack(){
        print("333")
        hero.dismissViewController()
    }
    
    @objc func TapLeft(){
        print("111")
        index-=1
        if(index<0){
            index=0
        }
        scrollView.setContentOffset(CGPoint(x:Width*CGFloat(index),y:0), animated: true)
    }
    
    @objc func TapRight(){
        print("222")
        index+=1
        if(index>=4){
            let alter=UIAlertController(title: "", message: "没有更多了哦", preferredStyle: .alert)
            present(alter, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    alter.dismiss(animated: true)
            }
            index=3
        }
        scrollView.setContentOffset(CGPoint(x:Width*CGFloat(index),y:0), animated: true)
        print(index)
        print(scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        index=Int(scrollView.contentOffset.x)/Int(Width)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.x>0&&index==3){
            let alter=UIAlertController(title: "", message: "没有更多了哦", preferredStyle: .alert)
            present(alter, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    alter.dismiss(animated: true)
            }
        }
    }
 
}
