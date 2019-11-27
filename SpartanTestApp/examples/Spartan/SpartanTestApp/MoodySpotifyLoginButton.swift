//
//  MoodySpotifyLoginButton.swift
//  SpartanTestApp
//
//  Based off of SpotifyLoginButton from SpotifyLogin
//
//  Created by Omari Matthews on 11/18/19.
//  Copyright © 2019 Spotify. All rights reserved.
//

import UIKit
import SpotifyLogin

public class MoodySpotifyLoginButton: UIButton {
    

    private weak var viewController: UIViewController?
    private var scopes: [Scope]?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        applyLayout()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyLayout()
    }

    public convenience init(viewController: UIViewController, scopes: [Scope]) {
        self.init(frame: .zero)
        self.viewController = viewController
        self.scopes = scopes
        self.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
    }

    func applyLayout() {
        backgroundColor = moody_purple()
        setTitleColor(.white, for: .normal)
        tintColor = .white
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 0.0)
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 8.0)
        adjustsImageWhenHighlighted = false
        setImage(UIImage(named: "spotifylogo-32.png",
                              in: Bundle(for: SpotifyLoginButton.self),
                              compatibleWith: nil)!
            .withRenderingMode(.alwaysTemplate), for: .normal)
        setTitle("SIGN IN WITH SPOTIFY", for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        frame.size = intrinsicContentSize
    }

    @IBAction private func performLogin() {
        guard let viewContoller = viewController, let scopes = scopes else { return }
        SpotifyLoginPresenter.login(from: viewContoller, scopes: scopes)
    }

    override public var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? moody_darkPurple() : moody_purple()
        }
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 260.0, height: 55.0)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height/2
    }
    
    func moody_purple() -> UIColor {
        return UIColor(red: 108.0/255.0, green: 86.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    }
    
    func moody_darkPurple() -> UIColor {
        return UIColor(red: 76.0/255.0, green: 61.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    }
    
}
