//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


struct ImageTag: InlineAttachmentTag {

    var attributes: [String : AttributeValue]
    init(attributes: [String : AttributeValue]) {
        self.attributes = attributes
    }
    var body: some View {
        AsyncImage(url: attributes["src"]?.url) { phase in
            switch phase {
            case .success(let image):
                ImageContainer(
                    image: image,
                    size: ElementSize(attributes: attributes)
                )
            default:
                Color.clear
                    .frame(width: 1, height: 1)
            }
        }
    }
}

private struct ImageContainer: View {
    let image: Image
    let size: ElementSize
    init(image: Image, size: ElementSize) {
        let needResizable = size.width != nil || size.height != nil
        self.image = needResizable ? image.resizable() : image
        self.size = size
    }
    var body: some View {
        image
            .modifier(SizeModifier(size: size))
    }
}



struct SizeModifier: ViewModifier, Equatable {
    let size: ElementSize
    func body(content: Content) -> some View {
        if let width = size.width, let height = size.height {
            content
                .frame(width: width, height: height)
        } else if let width = size.width {
            content
                .aspectRatio(contentMode: .fit)
                .frame(width: width)
        } else if let height = size.height {
            content
                .aspectRatio(contentMode: .fit)
                .frame(height: height)
        } else {
            content
        }
    }
}
