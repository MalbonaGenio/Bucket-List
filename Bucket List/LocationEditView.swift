//
//  LocationEditView.swift
//  Bucket List
//
//  Created by Pau Valverde Molina on 11/23/24.
//

import SwiftUI

struct LocationEditView: View {
    //Enviroment property to dismiss the view.
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    //We require a Location so we know we are receiving a location without doubts of it beign an optional. It allows for receiveing data from other views and send back data to those views.
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = location
                    //New id so the custom equatable comaparator is false and triggers a save and update of the view in ContentView.
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }

        }
    }
    
    //Custom initializer to create the instances of State, but not the values in them, those are passed trough the location.
    //Escaping function of onSave will stash it. This function will only run when the location valus are saved.
    init(location: Location, onSave: @escaping (Location) -> Void) {
        //Store the location of the initialize into the local property of the view.
        self.location = location
        self.onSave = onSave
        
        //Creates the instance of the property wrapper state, but without the data.
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
}

#Preview {
    // Passing a placeholder closure so the preview works. { _ in }
    LocationEditView(location: .example) { _ in }
}
