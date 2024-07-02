//
//  DessertDetailsView.swift
//  Desserts Receipe
//
//  Created by Amey Kanunje on 6/29/24.
//

import SwiftUI

struct DessertDetailsView: View {
    @StateObject private var dessertsViewModel: DessertDetailsViewModel
    let mealID: String

    init(mealID: String) {
        self.mealID = mealID
        _dessertsViewModel = StateObject(wrappedValue: DessertDetailsViewModel())
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if dessertsViewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = dessertsViewModel.error {
                        Text("Error: \(error.localizedDescription)")
                            .foregroundColor(.red)
                    } else if let mealDetails = dessertsViewModel.mealDetails {
                        // Dessert Name
                        Text(mealDetails.mealName)
                            .font(.title)
                        
                        // Image
                        if let imageURL = URL(string: mealDetails.mealImage) {
                            AsyncImage(url: imageURL) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 200)
                        }
                        
                        // Instructions
                        Text("Instructions:")
                            .font(.system(size: 22, weight: .bold))
                        Text(mealDetails.mealInstructions)
                            .font(.body)
                        
                        // Ingredients
                        Text("Ingredients:")
                            .font(.system(size: 22, weight: .bold))
                        ForEach(dessertsViewModel.getIngredients().indices, id: \.self) { index in
                            let (ingredient, measure) = dessertsViewModel.getIngredients()[index]
                            if !ingredient.isEmpty, !measure.isEmpty {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(ingredient) : \(measure)")
                                        .font(.body)
                                }
                            }
                        }
                    } else {
                        Text("No details available")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Dessert Details")
        .onAppear {
            dessertsViewModel.fetchDessertDetailsData(mealID: mealID)
        }
    }
}

#if DEBUG
struct DessertDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DessertDetailsView(mealID: "52893")
    }
}
#endif
