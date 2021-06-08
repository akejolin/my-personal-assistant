import SwiftUI

/// Flips two views from frontside to backside.
struct FlipView<Front: View, Back: View>: View {
    private let front: () -> Front

    private let back: () -> Back

    @Binding private var isFlipped: Bool

    @State private var angleTranslation: Double = 0.0

    init(
        @ViewBuilder front: @escaping () -> Front,
        @ViewBuilder back: @escaping () -> Back,
        isFlipped: Binding<Bool>
    ) {
        self.front = front
        self.back = back
        _isFlipped = isFlipped
    }

    var body: some View {
        ZStack(alignment: .center) {
            front()
                .opacity(self.isShowingFront ? 1.0 : 0.0)
            back()
                .scaleEffect(CGSize(width: -1.0, height: 1.0))
                .opacity(self.isShowingFront ? 0.0 : 1.0)
        }
        .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity, alignment: .center)
        .rotation3DEffect(.degrees(self.totalAngle), axis: (0.0, 1.0, 0.0), perspective: 0.5)
        .contentShape(Rectangle())
    }

    private var baseAngle: Double {
        isFlipped ? 180 : 0
    }

    private var totalAngle: Double {
        baseAngle + angleTranslation
    }

    private var clampedAngle: Double {
        var clampedAngle = angleTranslation + baseAngle
        while clampedAngle < 360.0 {
            clampedAngle += 360.0
        }
        return clampedAngle.truncatingRemainder(dividingBy: 360.0)
    }

    private var isShowingFront: Bool {
        return clampedAngle < 90.0 || clampedAngle > 270.0
    }
}

struct FlipView_Previews: PreviewProvider {
    struct FlipViewPreview: View {
        @State private var isFlipped: Bool = false

        var body: some View {
            FlipView(
                front: {
                    VStack {
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.6)) {
                                isFlipped.toggle()
                            }
                        }) { Text("Front") }
                    }
                    .background(Color.red)
                },

                back: {
                    VStack {
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.6)) {
                                isFlipped.toggle()
                            }

                        }) { Text("Back") }
                    }
                    .background(Color.green)
                },
                isFlipped: $isFlipped
            )
            .background(Color.yellow)
        }
    }

    static var previews: some View {
        FlipViewPreview()
    }
}
