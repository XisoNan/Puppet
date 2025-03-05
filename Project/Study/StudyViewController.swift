//
//  ViewController.swift
//  Main
//
//  Created by 1234 on 2024/3/19.
//


import UIKit
import SnapKit
import SpriteKit

var cur_index=0
let MuOuImage=["提线木偶","布袋木偶","杖头木偶","铁枝木偶","药发木偶"]

class StudyViewController: UIViewController,UIScrollViewDelegate{
//    var progressView=ProgressView()
    var scrollView = UIScrollView()
    
    lazy var medal:UIImageView={
        let imageView=UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image=UIImage(named: "Medal")
        return imageView
    }()
    
    lazy var backImage:UIImageView={
        let imageView=UIImageView(frame: self.view.frame)
        imageView.image=UIImage(named: "戏台")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var MuOuName:UILabel={
        let lbl=UILabel(frame: CGRect(x:310,y:51,width:40,height:130))
        lbl.font=UIFont(name: "AiDian-QianFengXingKai", size: 22)
        lbl.textAlignment = .center
        lbl.numberOfLines=0
        lbl.text=ChangeText(old:MuOuImage[cur_index])
        return lbl
    }()
    
    lazy var Start:UIImageView={
        let imageView=UIImageView()
        imageView.image=UIImage(named: "start")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cur_index=0
    }
    
    override func viewDidLoad() {
//        print("start")
        super.viewDidLoad()
        setUpNav()
        setupUI()
        medal.alpha=0
    }
    
    @objc func Handleback(){
        navigationController?.popViewController(animated: true)
    }
    
    func setUpNav(){
        navigation.bar.isHidden=true
        navigation.bar.alpha=0

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
        navigationItem.leftBarButtonItem = backButton
    }
    

    
    func setupUI(){
        self.view.addSubview(backImage)
        scrollView = UIScrollView ()
        //设置代理
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake ( CGFloat (Width*5),
                     0)
        scrollView.isPagingEnabled =  true
        scrollView.showsHorizontalScrollIndicator =  false
        scrollView.showsVerticalScrollIndicator =  false
        scrollView.scrollsToTop =  false
        for i in 0..<5{
            let tap=UITapGestureRecognizer(target: self, action: #selector(TapHandle))
            let  imageView = UIImageView (image: UIImage (named: "\(MuOuImage[i])"))
            scrollView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview().offset(Width*CGFloat(i))
                make.width.equalTo(360)
                make.top.equalToSuperview().offset(10)
                make.height.equalTo(830)
            }
            imageView.isUserInteractionEnabled=true
            scrollView.addSubview(imageView)
            imageView.addGestureRecognizer(tap)
            self.view.addSubview(MuOuName)
        }
        self.view.addSubview(Start)
        Start.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(150)
            make.bottom.equalToSuperview().offset(-150)
            make.width.equalTo(110)
            make.height.equalTo(110)
        }
        let start_tap=UITapGestureRecognizer(target: self, action: #selector(TapStart))
        Start.isUserInteractionEnabled=true
        Start.addGestureRecognizer(start_tap)

        self.view.addSubview(medal)
        medal.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(100)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(100)
        }
        medal.isUserInteractionEnabled=true
        
        let tapToMedal=UITapGestureRecognizer(target: self, action: #selector(TapToMedalHandle))


        medal.addGestureRecognizer(tapToMedal)
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(Width)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-275)
        }
        
//        progressView.alpha = 0
       
    }
    
    @objc func TapStart(){
        print("start")
        let MuOuVC=MuOuViewController()

        MuOuVC.dataFrom=MuOuImage[cur_index]
        MuOuVC.img = captureScreenshot(vc: self)!
        MuOuVC.modalPresentationStyle = .fullScreen
        MuOuVC.hero.isEnabled = true

        navigationController?.pushViewController(MuOuVC, animated: false)
    }
    
    @objc func TapLeft(){
        cur_index-=1
        if(cur_index<0){
            cur_index=0
        }
        scrollView.setContentOffset(CGPoint(x:Width*CGFloat(cur_index),y:0), animated: true)
//        self.progressView.labelP.text="\(cur_index+1)/5"
    }
    @objc func TapRight(){
        cur_index+=1
        if(cur_index>=5){
            let alter=UIAlertController(title: "", message: "没有更多了哦", preferredStyle: .alert)
            present(alter, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    alter.dismiss(animated: true)
            }
            cur_index=4
        }
        scrollView.setContentOffset(CGPoint(x:Width*CGFloat(cur_index),y:0), animated: true)
//        self.progressView.labelP.text="\(cur_index+1)/5"
    }
    
    @objc func TapHandle(){
        print(111)
        let MuOuVC=MuOuViewController()

        MuOuVC.dataFrom=MuOuImage[cur_index]
        MuOuVC.img = captureScreenshot(vc: self)!
        MuOuVC.modalPresentationStyle = .fullScreen
        MuOuVC.hero.isEnabled = true

        navigationController?.pushViewController(MuOuVC, animated: false)
    }
    
    func captureScreenshot(vc: UIViewController) -> UIImage? {
        // 创建一个与当前屏幕尺寸相同的图形上下文
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        let renderer = UIGraphicsImageRenderer(size: UIScreen.main.bounds.size, format: format)
        
        // 在图形上下文中绘制当前页面内容
        let image = renderer.image { context in
            let currentView = vc.view!
            currentView.drawHierarchy(in: currentView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    @objc func TapToMedalHandle(){
        let MedalVC=MedalViewController()
        MedalVC.img = captureScreenshot(vc: self)!
        MedalVC.modalPresentationStyle = .fullScreen
        MedalVC.hero.isEnabled = true
        self.present(MedalVC, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        cur_index=Int(scrollView.contentOffset.x)/Int(Width)
        self.MuOuName.text=ChangeText(old:MuOuImage[cur_index])
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.x>0&&cur_index==4){
            let alter=UIAlertController(title: "", message: "没有更多了哦", preferredStyle: .alert)
            present(alter, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                alter.dismiss(animated: true)
            }
        }
    }
    
    override  func  didReceiveMemoryWarning() {
        super .didReceiveMemoryWarning()
    }
    
}
