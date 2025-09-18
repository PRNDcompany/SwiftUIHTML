//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI
import AVKit
import Combine

import SwiftUIHTML


struct VideoTagView: BlockTag, Equatable {
    static func == (lhs: VideoTagView, rhs: VideoTagView) -> Bool {
        lhs.element == rhs.element
    }
    
    @MainActor
    final class Context: ObservableObject {
        private var player: AVPlayer?
        private var videoURL: URL?
        @Published var ratio: CGFloat = 1
        
        private var cancellables = Set<AnyCancellable>()
        
        init() {
        }
        
        func reset() {
            cancellables = []
            videoURL = nil
            player = nil
        }
        
        func player(url: URL?) -> AVPlayer? {
            guard let url else {
                reset()
                return nil
            }
            guard videoURL != url else { return player }
            
            let _player = AVPlayer(url: url)
            cancellables = []
            videoURL = url
            player = _player
            
            observePresentationSize(player: _player)
            _player.play()
            
            return player
        }
        
        func observePresentationSize(player: AVPlayer) {
            player.publisher(for: \.currentItem?.presentationSize)
                .compactMap { $0 }
                .filter { $0 != .zero }
                .sink { [weak self] videoSize in
                    self?.ratio = videoSize.width / videoSize.height
                }
                .store(in: &cancellables)
        }
    }
    
    let element: BlockElement
    let url: URL?
    @StateObject var context = Context()
    
    init(element: BlockElement) {
        self.element = element
        self.url = element.attributes["src"]?.url
    }
    
    var body: some View {
        if let player = context.player(url: url) {
            VideoPlayer(player: player)
                .aspectRatio(context.ratio, contentMode: .fit)
        }
    }
    
}


