import Foundation

private extension Int64 {
    func duplicate4bits() -> Int64 {
        return (self << 4) + self
    }
}

final class ColorConverter {
    private var hexString: String
    private var alpha: Float
    init(hexString: String, alpha: Float? = nil) {
        self.hexString = hexString
        self.alpha = alpha ?? 1.0
    }
    
    func convert() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var hex = hexString
        if hex.hasPrefix("#") {
            hex = String(hex[hex.index(after: hex.startIndex)...])
        }
        
        guard let hexVal = Int64(hex, radix: 16) else {
            return nil
        }
        
        switch hex.count {
        case 3:
            let _red = CGFloat( ((hexVal & 0xF00) >> 8).duplicate4bits() ) / 255.0
            let _green = CGFloat( ((hexVal & 0x0F0) >> 4).duplicate4bits() ) / 255.0
            let _blue = CGFloat( ((hexVal & 0x00F) >> 0).duplicate4bits() ) / 255.0
            let _alpha = CGFloat(alpha)
            return (red: _red, green: _green, blue: _blue, alpha: _alpha)
        case 4:
            let _red = CGFloat( ((hexVal & 0xF000) >> 12).duplicate4bits() ) / 255.0
            let _green = CGFloat( ((hexVal & 0x0F00) >> 8).duplicate4bits() ) / 255.0
            let _blue = CGFloat( ((hexVal & 0x00F0) >> 4).duplicate4bits() ) / 255.0
            let _alpha = CGFloat( ((hexVal & 0x000F) >> 0).duplicate4bits() ) / 255.0
            return (red: _red, green: _green, blue: _blue, alpha: _alpha)
        case 6:
            let _red = CGFloat( (hexVal & 0xFF0000) >> 16 ) / 255.0
            let _green = CGFloat( (hexVal & 0x00FF00) >> 8 ) / 255.0
            let _blue = CGFloat( (hexVal & 0x0000FF) >> 0 ) / 255.0
            let _alpha = CGFloat(alpha)
            return (red: _red, green: _green, blue: _blue, alpha: _alpha)
        case 8:
            let _red = CGFloat( (hexVal & 0xFF000000) >> 24 ) / 255.0
            let _green = CGFloat( (hexVal & 0x00FF0000) >> 16 ) / 255.0
            let _blue = CGFloat( (hexVal & 0x0000FF00) >> 8 ) / 255.0
            let _alpha = CGFloat( (hexVal & 0x000000FF) >> 0 ) / 255.0
            return (red: _red, green: _green, blue: _blue, alpha: _alpha)
        default:
            return nil
        }
    }
}
