//
//  ViewController.swift
//  NearbyLocation
//
//  Created by Ikhwan on 04/12/22.
//

import UIKit
import MapKit
import FloatingPanel

class ViewController: UIViewController, FloatingPanelControllerDelegate {

    // MARK: -Properties
    let fpc = FloatingPanelController()
    
    let locationManager = CLLocationManager()

    let mapView = MKMapView()

    var mapItems: [MKMapItem] = [MKMapItem]()

    let suggestions = ["☕️ Coffee Shop", "🍽 Restaurant", "🏥 Hospital", "🎬 Movie", "🏢 Apartment"]

    var selectedSuggestion: String = ""
    
    // MARK: -View Props
    let activityIndicator = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()

    let myCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(SuggestionCollectionViewCell.self, forCellWithReuseIdentifier: SuggestionCollectionViewCell.identifier)
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()

        view.addSubview(mapView)
        view.addSubview(myCollectionView)

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        fpc.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        myCollectionView.backgroundColor = .clear
        myCollectionView.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.bottom + 20,
            width: view.width - 20,
            height: 60
        )
    }

    // MARK: -Activity Indicator View
    func showActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        self.view.isUserInteractionEnabled = false
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }


    // MARK: -Location Service
    func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

        mapView.showsUserLocation = true

        if let coordinate = locationManager.location?.coordinate {
            mapView.setRegion(
                MKCoordinateRegion(
                    center: coordinate,
                    latitudinalMeters: 10000,
                    longitudinalMeters: 10000
                ), animated: true)
        }
    }

    func searchLocation(name: String, completion: @escaping ([MKMapItem]) -> Void) {
        guard let location = locationManager.location else {
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )

        let search = MKLocalSearch(request: request)

        search.start { (response, error) in

            guard let response = response else {
                return
            }

            completion(response.mapItems)
        }
    }

    func setupAnnotations() {
        let annotations = self.mapView.annotations

        self.mapView.removeAnnotations(annotations)

        for mapItem in mapItems {
            self.mapView.addAnnotation(
                PlaceAnnotation(
                    title: mapItem.name,
                    coordinate: mapItem.placemark.coordinate
                )
            )
        }
    }
    
    // MARK: -Floating Panel
    func setupFloatingPanel() {
        fpc.removeFromParent()
        
        let contentVC = PlacesViewController(location: selectedSuggestion, items: mapItems)
        
        fpc.layout = MyFloatingPanelLayout()
        
        fpc.sheetPresentationController?.preferredCornerRadius = 20
        
        fpc.set(contentViewController: contentVC)
        
        fpc.track(scrollView: contentVC.tableView)
        
        // Create a new appearance.
        let appearance = SurfaceAppearance()

        // Define shadows
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 16
        shadow.spread = 8
        appearance.shadows = [shadow]

        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear

        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        fpc.addPanel(toParent: self)
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Automatically set width by text on view
        return CGSize(width: suggestions[indexPath.item].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]).width + 20, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = suggestions[indexPath.row]
        selectedSuggestion = item
        collectionView.reloadData()

        showActivityIndicator()

        searchLocation(name: item) { [weak self] result in
            DispatchQueue.main.async {
                self?.mapItems = result
                self?.setupAnnotations()
                self?.hideActivityIndicator()
                self?.setupFloatingPanel()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = suggestions[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SuggestionCollectionViewCell.identifier,
            for: indexPath
        ) as? SuggestionCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(title: item, isSelected: item == selectedSuggestion)
        return cell
    }
}


// Custom Layout For FPC
class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 64.0, edge: .bottom, referenceGuide: .safeArea),
    ]
}
