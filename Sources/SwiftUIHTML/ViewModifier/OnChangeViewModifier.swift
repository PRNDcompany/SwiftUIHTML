//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct OnChangeViewModifier<V: Equatable>: ViewModifier {
    @State private var oldValue: V?

    private let value: V
    private let initial: Bool
    private let action: (_ oldValue: V, _ newValue: V) -> Void

    init(of value: V, initial: Bool, _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void) {
        self.value = value
        self.initial = initial
        self.action = action
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: value) { newValue in
                guard let oldValue else { return }
                action(oldValue, newValue)
                self.oldValue = newValue
            }
            .onAppear {
                oldValue = value
                guard initial else { return }
                action(value, value)
            }
    }
}
