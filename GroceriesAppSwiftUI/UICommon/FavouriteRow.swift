//
//  FavouriteRow.swift
//  GroceriesAppSwiftUI
//
//  Created by rafiul hasan on 4/9/24.
//

import SwiftUI
// import SDWebImageSwiftUI

struct FavouriteRow: View {
    @State var fObj: ProductModel = ProductModel(dict: [:])
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                AsyncImage(url: URL(string: fObj.image)) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    case .success(let image):
                        image
                            .resizable()
                    default:
                        ProgressView()
                    }
                }
                // WebImage(url: URL(string: fObj.image ))
                // .resizable()
                // .indicator(.activity) // Activity Indicator
                // .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 60, height: 60)
                
                VStack(spacing: 4) {                    
                    Text(fObj.name)
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(fObj.unitValue)\(fObj.unitName), price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("$\(fObj.offerPrice ?? fObj.price, specifier: "%.2f" )")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            Divider()
        }
    }
}

struct FavouriteRow_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteRow()
    }
}
