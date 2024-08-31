import RouterKit

final class DescriptorsManager {
    private let routingHub: RoutingHub

    init(routingHub: RoutingHub) {
        self.routingHub = routingHub
    }

    func setup() {
        routingHub.register(descriptor: GistRouteDescriptor())
    }
}
