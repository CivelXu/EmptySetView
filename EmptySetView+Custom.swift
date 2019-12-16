//
//  MiksEmptySetView.swift
//  MIKS
//
//  Created by Civel Xu on 2019/11/29.
//  Copyright © 2019 xuxiwen. All rights reserved.
//

import UIKit

extension EmptySetView {

    static func normal(
        title: String = "",
        imageName: String = "",
        verticalOffset: CGFloat = 0) -> EmptySetView {
        let titleAttr = NSAttributedString(
            string: title,
            attributes: normalAttributes
        )
        let emptyView = EmptySetView(
            title: titleAttr,
            describe: nil,
            image: UIImage(named: imageName),
            imageTintColor: nil,
            imageAnimation: nil,
            buttonTitle: nil,
            buttonImageBlock: nil,
            buttonBackgroundImageBlock: nil,
            backgroundColor: .clear,
            customEmptyView: nil,
            verticalOffset: verticalOffset,
            allowScroll: true,
            spaceHeight: 11,
            shouldFade: true,
            shouldBeForcedToDisplay: false,
            shouldDisplay: true,
            shouldAllowTouch: true,
            shouldAnimateImageView: false
        )
        return emptyView
    }

    static let normalAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
        NSAttributedString.Key.foregroundColor: AppColor.B3B3B3
    ]

    func setNormalTitle(_ title: String) {
        self.title = NSAttributedString(string: title, attributes: Self.normalAttributes)
    }

    func setNormalImage(_ imageName: String) {
        self.image = UIImage(named: imageName)
    }

    func setNormalButtonImage(_ image: UIImage?) {
        if image == nil {
             self.buttonImageBlock = nil
        } else {
            self.buttonImageBlock = { _ in
                return image
            }
        }
    }

    func configureWithError(_ error: Error) {
        var title = "访问失败, 点击重试"
        let image = "kongbai"
        if error.isNetworkTimeOut {
            title = "网络不给力, 点击重试"
        } else if error.isNetworkUnavailable {
            title = "网络已断开, 请检查网络后重试"
        } else if error.isRequestFailed {
            title = "访问失败, 点击重试"
        } else {
            if !error.localizedDescription.isEmpty {
                title = error.localizedDescription
            }
        }
        setNormalTitle(title)
        setNormalImage(image)
    }

}
