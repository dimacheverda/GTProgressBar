//
//  GTProgressBar.swift
//  Pods
//
//  Created by Grzegorz Tatarzyn on 19/09/2016.

import UIKit

@IBDesignable
public class GTProgressBar: UIView {
    private let backgroundView = UIView()
    private let fillView = UIView()
    private let progressLabel = UILabel()
    private let font = UIFont.systemFont(ofSize: 12)
    private var _progress: CGFloat = 1
    
    @IBInspectable
    public var barBorderColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBackgroundColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barBorderWidth: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var barFillInset: CGFloat = 2 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var progress: CGFloat {
        get {
            return self._progress
        }
        
        set {
            self._progress = min(max(newValue,0), 1)
            
            self.setNeedsLayout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareSubviews()
    }
    
    private func prepareSubviews() {
        addSubview(progressLabel)
        addSubview(backgroundView)
        addSubview(fillView)
    }
    
    public override func layoutSubviews() {
        setupProgressLabel()
        setupBackgroundView()
        setupFillView()
    }
    
    private func setupProgressLabel() {
        progressLabel.text = "\(Int(_progress * 100))%"
        progressLabel.frame = CGRect(origin: CGPoint.zero, size: sizeForLabel())
    }
    
    private func setupBackgroundView() {
        backgroundView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        backgroundView.backgroundColor = barBackgroundColor
        backgroundView.layer.borderWidth = barBorderWidth
        backgroundView.layer.borderColor = barBorderColor.cgColor
        backgroundView.layer.cornerRadius = cornerRadiusFor(view: backgroundView)
    }
    
    private func setupFillView() {
        let offset = barBorderWidth + barFillInset
        let fillFrame = backgroundView.frame.insetBy(dx: offset, dy: offset)
        let fillFrameAdjustedSize = CGSize(width: fillFrame.width * _progress, height: fillFrame.height)
        
        fillView.frame = CGRect(origin: fillFrame.origin, size: fillFrameAdjustedSize)
        fillView.backgroundColor = barFillColor
        fillView.layer.cornerRadius = cornerRadiusFor(view: fillView)
    }
    
    private func cornerRadiusFor(view: UIView) -> CGFloat {
        return view.frame.height / 2 * 0.7
    }
    
    private func sizeForLabel() -> CGSize {
        let text: NSString = "100%"
        let textSize = text.size(attributes: [NSFontAttributeName : font])
        
        
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }
}
