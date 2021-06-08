import SwiftUI

/// Hosizontal CarouslView for any SwiftUI View. The Content will be called for each iteration in the array.
struct CarouselView<Item: Identifiable, Content: View>: View {
    private var items: [Item]
    private var content: (_ item: Item) -> Content
    private var onChange: ((_ selectedIndex: Int) -> Void)?
    private var scrollToBeginningAtEnd: Bool = true
    private var animation: Animation
    @Binding private var selectedIndex: Int
    @State private var newPosition: CGFloat = 0
    @State private var selectedPosition: CGFloat = 0

    private let dragThreshold: CGFloat = 100

    init(
        items: [Item],
        selectedIndex: Binding<Int>,
        onChange: ((_ selectedIndex: Int) -> Void)? = nil,
        scrollToBeginningAtEnd: Bool = true,
        animation: Animation = .spring(response: 0.4),
        @ViewBuilder content: @escaping (_ item: Item) -> Content
    ) {
        self.items = items

        self.content = content
        self.onChange = onChange
        _selectedIndex = selectedIndex
        self.scrollToBeginningAtEnd = scrollToBeginningAtEnd
        self.animation = animation
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    ForEach(items, id: \.id) { item in
                        self.content(item)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .contentShape(Rectangle())
                            .clipped()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: self.newPosition, y: 0)
                .animation(animation)
            }
            .simultaneousGesture(DragGesture()
                .onChanged { value in
                    // Give a new offset during dragging
                    self.newPosition = (value.translation.width * 1) + selectedPosition
                }
                .onEnded { value in
                    let delta = value.location.x - value.startLocation.x
                    let imageLength = geometry.size.width
                    let itemPositions = [Int](0 ... items.count - 1).map { -(CGFloat($0) * imageLength) }

                    var newIndex: Int = selectedIndex

                    // Check if the user drags the item enough to change index
                    if delta <= 0 - dragThreshold {
                        // next index
                        newIndex = selectedIndex + 1
                    } else if delta > 0 - dragThreshold, delta < dragThreshold {
                        // stay on same index
                        self.newPosition = selectedPosition
                        return
                    } else {
                        // previous index
                        newIndex = selectedIndex - 1
                    }

                    if newIndex < 0 {
                        newIndex = 0
                    }

                    if newIndex == itemPositions.count {
                        if scrollToBeginningAtEnd {
                            newIndex = 0
                        } else {
                            newIndex = itemPositions.count - 1
                        }
                    }

                    newPosition = itemPositions[newIndex]
                    selectedPosition = newPosition
                    selectedIndex = newIndex

                    onChange?(selectedIndex)
                })
        }
        .contentShape(Rectangle())
        .clipped()
    }
}

struct CarouselView_Previews: PreviewProvider {
    struct Item: Identifiable {
        let id = UUID()
        let color: Color
    }

    static var previews: some View {
        CarouselPreview()
    }

    struct CarouselPreview: View {
        @State var selectedIndex = 3
        let items = [
            Item(color: .red),
            Item(color: .green),
            Item(color: .yellow),
            Item(color: .blue),
        ]
        var body: some View {
            CarouselView(
                items: items,
                selectedIndex: $selectedIndex,
                scrollToBeginningAtEnd: true
            ) { item in
                item.color

            }.frame(width: 200, height: 100)
        }
    }
}
