//
//  UIButton+OutlineButton.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 05/10/24.
//

import UIKit

extension UIButton.Configuration {
    public static func outline() -> Self {
        var configuration = UIButton.Configuration.bordered()
        configuration.buttonSize = .small
        configuration.cornerStyle = .capsule
        configuration.background.strokeColor = .white
        configuration.background.strokeWidth = 2.0
        return configuration
    }
}

final class OutlineButton: UIButton {
    var shouldHighlight: Bool = false
    var wasHighlighted: Bool = false

    override func updateConfiguration() {
        guard let configuration = configuration else {
            return
        }
        
        var updatedConfiguration = configuration
        
        var background = UIButton.Configuration.plain().background
        background.cornerRadius = 20
        background.strokeWidth = 1
        
        let strokeColor: UIColor
        let foregroundColor: UIColor
        let backgroundColor: UIColor
        let baseColor = updatedConfiguration.baseForegroundColor ?? UIColor.tintColor
        if shouldHighlight && isHighlighted {
            wasHighlighted.toggle()
        }
        switch self.state {
        case .normal:
            strokeColor = .systemGray5
            foregroundColor = baseColor
            backgroundColor = wasHighlighted ? baseColor.withAlphaComponent(0.3) : .clear
        case [.highlighted]:
            strokeColor = .systemGray5
            foregroundColor = baseColor
            backgroundColor = baseColor.withAlphaComponent(0.3)
        case .selected:
            strokeColor = .clear
            foregroundColor = .white
            backgroundColor = baseColor
            
        case [.selected, .highlighted]:
            strokeColor = .clear
            foregroundColor = .white
            backgroundColor = baseColor.darker()
        case .disabled:
            strokeColor = .systemGray6
            foregroundColor = baseColor.withAlphaComponent(0.3)
            backgroundColor = .clear
        default:
            strokeColor = .systemGray5
            foregroundColor = baseColor
            backgroundColor = wasHighlighted ? baseColor.withAlphaComponent(0.3) : .clear
        }
        
        background.strokeColor = strokeColor
        // 1
        background.backgroundColorTransformer = UIConfigurationColorTransformer { color in

            return backgroundColor
        }
        
        // 2
        // updatedConfiguration.baseForegroundColor = foregroundColor
        updatedConfiguration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in

            var container = incoming
            container.foregroundColor = foregroundColor
            container.font = .system(size: 6.0, weight: .regular)
            
            return container
        }
                
        updatedConfiguration.background = background
        
        self.configuration = updatedConfiguration
    }
}

@available(iOS 17, *)
#Preview("Outline Button") {
    let vc = UIViewController()
    let view = UIView(frame: CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height - 100))
    view.backgroundColor = .black

    var config = UIButton.Configuration.outline()
    config.title = "Categories"
    config.image = UIImage(systemName: "chevron.down")
    config.imagePlacement = .trailing
    let button = OutlineButton(configuration: config)
    button.tintColor = .white

    view.addSubview(button)
    vc.view.addSubview(view)
    return vc
}
