//
//  timeApp.swift
//  time
//
//  Created by Kynson Szetau on 6/6/2024.
//

import SwiftUI

@main
struct timeApp: App {
    @Environment(\.openWindow) private var openWindow
    
    var body: some Scene {
        Window("", id: "main") {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willBecomeActiveNotification)) { _ in
                    onApplicationActive()
                }
        }
        Window("Preferences", id: "preferences") {
            PreferencesView()
        }
        .defaultSize(width: 800, height: 550)
        MenuBarExtra("Time Menu", image: "MenuBarIcon") {
            VStack {
                Button("Preferences...") {
                    openWindow(id: "preferences")
                }
                Button("Quit") {
                    NSRunningApplication.current.terminate()
                }
            }
        }
    }
    
    // TODO: Use newer API on SwiftUI when it is out of beta https://developer.apple.com/documentation/swiftui/scene/
    func onApplicationActive() {
        let mainWindow = NSApplication.shared.windows.filter { window in
            return window.identifier?.rawValue == "main"
        }[0]
        let screenFrame = NSScreen.main?.frame
        
        mainWindow.backgroundColor = .clear.withAlphaComponent(0.0001)
        mainWindow.level = NSWindow.Level(Int(CGWindowLevelForKey(.desktopIconWindow)))
        mainWindow.collectionBehavior = [
            .stationary,
            .ignoresCycle,
            .fullScreenNone
        ]
        mainWindow.hasShadow = false
        mainWindow.titlebarAppearsTransparent = true
        mainWindow.isMovable = false
        mainWindow.styleMask = .borderless
        mainWindow.setContentSize(NSMakeSize(screenFrame?.width ?? 1024, screenFrame?.height ?? 1024))
        mainWindow.setFrameOrigin(NSMakePoint(0, 0))
    }
}
