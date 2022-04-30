//
//  CoinListView.swift
//  CryptoChecker
//
//  Created by Jay Bergonia on 4/30/22.
//

import SwiftUI

struct CoinListView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}

class CoinListViewModel: ObservableObject {
    
    @Published var coinViewModels = [CoinViewModel]()
    
}

struct CoinViewModel {
    private let coin: Coin
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        // do some formatting
        return coin.price
    }
}
