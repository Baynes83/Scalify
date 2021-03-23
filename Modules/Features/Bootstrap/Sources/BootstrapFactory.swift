import SwiftUI

public struct BootstrapFactory {

    public static func create(router: BootstrapRouter) -> some View {
        return BootstrapView(viewModel: BootstrapViewModel(router: router))
    }

}
