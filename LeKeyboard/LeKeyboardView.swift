//
//  LeKeyboardView.swift
//  LeKeyboard
//
//  Created by Quoc Nguyen on 2018/05/30.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import UIKit
import LazySwifter
import SnapKit

class LeKeyboardView: UIView {

    let numRow = 4
    let numColumn = 6
    let space: CGFloat = 6.0
    let lineSpace: CGFloat = 10.0

    let consonant = [
        "p", "b", "t", "d", "k", "ɡ",
        "m", "n", "ŋ", "f", "v", "θ",
        "ð", "s", "z", "ʃ", "ʒ", "h",
        "tʃ", "dʒ", "j", "w", "ɹ", "l",
    ]

    let vowel = [
        "i", "ɪ", "e", "ɛ", "æ", "u",
        "ʊ", "o", "ɔ", "ɑ", "ə", "ʌ",
        "ɚ", "ɝ", "ɪr", "ɛr", "ʊr", "ɔr",
        "ɑr", "aɪ", "aʊ", "ɔɪ", "eɪ", "oʊ",
    ]

    let texts = [
        "p", "b", "t", "d", "k", "ɡ",
        "m", "n", "ŋ", "f", "v", "θ",
        "ð", "s", "z", "ʃ", "ʒ", "h",
        "tʃ", "dʒ", "j", "w", "ɹ", "l",
        ]
    let displayTexts = [
        "p", "b", "t", "d", "k", "ɡ",
        "m", "n", "ŋ", "f", "v", "θ",
        "ð", "s", "z", "ʃ", "ʒ", "h",
        "tʃ", "dʒ", "j", "w", "ɹ", "l",
        ]

    @IBOutlet weak var nextKeyboardButton: ShapeButton!
    @IBOutlet weak var deleteButton: ShapeButton!

    var didTapButton: StringClosure?
    var didTapDelete: VoidClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = UIColor.clear
        let specialButtonColor = UIColor(r: 173, g: 180, b: 189)
        self.addContentViewFromXib()
        self.deleteButton.defaultBackgroundColor = specialButtonColor
        self.nextKeyboardButton.defaultBackgroundColor = specialButtonColor
        setupButtons()
    }

    private func setupButtons() {
        var indexColumnButton: ShapeButton?
        var indexRowButton: ShapeButton?
        let widthOffset = space * CGFloat(numColumn + 1) / CGFloat(numColumn)
        let heightOffset = (lineSpace * CGFloat(numRow + 1) + 50) / CGFloat(numRow)
        for i in 0..<numRow {
            for j in 0..<numColumn {
                let button = ShapeButton(type: .system)
                button.tag = (i * numColumn + j)
                button.setTitle(texts[button.tag], for: .normal)
                button.addTarget(self, action: #selector(didSelectTextButton(btn:)), for: .touchDown)
                self.addSubview(button)
                button.snp.makeConstraints { (maker) in
                    maker.width.equalTo(self.snp.width).dividedBy(numColumn).offset(-widthOffset)
                    maker.height.equalTo(self).dividedBy(numRow).offset(-heightOffset)
                    if let lastButton = indexColumnButton {
                        maker.leading.equalTo(lastButton.snp.trailing).offset(space)
                        maker.top.equalTo(lastButton.snp.top)
                    } else {
                        if let lastRow = indexRowButton {
                            maker.top.equalTo(lastRow.snp.bottom).offset(lineSpace)
                        } else {
                            maker.top.equalTo(self).offset(lineSpace)
                        }
                        maker.leading.equalTo(self).offset(space)
                    }
                }
                indexColumnButton = button
                if j == 0 {
                    indexRowButton = button
                }
            }
            indexColumnButton = nil
        }
    }

    @IBAction private func didSelectTextButton(btn: UIButton) {
        let text = displayTexts[btn.tag]
        didTapButton?(text)
    }
    @IBAction private func didSelectSpaceButton(_ sender: Any) {
        didTapButton?(" ")
    }

    @IBAction private func didTapDeleteButton(_ sender: Any) {
        didTapDelete?()
    }
}
