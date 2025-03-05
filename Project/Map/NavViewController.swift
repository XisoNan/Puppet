//
//  NavViewController.swift
//  Project
//
//  Created by 1234 on 2024/5/30.
//

import UIKit
import CoreLocation
import MapKit

class NavViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    var lot:Double=0
    var lat:Double=0
    var my_lat:Double=0
    var my_lot:Double=0
    var desc = CLLocationCoordinate2D()
    var locationManger:CLLocationManager?
    
    lazy var MapView:MKMapView={
        let view=MKMapView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(MapView)
        MapView.frame=self.view.frame
        MapView.delegate=self
        MapView.showsUserLocation = true
        
        self.locationManger=CLLocationManager()
        locationManger?.delegate=self
        locationManger?.desiredAccuracy = kCLLocationAccuracyBest
        locationManger?.requestWhenInUseAuthorization()
        locationManger?.startUpdatingLocation()
       
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(MapView.showsUserLocation)
//        if let location = locations.first{
//            if let location = locations.first {
//                let region = MKCoordinateRegion(center: location.coordinate,
//                                                latitudinalMeters: 1000,
//                                                longitudinalMeters: 1000)
//                MapView.setRegion(region, animated: true)
//            }
//        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .green
        return render
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
                case .authorizedWhenInUse, .authorizedAlways:
                    // 用户已授权，可以开始获取位置信息
                    startGettingLocation()
                case .notDetermined, .restricted, .denied:
                    // 用户尚未作出选择，权限受限，或者被拒绝
                    // 可以提示用户去设置打开权限
                    break
                @unknown default:
                    break
                }
    }
    
    func startGettingLocation(){
        let sourceLocation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (locationManger?.location?.coordinate.latitude)!, longitude: (locationManger?.location?.coordinate.longitude)!))
        let destinationLocation = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: self.lat, longitude: self.lot))
//        let destinationLocation = MKPlacemark(coordinate: desc)
                print("1")
            // 创建MapItem
            let sourceItem = MKMapItem(placemark: sourceLocation)
            let destinationItem = MKMapItem(placemark: destinationLocation)
                
        print("2")
            // 设置导航请求
            let request = MKDirections.Request()
            request.source = sourceItem
            request.destination = destinationItem
            request.transportType = .walking// 可选择其他交通方式
        request.requestsAlternateRoutes = true
                
            // 创建导航对象
            let directions = MKDirections(request: request)
                print("3")
        print("(\(self.lat),\(self.lot))")
        print("(\(locationManger?.location?.coordinate.latitude),\(locationManger?.location?.coordinate.longitude))")
            // 执行导航请求
        directions.calculate { [self] (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Something is wrong :(\(error))")
                }
                return
            }
               print("4")
        // 获取路线
        let route = response.routes[0]
        
                self.MapView.addOverlay(route.polyline)
                self.MapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (self.locationManger?.location?.coordinate.latitude)!, longitude: (locationManger?.location?.coordinate.longitude)!),span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta:0.004 ))
            MapView.setRegion(region, animated: true)
            
//            // 添加一个annotation
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = (locationManger?.location!.coordinate)!
//            annotation.title = "San Francisco"
//            MapView.addAnnotation(annotation)

        }
        

    }
    
    // 实现代理方法来定制指南针样式
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 复用annotation view
        let identifier = "customAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        // 设置大头针形状的图片
        
        return annotationView
    }
    
}

