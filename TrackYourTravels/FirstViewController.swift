//
//  FirstViewController.swift
//  TrackYourTravels
//
//  Created by Jidde Koekoek on 30/05/16.
//  Copyright © 2016 Jidde Koekoek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    // RayWenderlich: Background App Refresh
    var locations = [MKPointAnnotation]()
    
    // RayWenderlich: Background App Refresh, instance of CLLocation manager.
    lazy var locationManager: CLLocationManager! = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 100
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        
        return manager
    }()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startMonitoringSignificantLocationChanges()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - CLLocationManagerDelegate
    
    /// RayWenderlich: Background App Refresh
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        // Add another annotation to the map.
        let annotation = MKPointAnnotation()
        annotation.coordinate = newLocation.coordinate
        
        // Also add to our map so we can remove old values later
        locations.append(annotation)
        
        // Remove values if the array is too big
//        while locations.count > 100 {
//            let annotationToRemove = locations.first!
//            locations.removeAtIndex(0)
//            
//            // Also remove from the map
//            mapView.removeAnnotation(annotationToRemove)
//        }
        
        // If app is in foreground
        if UIApplication.sharedApplication().applicationState == .Active {
            mapView.showAnnotations(locations, animated: true)
            
            let latitude = newLocation.coordinate.latitude
            let longitude = newLocation.coordinate.longitude
            let stamp = newLocation.timestamp
            let speed = newLocation.speed
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let timestamp = dateFormatter.stringFromDate(stamp)
            
            DatabaseManager.sharedInstance.writeToDatabase(timestamp, lat: latitude, long: longitude, speed: speed)
        }
        // If app is in background
        else {
            NSLog("App is backgrounded. New location is %@", newLocation)
            mapView.showAnnotations(locations, animated: true)
            
            let latitude = newLocation.coordinate.latitude
            let longitude = newLocation.coordinate.longitude
            let stamp = newLocation.timestamp
            let speed = newLocation.speed
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            let timestamp = dateFormatter.stringFromDate(stamp)
            
            print("Background location update: \(latitude)")
            print("Background location update: \(longitude)")
            print("Background location update: \(timestamp)")
            print("Background location update: \(speed)")
            
            DatabaseManager.sharedInstance.writeToDatabase(timestamp, lat: latitude, long: longitude, speed: speed)
        }
    }
}


extension FirstViewController: MKMapViewDelegate {
    
    
    
    
    
}










