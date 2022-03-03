//
//  ReSwiftDemoTests.swift
//  ReSwiftDemoTests
//
//  Created by Jean Raphael Bordet on 24/02/22.
//

import XCTest
@testable import ReSwiftDemo
import ReSwift

class ReSwiftDemoTests: XCTestCase {
	
	func testIncr() {
		let store = TestStore(
			initial: CounterState(counter: 0),
			reducer: counterReducer
		)
		
		store.dispatch(.incr)
		
		XCTAssertEqual(store.state.counter, 1)
	}
	
	func testDecr() {
		let store = TestStore(
			initial: CounterState(counter: 0),
			reducer: counterReducer
		)
		
		store.dispatch(.decr)
		
		XCTAssertEqual(store.state.counter, -1)
	}
	
	func testIsPrime() {
		let store = TestStore(
			initial: CounterState(
				counter: 1,
				isPrime: false
			),
			reducer: counterReducer,
			middlewares: [
				counterMiddleware(service: CounterService())
			]
		)
						
		store.assert(
			when: .isPrime,
			then: { _ in }
		)
		
		store.assert(
			step: .receive,
			when: .isPrimeResponse(true),
			then: {
				$0.isPrime = true
			}
		)
	}

}
