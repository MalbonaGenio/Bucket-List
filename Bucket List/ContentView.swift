//
//  ContentView.swift
//  Bucket List
//
//  Created by Pau Valverde Molina on 11/19/24.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var locations = [Location]()
    @State private var selectedPlace: Location?

    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 35.67279, longitude: 136.69082),
            span: MKCoordinateSpan(latitudeDelta: 17, longitudeDelta: 17))
    )

    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                        //with iOS 18 seems to not work unless you have a minimunDuration set
                            .onLongPressGesture(minimumDuration: 0.2) {
                                selectedPlace = location
                            }
                    }
                }
            }
            .mapStyle(.standard(elevation: .realistic))
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(
                        id: UUID(), name: "New Location", description: "",
                        latitude: coordinate.latitude,
                        longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedPlace) { place in
                //Once it runs in will unwrap the optional Location object if any, then show the view with that data. Once dissmissed it will return nil again.
                Text(place.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
