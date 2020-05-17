//
//  NearByTheatreViewController.swift
//  Movieland
//
//  Created by Hermes Obiang on 4/22/20.
//  Copyright © 2020 Hermes Obiang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearByTheatersViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    /********************************************************************/
    
    // variables declarations
    
    //declare  labels and connect them to the storyboard
    @IBOutlet weak var theater: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var Places: [MKMapItem] = [MKMapItem]()
    var cinemas = "Theaters:\n"
    var phone = ""
    let locationManager: CLLocationManager = CLLocationManager()
    
    /**********************************************************************/
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        initializeVariables()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading

    }
   
    
    
    func initializeVariables()
    {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
   
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if(status == .authorizedAlways || status == .authorizedWhenInUse)
        {
            run(after: 3)
            {
                self.performSearch()
            }
        }
        
        else if(status == .denied || status == .restricted)
        {
            let alert = UIAlertController(title: "Location Unavailable", message: "Authorize location services for this app in device settings", preferredStyle: .alert)
        
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler:
            {
                (action) in
                self.navigationController?.popViewController(animated: true)
                
            })
            
            alert.addAction(okayAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span = MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region = MKCoordinateRegion.init(center: myLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    
     func performSearch() {
            
            Places.removeAll()
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "cinemas"
            request.region = mapView.region
            
            let search = MKLocalSearch(request: request)
            mysearch(search: search)
            
        }
        
    // credits to the link below where I learned how to use MKLocalSearch
    //https://www.hackingwithswift.com/example-code/location/how-to-look-up-a-location-with-mklocalsearchrequest
        func mysearch(search:MKLocalSearch)
        {
            search.start(completionHandler: { (response,error) in
                if let results = response {
                    if let err = error {
                        print("Could not perform the search: \(err.localizedDescription)")
                        
                    }
                    else if results.mapItems.count == 0 {
                        print("No Movie Theaters Found")
                        
                    }
                    else {
                        print("Movie Theaters Found")
                        self.mapView.removeAnnotations(self.mapView.annotations)
                        self.Places = results.mapItems
                        for item in self.Places
                        {
                            self.cinemas += "\(item.name ?? ""), Phone: \(item.phoneNumber ?? "")\n"
                                   
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = item.placemark.coordinate
                            annotation.title = item.name
                            self.mapView.addAnnotation(annotation)
                                                                 
                        }
                        self.theater.text = self.cinemas
                    }
                }
            })
        }
    
    
    
    func run(after seconds: Int, completion: @escaping () -> Void)
    {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline)
        {
            completion()
        }
    }
}
