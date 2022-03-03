//
//  AppMain.swift
//  ReSwiftDemo
//
//  Created by Jean Raphael Bordet on 24/02/22.
//

import SwiftUI
import ReSwift
import Combine

@main
struct AppMain: App {
	var body: some Scene {
		WindowGroup {
			CounterView()
				.environmentObject(
					AppStore(
						initial: AppState(
							counter: .init(
								counter: 0,
								isPrime: false
							)
						),
						reducer: appReducer,
						middlewares: [
							appMiddleware(
								service: .init()
							),
							logMiddleware()
						]
					)
				)
		}
	}
}

func logMiddleware() -> Middleware<AppState, AppAction> {
	return { state, action in
		print("Triggered action: \(action)")
		
		return Empty().eraseToAnyPublisher()
	}
	
}
