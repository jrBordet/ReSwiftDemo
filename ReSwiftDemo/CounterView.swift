//
//  ContentView.swift
//  ReSwiftDemo
//
//  Created by Jean Raphael Bordet on 24/02/22.
//

import SwiftUI
import ReSwift

struct CounterView: View {
	@EnvironmentObject var store: AppStore
	
	var body: some View {
		HStack(
			alignment: .top,
			spacing: 10
		) {
			Button("-") {
				store.dispatch(.counter(.decr))
			}
			Text("\(store.state.counter.counter)")
			Button("+") {
				store.dispatch(.counter(.incr))
			}
		}
		
		VStack {
			Button("is prime") {
				store.dispatch(.counter(.isPrime))
			}
			
			Text(
				"is prime: \(String(store.state.counter.isPrime))"
			).opacity(store.state.counter.isPrime ? 1 : 0)
		}
	}
}

struct CounterView_Previews: PreviewProvider {
	static var previews: some View {
		CounterView()
			.environmentObject(
				CounterStore(
					initial: CounterState(counter: 10),
					reducer: counterReducer,
					middlewares: []
				)
			)
	}
}
