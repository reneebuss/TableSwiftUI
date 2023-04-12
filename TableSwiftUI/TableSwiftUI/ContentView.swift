//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Buss, Renee on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Valentinos", vibe: "Restaurant", desc: "night out slice of pizza. They sell drinks as well but are for sure more well known for their slices and being right on the square.", lat: 29.882510, long: -97.939770, imageName: "rest1"),
    Item(name: "Crafthouse", vibe: "Restaurant", desc: "The drinks and food are good and well priced. They often having sports on and karaoke nights.", lat: 29.884260, long: -97.940109, imageName: "rest2"),
    Item(name: "Axis", vibe: "Bar", desc: "A good option for larger drinks such as pitchers. Theres spots for karaoke and pictures.", lat: 29.883460, long: -97.939970, imageName: "rest3"),
    Item(name: "Aquarium", vibe: "Bar", desc: "The newest bar on the square that is almost the exact same as the one on 6th Street. The drinks are good but slightly expensive. ", lat: 29.881720, long: -97.941510, imageName: "rest4"),
    Item(name: "Blind Salamander", vibe: "Bar/Restaurant", desc: "A relaxing yet fun place for drinks and some snacks. A little bit more expensive for what it is, but still good and friendly.", lat: 29.884610, long: -97.940680, imageName: "rest5")
   
]

struct Item: Identifiable {
       let id = UUID()
       let name: String
       let vibe: String
       let desc: String
       let lat: Double
       let long: Double
       let imageName: String
   }

struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:29.884610 , longitude: -97.940680), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    var body: some View {
        NavigationView {
            VStack {
                List(data, id: \.name) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.vibe)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                Map(coordinateRegion: $region, annotationItems: data) { item in
                               MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                   Image(systemName: "mappin.circle.fill")
                                       .foregroundColor(.red)
                                       .font(.title)
                                       .overlay(
                                           Text(item.name)
                                               .font(.subheadline)
                                               .foregroundColor(.black)
                                               .fixedSize(horizontal: true, vertical: false)
                                               .offset(y: 25)
                                       )
                               }
                           }
                           .frame(height: 300)
                           .padding(.bottom, -30)
                .listStyle(PlainListStyle())
                       .navigationTitle("San Marcos Drinks")
            }
        }
       
    }
}

struct DetailView: View {
    @State private var region: MKCoordinateRegion
          
          init(item: Item) {
              self.item = item
              _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
          }
    
      let item: Item
              
      var body: some View {
          VStack {
              Image(item.imageName)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(maxWidth: 200)
              Text("Vibe: \(item.vibe)")
                  .font(.subheadline)
              Text("Description: \(item.desc)")
                  .font(.subheadline)
                  .padding(10)
                  }
                   .navigationTitle(item.name)
                   Spacer()
          Map(coordinateRegion: $region, annotationItems: [item]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                        .overlay(
                            Text(item.name)
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .offset(y: 25)
                        )
                }
            }
                .frame(height: 300)
                .padding(.bottom, -30)
              
       }
    
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
