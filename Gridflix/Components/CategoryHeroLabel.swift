//
//  CategoryHeroLabel.swift
//  Gridflix
//
//  Created by Jenny Gallegos Cardenas on 18/10/24.
//
import UIKit

final class CategoryHeroLabel: UILabel {
    init(frame: CGRect = .zero, text: String) {
        super.init(frame: frame)
        self.text = text
        configureLabel()
    }

    init(frame: CGRect = .zero, assetName: String) {
        super.init(frame: frame)
        let attributedText = makeAttributedText(from: assetName)
        self.attributedText = attributedText
        configureLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }

    func configureLabel() {
        self.font = .preferredFont(forTextStyle: .caption2)
        self.textColor = .white
        self.textAlignment = .center
        sizeToFit()
    }

    private func makeAttributedText(from assetName: String) -> NSAttributedString {
        guard let image = UIImage(named: assetName) else {
            return NSAttributedString(string: "")
        }

        let attachment = NSTextAttachment(image: image)
        let imageString = NSAttributedString(attachment: attachment)
        return imageString
    }
}
