import Foundation

struct JSONObject {
    let colorName: String
    let hex: String
    let hex_dark_color: String?
    let hex_light_color: String?
    init?(dic: [String: Any]) {
        guard let colorName = dic["colorName"] as? String,
            let hex = dic["hex"] as? String else {
                return nil
        }
        self.colorName = colorName
        self.hex = hex
        self.hex_dark_color = dic["hex_dark_color"] as? String
        self.hex_light_color = dic["hex_light_color"] as? String
    }
}
