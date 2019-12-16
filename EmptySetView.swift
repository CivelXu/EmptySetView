//
//  EmptySetView.swift
//
//  Created by Civel Xu on 2019/11/29.
//  Copyright © 2019 xuxiwen. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

fileprivate var EmptySetViewAssociatedKey: Void?

public extension UIScrollView {

    var emptySetView: EmptySetView? {
        get { return objc_getAssociatedObject(self, &EmptySetViewAssociatedKey) as? EmptySetView }
        set {
            self.emptyDataSetSource = newValue
            self.emptyDataSetDelegate = newValue
            objc_setAssociatedObject(self, &EmptySetViewAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

}

public typealias TapViewBlock = ((UIView) -> Void)
public typealias ButtonTapBlock = ((UIButton) -> Void)
public typealias EmptyNormalBlock = (() -> Void)

public class EmptySetView: NSObject {

    /// DZNviewDidAppearBlockSource Configure
    public var title: NSAttributedString?
    public var describe: NSAttributedString?
    public var image: UIImage?
    public var imageTintColor: UIColor?
    public var imageAnimation: CAAnimation?
    public var buttonTitle: NSAttributedString?
    public var buttonImageBlock: ((UIControl.State) -> UIImage?)?
    public var buttonBackgroundImageBlock: ((UIControl.State) -> UIImage?)?
    public var backgroundColor: UIColor
    public var customEmptyView: UIView?
    public var verticalOffset: CGFloat
    public var spaceHeight: CGFloat

    /// DZNviewDidAppearBlockDelegate Configure
    public var shouldFade: Bool
    public var shouldBeForcedToDisplay: Bool
    public var allowScroll: Bool
    public var shouldDisplay: Bool
    public var shouldAllowTouch: Bool
    public var shouldAnimateImageView: Bool

    /// Action
    public var tapViewBlock: TapViewBlock?
    public var buttonTapBlock: ButtonTapBlock?
    public var viewWillAppearBlock: EmptyNormalBlock?
    public var viewDidAppearBlock: EmptyNormalBlock?
    public var viewWillDisappearBlock: EmptyNormalBlock?
    public var viewDidDisappearBlock: EmptyNormalBlock?

    public init(
        title: NSAttributedString? = nil,
        describe: NSAttributedString? = nil,
        image: UIImage? = nil,
        imageTintColor: UIColor? = nil,
        imageAnimation: CAAnimation? = nil,
        buttonTitle: NSAttributedString? = nil,
        buttonImageBlock: ((UIControl.State) -> UIImage?)? = nil,
        buttonBackgroundImageBlock: ((UIControl.State) -> UIImage?)? = nil,
        backgroundColor: UIColor = .clear,
        customEmptyView: UIView? = nil,
        verticalOffset: CGFloat = 0,
        allowScroll: Bool = true,
        spaceHeight: CGFloat = 11,
        shouldFade: Bool = true,
        shouldBeForcedToDisplay: Bool = false,
        shouldDisplay: Bool = true,
        shouldAllowTouch: Bool = true,
        shouldAnimateImageView: Bool = false
    ) {
        self.title = title
        self.describe = describe
        self.image = image
        self.imageTintColor = imageTintColor
        self.imageAnimation = imageAnimation
        self.buttonTitle = buttonTitle
        self.buttonImageBlock = buttonImageBlock
        self.buttonBackgroundImageBlock = buttonBackgroundImageBlock
        self.backgroundColor = backgroundColor
        self.customEmptyView = customEmptyView
        self.verticalOffset = verticalOffset
        self.allowScroll = allowScroll
        self.spaceHeight = spaceHeight
        self.shouldFade = shouldFade
        self.shouldBeForcedToDisplay = shouldBeForcedToDisplay
        self.shouldDisplay = shouldDisplay
        self.shouldAllowTouch = shouldAllowTouch
        self.shouldAnimateImageView = shouldAnimateImageView
    }

}

extension EmptySetView: DZNEmptyDataSetSource {

    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return title
    }

    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return describe
    }

    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return image
    }

    public func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return imageTintColor
    }

    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        return imageAnimation
    }

    public func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        return buttonTitle
    }

    public func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        guard let blcok = buttonImageBlock else { return nil }
        guard let image = blcok(state) else { return nil }
        return image
    }

    public func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        guard let blcok = buttonBackgroundImageBlock else { return nil }
        guard let image = blcok(state) else { return nil }
        return image
    }

    public func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return backgroundColor
    }

    public func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        return customEmptyView
    }

    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }

    public func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return spaceHeight
    }

}

extension EmptySetView: DZNEmptyDataSetDelegate {

    public func emptyDataSetShouldFade(in scrollView: UIScrollView!) -> Bool {
        return shouldFade
    }

    public func emptyDataSetShouldBeForced(toDisplay scrollView: UIScrollView!) -> Bool {
        return shouldBeForcedToDisplay
    }

    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return shouldDisplay
    }

    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return shouldAllowTouch
    }

    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return allowScroll
    }

    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return shouldAnimateImageView
    }

    public func emptyDataSet(_ scrollView: UIScrollView, didTap view: UIView) {
        if let block = tapViewBlock { block(view) }
    }

    public func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
        if let block = buttonTapBlock { block(button) }
    }

    public func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        if let block = viewWillAppearBlock { block() }
    }

    public func emptyDataSetDidAppear(_ scrollView: UIScrollView!) {
        if let block = viewDidAppearBlock { block() }
    }

    public func emptyDataSetWillDisappear(_ scrollView: UIScrollView!) {
        if let block = viewWillDisappearBlock { block() }
    }

    public func emptyDataSetDidDisappear(_ scrollView: UIScrollView!) {
        if let block = viewDidDisappearBlock { block() }
    }

}
