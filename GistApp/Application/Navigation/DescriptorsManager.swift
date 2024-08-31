import RouterKit

final class DescriptorsManager {
    private let routingHub: RoutingHub

    init(routingHub: RoutingHub) {
        self.routingHub = routingHub
    }

    func setup() {
        routingHub.register(descriptor: GistRouteDescriptor())
        routingHub.register(descriptor: GistDetailRouteDescriptor())
        routingHub.register(descriptor: FavoritesRouteDescriptor())
    }
}
