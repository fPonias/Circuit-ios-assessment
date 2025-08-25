import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewVM()
    
    var rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ViewBuilder
    private func gridView(shapes: [ShapeData]) -> some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = 80
            let colCount = max(1, Int(geometry.size.width / itemWidth))
            let columns = Array(repeating: GridItem(.flexible()), count: colCount)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(shapes) { shape in
                        ShapeButton(shape: shape, onTap: {
                            viewModel.onShapeClicked(shape: shape)
                        })
                    }
                }
                .frame(
                    width: geometry.size.width,
                    alignment: .topLeading
                )
            }
            .frame(
                width: geometry.size.width,
                height: geometry.size.height
            )
        }
    }
    
    @ViewBuilder
    private func topButtons() -> some View {
        HStack() {
            Button("Clear All") {
                viewModel.deleteAll()
            }
            Spacer()
            
            let circleValue = viewModel.types["Circle"]
            if (circleValue != nil) {
                NavigationLink("Edit Circles", value: circleValue)
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.onShapeFilterClicked(shape: circleValue!)
                    })
            }
        }
    }
    
    @ViewBuilder
    private func bottomButtons() -> some View {
        HStack() {
            let keys = viewModel.types.keys.sorted()
            ForEach(Array(keys.enumerated()), id: \.element) { index, key in
                if let value = viewModel.types[key] {
                    NavigationLink(value.name, value: value)
                        .simultaneousGesture(TapGesture().onEnded {
                            viewModel.onShapeFilterClicked(shape: value)
                        })
                    
                    if (index < keys.count - 1) {
                        Spacer()
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func filteredBottomButtons() -> some View {
        HStack() {
            Button("Delete All") {
                viewModel.deleteAllFiltered()
            }
            Spacer()
            Button("Add") {
                viewModel.addSingleFiltered()
            }
            Spacer()
            Button("Remove") {
                viewModel.deleteSingleFiltered()
            }
        }
    }
        
    var body: some View {
        NavigationStack {
            VStack {
                topButtons()
                gridView(shapes: viewModel.shapes)
                bottomButtons()
            }
            .navigationDestination(for: ShapeData.self) { shape in
                VStack {
                    gridView(shapes: viewModel.filteredShapes)
                    filteredBottomButtons()
                }
            }
        }
        .padding(20)
    }
}

#Preview {
    MainView()
}
