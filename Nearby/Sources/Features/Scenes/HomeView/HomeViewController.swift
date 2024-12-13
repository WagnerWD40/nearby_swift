//
//  HomeViewController.swift
//  Nearby
//
//  Created by Wagner Lemos Ferreira da Luz on 12/12/24.
//

import Foundation
import UIKit
import MapKit

class HomeViewController: UIViewController {
    private var places: [Place] = []
    private let homeView = HomeView()
    private var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = homeView
        homeView.mapView.delegate = self
        homeView.configureTableViewDelegate(self, dataSource: self)
        defineInitialLocation()
        
        homeViewModel.fetchInitialData { [weak self] categories in
            guard let self = self else { return }
            self.homeView.updateFilterButtons(with: categories) { selectedCategory in
                self.filterPlaces(by: selectedCategory)
            }
            
            
        }
        
        self.addAnnotationsTopMap()
        homeViewModel.didUpdatePlaces = { [weak self] in
            DispatchQueue.main.async {
                self?.places = self?.homeViewModel.places ?? []
                self?.homeView.reloadTableViewData()
                self?.addAnnotationsTopMap()
            }
        }
    }
    
    private func filterPlaces(by category: Category) {
        let currentCenter = homeView.mapView.region.center
        homeViewModel.fetchPlaces(for: category.id, userLocation: currentCenter)
    }
    
    private func defineInitialLocation() {
        let initialLocation = CLLocationCoordinate2D(latitude: -23.56118793883441, longitude: -46.656451388116494)
        homeView.mapView.setRegion(
            MKCoordinateRegion(
                center: initialLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            ),
            animated: true
        )
    }
    
    private func addAnnotationsTopMap() {
        homeView.mapView.removeAnnotations(homeView.mapView.annotations)
        let annotations = places.map { PlaceAnnotation(place: $0) }
        
        homeView.mapView.addAnnotations(annotations)
        
        if let firstAnnotation = annotations.first {
            homeView.mapView.setRegion(
                MKCoordinateRegion(
                    center: firstAnnotation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
                animated: true)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: places[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let details = DetailsViewController()
        details.place = places[indexPath.row]
        navigationController?.pushViewController(details, animated: true)
    }
    
    
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapview: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "CustomPin"
        var annotationView = mapview.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let pinImage = UIImage(named: "mapPin") {
                annotationView?.image = pinImage
                annotationView?.frame.size = CGSize(width: 28, height: 32)
            }
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
        
    }
    
    func mapView(_ mapview: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else { return }
    }
}
