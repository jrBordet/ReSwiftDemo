//
//  Counter.swift
//  ReSwiftDemo
//
//  Created by Jean Raphael Bordet on 24/02/22.
//

import Foundation
import ReSwift
import Combine

struct CounterState {
	var counter: Int = 0
	var isPrime: Bool = false
}

extension CounterState: Equatable { }

enum CounterAction {
	case incr, decr
	
	case isPrime, isPrimeResponse(Bool)
}

typealias CounterStore = Store<CounterState, CounterAction>

let counterReducer: Reducer<CounterState, CounterAction> = { state, action in
	switch action {
	case .incr:
		state.counter = state.counter + 1
	case .decr:
		state.counter = state.counter - 1
	case .isPrime:
		// resolved in counterMiddleware
		break
	case let .isPrimeResponse(value):
		state.isPrime = value
	}
}

func counterMiddleware(
	service: CounterService
) -> Middleware<CounterState, CounterAction> {
	return { state, action in
		switch action {
			
		case .isPrime:
			return service
				.isPrime(state.counter)
				.subscribe(on: DispatchQueue.main)
				.map { CounterAction.isPrimeResponse($0) }
				.eraseToAnyPublisher()
			
		default:
			break
		}
		
		return Empty().eraseToAnyPublisher()
	}
}

struct CounterService {
	func isPrime(_ n: Int) -> AnyPublisher<Bool, Never> {
		Future<Bool, Never> { promise in
			DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
				promise(.success(true))
			})
		}
		.eraseToAnyPublisher()
	}
}
