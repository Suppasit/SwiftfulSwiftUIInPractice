//
//  SwiftfulSwiftUIInPracticeApp.swift
//  SwiftfulSwiftUIInPractice
//
//  Created by Suppasit chuwatsawat on 17/7/2567 BE.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftfulSwiftUIInPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
//                SpotifyHomeView()
                ContentView()
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
