import Foundation

enum AppearanceTyoe: String {
    case any
    case light
    case dark
}

struct ColorElement {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
    let appearanceTyoe: AppearanceTyoe
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat, appearanceTyoe: AppearanceTyoe) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        self.appearanceTyoe = appearanceTyoe
    }
    
    private var redStr: String {
        return String(format: "%.3f", red)
    }
    
    private var greenStr: String {
        return String(format: "%.3f", green)
    }
    
    private var blueStr: String {
        return String(format: "%.3f", blue)
    }
    
    private var alphaStr: String {
        return String(format: "%.3f", alpha)
    }
    
    var element: String {
        switch appearanceTyoe {
        case .any:
            return """
                       {
                         "appearances" : [
                           {
                             "appearance" : "luminosity",
                             "value" : "\(appearanceTyoe.rawValue)"
                           }
                         ],
                         "color" : {
                           "color-space" : "srgb",
                           "components" : {
                             "alpha" : "\(alphaStr)",
                             "blue" : "\(blueStr)",
                             "green" : "\(greenStr)",
                             "red" : "\(redStr)"
                           }
                         },
                         "idiom" : "universal"
                       }
                       """
        case .dark, .light:
            return """
                    {
                      "color" : {
                        "color-space" : "srgb",
                        "components" : {
                          "alpha" : "\(alphaStr)",
                          "blue" : "\(blueStr)",
                          "green" : "\(greenStr)",
                          "red" : "\(redStr)"
                        }
                      },
                      "idiom" : "universal"
                    }
            """
        }
    }
}
