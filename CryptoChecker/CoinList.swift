//
//  CoinList.swift
//  CryptoChecker
//
//  Created by Jay Bergonia on 4/30/22.
//

import SwiftUI
import Combine

struct CoinList: View {
    
    @ObservedObject private var viewModel = CoinListViewModel()
    
    var body: some View {
//        Text("Hello World!")
//            .onAppear {
//                viewModel.fetchCoins()
//            }
        
        NavigationView {
            List(viewModel.coinViewModels, id: \.self) { coinViewModel in
                Text(coinViewModel.name + " - " + coinViewModel.formattedPrice)
            }.onAppear {
                self.viewModel.fetchCoins()
            }
            .navigationTitle(Text("📊CRYPTOCHECKER"))
        }

        
        //        VStack {
//            Image(systemName: "exclamationmark.icloud.fill")
//                .foregroundColor(.gray)
//                .font(.system(size: 60, weight: .heavy))
//                .padding(.bottom, 4)
//            Text("Oooopss")
//                .foregroundColor(.black)
//                .font(.system(size: 30, weight: .heavy))
//                .multilineTextAlignment(.center)
//        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinList()
    }
}

class CoinListViewModel: ObservableObject {
    
    private let cryptoService = CryptoService()
    
    @Published var coinViewModels = [CoinViewModel]()
    
    var cancellable: AnyCancellable?
    
    func fetchCoins() {
        cancellable = cryptoService.fetchCoins().sink(receiveCompletion: { _ in
            // do something for sink
            
        }, receiveValue: { cryptoContainer in
            self.coinViewModels = cryptoContainer.data.coins.map { CoinViewModel($0) }
            print(self.coinViewModels)
        })
        
        
    }
    
}

struct CoinViewModel: Hashable {
    private let coin: Coin
    
    init(_ coin: Coin) {
        self.coin = coin
    }
    
    var name: String {
        return coin.name
    }
    
    var formattedPrice: String {
        // do some formatting
        return coin.price
    }
}
