//
//  ViewController.swift
//  Quizzier
//]
//  Created by liyuehang on 2023/11/14.
//

import UIKit
import SnapKit
import MapKit


class MapViewController: UIViewController{
    
    let DrageViewCellID="DrageViewCellID"
    
    var index=[0,0,0,0,0]
    var lat:Float=0
    var lot:Float=0
    
    lazy var Start:UIButton={
        let btn=UIButton()
        btn.layer.cornerRadius = 1
        btn.backgroundColor = .orange
        btn.setTitle("开始", for: .normal)
        btn.addTarget(self, action: #selector(StartHandle), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font=UIFont(name: "Arial", size: 16)
        return btn
    }()
    
    lazy var MapView:MKMapView={
        let view=MKMapView()
        return view
    }()
    

    
    lazy var DrageView:UICollectionView={
        let layout=UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 30
        let view=UICollectionView(frame: CGRect(x:0,y:300,width:view.bounds.width,height:view.bounds.height-330),collectionViewLayout: layout)
        view.collectionViewLayout = layout
        view.dataSource = self
        view.delegate=self
        view.showsVerticalScrollIndicator=false
        view.translatesAutoresizingMaskIntoConstraints=false
        view.register(DrageViewCell().classForCoder, forCellWithReuseIdentifier: DrageViewCellID)
        view.backgroundColor = .init(red: 241/255, green: 241/255, blue: 235/255, alpha: 1)
        return view
    }()
    
    func setUpNav(){
        navigation.bar.isHidden=true
        navigation.bar.alpha=0

        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(Handleback))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func Handleback(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        self.view.addSubview(MapView)
        self.view.addSubview(DrageView)
        self.view.addSubview(Start)
        self.view.backgroundColor  = .white
        MapView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(self.view.bounds.width)
            make.height.equalTo(300)
        }
        Start.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(65)
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(258)
        }
        Start.layer.cornerRadius = 5
        DrageView.layer.cornerRadius = 12
        let regionRadius:CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.996, longitude: 105.004),span: MKCoordinateSpan(latitudeDelta: 1.8, longitudeDelta:1.8 ))
        MapView.setRegion(region, animated: true)
        MapView.delegate = self
        for i in 0..<5{
            //创建一个大头针对象
            var objectAnnotation = MKPointAnnotation()
            //设置大头针的显示位置
            switch i{
            case 0:
                objectAnnotation.coordinate = CLLocation(latitude: 27.559739381011667, longitude: 119.7118197055006).coordinate
                //设置点击大头针之后显示的标题
                objectAnnotation.title = "浙江 泰顺"
                //设置点击大头针之后显示的描述
                objectAnnotation.subtitle = "文祥剧场"
                break
            case 1:
                objectAnnotation.coordinate = CLLocation(latitude: 24.508829477089535, longitude: 117.65544171080847).coordinate
                //设置点击大头针之后显示的标题
                objectAnnotation.title = "福建 漳州"
                //设置点击大头针之后显示的描述
                objectAnnotation.subtitle = "木偶艺术表演馆"
                break
            case 2:
                objectAnnotation.coordinate = CLLocation(latitude: 25.033988333785388, longitude: 118.79305585920514).coordinate
                //设置点击大头针之后显示的标题
                objectAnnotation.title = "泉州 惠安"
                //设置点击大头针之后显示的描述
                objectAnnotation.subtitle = "文化中心"
                break
            case 3:
                objectAnnotation.coordinate = CLLocation(latitude: 24.808056911851494, longitude: 120.99141034838317).coordinate
                //设置点击大头针之后显示的标题
                objectAnnotation.title = "上海"
                //设置点击大头针之后显示的描述
                objectAnnotation.subtitle = "仙乐斯木偶展演中心"
                break
            case 4:
                objectAnnotation.coordinate = CLLocation(latitude: 22.633961980765193, longitude: 113.80936008914858).coordinate
                //设置点击大头针之后显示的标题
                objectAnnotation.title = "深圳 宝安"
                //设置点击大头针之后显示的描述
                objectAnnotation.subtitle = "西乡会堂大剧场"
                break
            default:
                break
            }

            self.MapView.addAnnotation(objectAnnotation)
        }
    }
    
    
    func ChangeLoc(_ lat:Double,_ lot:Double){
        let Loc=CLLocation(latitude: lat, longitude: lot)//浙江泰顺
        let regionRadius:CLLocationDistance = 1000
        var region = MKCoordinateRegion(center: Loc.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        region.span=MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta:0.009 )
        MapView.setRegion(region, animated: true)
    }
    
    // 实现mapView(_:viewFor:)方法来自定义点注解视图
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 检查注解是否是MKPointAnnotation类型
        guard annotation is MKPointAnnotation else { return nil }
        
        // 重用注解视图
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true // 允许弹出窗口
        } else {
            annotationView?.annotation = annotation
        }
        
        // 设置点注解点击事件
        if let pinView = annotationView as? MKMarkerAnnotationView {
            pinView.tintColor = .orange // 设置大头针颜色
            pinView.isEnabled = true // 设置大头针响应点击事件
            pinView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mapPinTapped(_:))))
        }
        return annotationView
    }
    
    @objc func mapPinTapped(_ sender:UITapGestureRecognizer){
        print(111)
    }
    
    @objc func StartHandle(){
        if(self.lat==0&&self.lot==0){
            let alter=UIAlertController(title:"" , message: "请先选择前往地点哦", preferredStyle: .alert)
            present(alter,animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                alter.dismiss(animated: true)
            }
        }
        let navc=NavViewController()
        navc.lat=Double(self.lat)
        navc.lot=Double(self.lot)
        self.navigationController?.pushViewController(navc, animated: false)
        
    }
    
}

extension MapViewController:MKMapViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrageViewCellID, for: indexPath) as! DrageViewCell
            // 配置cell
        cell.backgroundColor = .white
        cell.title.textAlignment = .left
        cell.image.image=UIImage(named: "药发木偶")
        cell.select.alpha=CGFloat(index[indexPath.row])
        cell.chLbl.alpha=CGFloat(index[indexPath.row])
        switch indexPath.row{
        case 0:
            cell.title.text="浙南明珠 非遗薪传"
            cell.loc.text="地点: 浙江 泰顺 文祥剧场"
            cell.time.text="时间: 2024/1/5-1/6"
            cell.info.text="简介: 本届分为两场,分别是上午场的“跨越千年·继承传统”和下午场的“推陈出新·薪火相传"
            cell.image.image=UIImage(named:"泰顺")
            cell.info.numberOfLines=0
            break
        case 1:
            cell.title.text="“拢”来新年 ”偶“遇新年"
            cell.loc.text="地点: 漳州古城木偶艺术表演馆"
            cell.time.text="时间: 2023/12/30—2024/1/1"
            cell.info.text="简介: 将邀请国内木偶届同行一同展示木偶艺术的独特魅力，让市民和游客在漳州就能观赏到各地优秀的木偶戏曲，玩转不一样的新年。"
            cell.image.image=UIImage(named:"漳州")
            cell.info.numberOfLines=0
            break
        case 2:
            cell.title.text="“偶”遇惠安 精彩纷呈"
            cell.loc.text="地点: 泉州 惠安 文化中心"
            cell.time.text="时间: 2023/12/8-12/12"
            cell.info.text="简介: 由国内外木偶艺术表演团队带来30场表演，同时还承办闭幕式，超过1万人就地享受到这场专业性、艺术性、普惠性的木偶狂欢盛宴。"
            cell.image.image=UIImage(named:"泉州")
            cell.info.numberOfLines=0
            break
        case 3:
            cell.title.text="World on the Fingertips"
            cell.loc.text="地点: 上海 仙乐斯木偶演展中心"
            cell.time.text="时间: 2023/9/27-12/2"
            cell.info.text="简介: 上海国际木偶艺术节作为上海国际艺术节“节中节”，不仅是传承和发扬国家级非物质文化遗产海派木偶戏的重要平台，更是弘扬中华优秀传统文化、推动中外艺术交流、打造上海城市文化品牌的有力举措。"
            cell.image.image=UIImage(named:"上海")
            cell.info.numberOfLines=0
            break
        case 4:
            cell.title.text="耕海牧渔·偶「艺」之歌"
            cell.loc.text="地点: 深圳 宝安 西乡会堂大剧场"
            cell.time.text="时间: 2023/8/24-9/4"
            cell.info.text="简介: 本届木偶艺术节分为偶“艺”戏聚会、偶“艺”剧院、偶“艺”研讨会、偶“艺”会客厅、偶“艺”青秀场五个板块。"
            cell.image.image=UIImage(named:"深圳")
            cell.info.numberOfLines=0
            break
        default:
            break
        }
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("ok")
    }
    
    func CollectionView(_ CollectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width-40, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index=[0,0,0,0,0]
        index[indexPath.row]=1
        switch indexPath.row{
        case 0:
//            let Loc=CLLocation(latitude: , longitude: 119.3712)
            ChangeLoc(27.559739381011667,119.7118197055006)
            self.lat=27.559739381011667
            self.lot=119.7118197055006
            break
        case 1:
            ChangeLoc(24.508829477089535,117.65544171080847)//福建漳州
            self.lat=24.508829477089535
            self.lot=117.65544171080847
            break
        case 2:
            ChangeLoc(25.033988333785388,118.79305585920514)//福建泉州
            self.lat=25.033988333785388
            self.lot=118.79305585920514
            break
        case 3:
            print(111)
            ChangeLoc(24.808056911851494,120.99141034838317)//上海展演
            self.lat=24.808056911851494
            self.lot=120.99141034838317
            break
        case 4:
            ChangeLoc(22.633961980765193,113.80936008914858)//深圳宝安
            self.lat=22.633961980765193
            self.lot=113.80936008914858
            break
        default:
            break
        }
        collectionView.reloadData()
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("map loading fail")
    }
    
    
    
}

