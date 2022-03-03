//
//  App.swift
//  ReSwiftDemo
//
//  Created by Jean Raphael Bordet on 02/03/22.
//

import Foundation
import ReSwift
import Combine

typealias AppStore = Store<AppState, AppAction>

struct AppState {
	var counter: CounterState
}

enum AppAction {
	case counter(CounterAction)
}


let appReducer: Reducer<AppState, AppAction> = { state, action in
	switch action {
	case let .counter(counterAction):
		counterReducer(&state.counter, counterAction)
	}
}

func appMiddleware(
	service: CounterService
) -> Middleware<AppState, AppAction> {
	return { state, action in
		switch action {
			
		case .counter(.isPrime):
			return service
				.isPrime(state.counter.counter)
				.subscribe(on: DispatchQueue.main)
				.map { AppAction.counter(.isPrimeResponse($0)) }
				.eraseToAnyPublisher()
			
		default:
			break
		}
		
		return Empty().eraseToAnyPublisher()
	}
}
