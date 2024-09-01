import Foundation

extension String {
    var localized: String {
        if let path = Bundle.module.path(forResource: "pt-BR", ofType: "lproj"),
           let bundlePath = Bundle(path: path) {
            return bundlePath.localizedString(forKey: self, value: nil, table: nil)
        }

        return ""
    }

    func localized(with arguments: String...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
