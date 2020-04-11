import SwiftUI

public struct iPhoneBezel<Content: View>: View {

    @ObservedObject var deviceOrientationObserver = DeviceOrientationObserver()

    let content: () -> Content

    private let topBezelHeight: CGFloat = 90

    private let bottomBezelHeight: CGFloat = 100

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        Group {
            if deviceOrientationObserver.orientation == UIDeviceOrientation.portrait {
                VStack(spacing: 0) {
                    topBezel()
                        .frame(height: topBezelHeight)
                    content()
                        .frame(maxHeight: .infinity)
                    bottomBezel()
                        .frame(height: bottomBezelHeight)
                }
            } else if deviceOrientationObserver.orientation == UIDeviceOrientation.portraitUpsideDown {
                VStack(spacing: 0) {
                    bottomBezel()
                        .frame(height: bottomBezelHeight)
                    content()
                        .frame(maxHeight: .infinity)
                    topBezel()
                        .frame(height: topBezelHeight)
                }
            } else if deviceOrientationObserver.orientation == UIDeviceOrientation.landscapeLeft {
                HStack(spacing: 0) {
                    topBezel()
                        .frame(width: topBezelHeight)
                    content()
                        .frame(maxWidth: .infinity)
                    bottomBezel()
                        .frame(width: bottomBezelHeight)
                }
            } else if deviceOrientationObserver.orientation == UIDeviceOrientation.landscapeRight {
                HStack(spacing: 0) {
                    bottomBezel()
                        .frame(width: bottomBezelHeight)
                    content()
                        .frame(maxWidth: .infinity)
                    topBezel()
                        .frame(width: topBezelHeight)
                }
            }
        }
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
    }

    private func topBezel() -> some View {
        Color.black
    }

    private func bottomBezel() -> some View {
        Color.black
        //.frame(height: 90)
            .overlay(
            Button(action: {
                self.hapticFeedback()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.backToHome()
                }
            }) {
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 3)
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
            }
        )
    }

    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }

    private func backToHome() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }

}

class DeviceOrientationObserver: ObservableObject {

    @Published var orientation: UIDeviceOrientation

    init() {
        orientation = UIDevice.current.orientation
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func rotated() {
        let newOrientation = UIDevice.current.orientation
        if newOrientation.rawValue < 1 || 4 < newOrientation.rawValue || newOrientation == UIDeviceOrientation.portraitUpsideDown {
            return
        }
        orientation = newOrientation
    }

}
