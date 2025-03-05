//
//  ViewController.swift
//  Main
//
//  Created by 1234 on 2024/3/19.
//

import UIKit
import SnapKit
import Lottie
class LaunchViewController: UIViewController,UIScrollViewDelegate, CAAnimationDelegate{
    var timer:Timer?
    var animationView:LottieAnimationView!
    //模糊效果
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.view.frame
        effectView.alpha=0.6
        return effectView
    }()
//    var animationview:AnimationView?
    lazy var Back:UIImageView={
        let imageView=UIImageView()
        imageView.frame=self.view.frame
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var L_lbl:UILabel={
        let lbl=UILabel()
        lbl.text=ChangeText(old: "|木偶共舞")
        lbl.textAlignment = .center
        lbl.numberOfLines=0
        lbl.font=UIFont.init(name: "HBGaoQingRuiMao", size: 35)
        return lbl
        
    }()
    
    lazy var R_lbl:UILabel={
        let lbl=UILabel()
        lbl.text=ChangeText(old: "|文化共鸣")
        lbl.textAlignment = .center
        lbl.numberOfLines=0
        lbl.font=UIFont.init(name: "HBGaoQingRuiMao", size: 35)
        return lbl
        
    }()
    
    lazy var Icon:UIImageView={
        let im=UIImageView()
        im.contentMode = .scaleAspectFit
        im.image=UIImage(named: "App_name")
        return im
    }()
    
    lazy var FortuneView:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var Puppet1:UIImageView={
        let imageview=UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    lazy var Puppet2:UIImageView={
            let imageview=UIImageView()
            imageview.contentMode = .scaleAspectFit
            return imageview
    }()
    
    lazy var Loading:UILabel={
        let lbl=UILabel()
        lbl.font=UIFont(name: "Arial", size: 19)
        lbl.text="正在加载内容。。。"
        return lbl
    }()
    
    lazy var Puppet3:UIImageView={
        let imageview=UIImageView()
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.Back.image=UIImage(named: "Launch_back")
        self.view.addSubview(Back)
        self.view.addSubview(FortuneView)
        self.view.addSubview(Puppet1)
        self.view.addSubview(Puppet2)
        self.view.addSubview(Puppet3)
        Puppet1.image=UIImage(named: "Component_1")
        Puppet2.image=UIImage(named:"Component")
        Puppet3.image=UIImage(named: "Component_3")
//        FortuneView.image=UIImage(named: "木签")
        
        Puppet1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(196)
            make.left.equalToSuperview().offset(155)
            make.width.equalTo(87)
            make.height.equalTo(150)
        }
        Puppet2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(300)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(87)
            make.height.equalTo(150)
        }
        Puppet3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.right.equalToSuperview().offset(-35)
            make.width.equalTo(87)
            make.height.equalTo(150)
        }
        
        FortuneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(180)
        }
        let tap1=UITapGestureRecognizer(target: self, action: #selector(tapView1))
        let tap2=UITapGestureRecognizer(target: self, action: #selector(tapView2))
        let tap3=UITapGestureRecognizer(target: self, action: #selector(tapView3))
        Puppet1.isUserInteractionEnabled=true
        Puppet2.isUserInteractionEnabled=true
        Puppet3.isUserInteractionEnabled=true
        Puppet1.addGestureRecognizer(tap1)
        Puppet2.addGestureRecognizer(tap2)
        Puppet3.addGestureRecognizer(tap3)
        
        
        self.view.addSubview(L_lbl)
        self.view.addSubview(R_lbl)
        L_lbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(70)
            make.height.equalTo(300)
        }
        self.view.addSubview(R_lbl)
        R_lbl.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(70)
            make.height.equalTo(300)
        }
        self.view.addSubview(Icon)
        Icon.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-230)
            make.centerX.equalToSuperview()
            make.width.equalTo(210)
            make.height.equalTo(70)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //恢复透明度
        self.Puppet1.alpha=1
        self.Back.alpha=1
        self.Puppet2.alpha=1
        self.Puppet3.alpha=1
        self.L_lbl.alpha=1
        self.R_lbl.alpha=1
        self.Icon.alpha=1
    }
    
    @objc func tapView1(){
        let studyVC=StudyViewController()
        navigationController?.pushViewController(studyVC, animated: true)
//        let tv=TempViewController()
//        navigationController?.pushViewController(tv, animated: true)
    }
    
    @objc func tapView2(){
//        let ARVC=ARVC()
//        navigationController?.pushViewController(ARVC, animated: true)
        self.Back.alpha=0.1
        self.Puppet1.alpha=0.1
        self.Puppet2.alpha=0.1
        self.Puppet3.alpha=0.1
        self.L_lbl.alpha=0.1
        self.R_lbl.alpha=0.1
        self.Icon.alpha=0.1
        animationView=LottieAnimationView(name: "loading2")
        animationView.frame=CGRect(x: Width/2-130, y: Height/2-50, width: Width/2+80, height: 100)
        self.view.addSubview(animationView)
        animationView.animationSpeed=CGFloat(3.0)
        animationView.play()
        //开启定时器
        timer=Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(Turn), userInfo: nil, repeats: false)
        self.view.addSubview(Loading)
        Loading.snp.makeConstraints { make in
            make.bottom.equalTo(animationView.snp.top).offset(30)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        Loading.textColor = .brown
    }
    
    @objc func tapView3(){
        print("111")
//        let vc=MineViewController()
        let vc=MapViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func Turn(){
        //关闭进度，页面转场
        animationView.removeFromSuperview()
        Loading.removeFromSuperview()
        let XiYu=XiYu()
        XiYu.img = captureScreenshot(vc: self)!
        XiYu.modalPresentationStyle = .fullScreen
        XiYu.hero.isEnabled = true

        navigationController?.pushViewController(XiYu, animated: false)
    }
    
    
    
    func createArtisticLetter(letter: String, color: UIColor) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
        let image = renderer.image { context in
            // 设置背景颜色为白色
            UIColor.clear.setFill()
            context.fill(context.format.bounds)
            
            // 设置字体大小和字体
            let font = UIFont(name: "Arial Rounded MT Bold", size: 50.0)!
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
            
            // 将字母放置在视图中心，并绘制
            letter.draw(in: context.format.bounds, withAttributes: attributes)
            
            // 添加更多艺术效果，比如: 模糊，阴影等
            // context.cgContext.setShadow(...
            // context.cgContext.setBlendMode(.softLight)
        }
        return image
    }

}




