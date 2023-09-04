//
//  SFTextField.swift
//  SwiftFormHost
//
//  Created by ezen on 12/02/2023.
//

import UIKit
import SwiftUI

// @IBDesignable
class SFTextField: UIView {
	
	@ObservedObject var params = SFTextFieldParams()
	
	@IBInspectable var height: CGFloat = 40 {
		didSet {
			params.height = self.height
		}
	}
	
	@IBInspectable var name: String = "" {
		didSet {
			params.name = self.name
		}
	}
	
	@IBInspectable var value: String = "" {
		didSet {
			params.value = self.value
		}
	}
	
	@IBInspectable var placeholder: String = "" {
		didSet {
			params.placeholder = self.placeholder
		}
	}
	
	@IBInspectable var fieldFont: UIFont  {
		get {
			params.font
		}
		set {
			params.font = newValue
		}
	}
	
	// MARK: - Error attributes
	var error: String = ""  {
		didSet {
			params.error = self.error
		}
	}
	
	@IBInspectable var errorFont: UIFont = UIFont.systemFont(ofSize: 12)  {
		didSet {
			params.errorFont = self.errorFont
		}
	}
	
	var errorAlign: TextAlignment = .trailing  {
		didSet {
			params.errorAlignment = self.errorAlign
		}
	}
	
	@IBInspectable var showErrorLabel: Bool = true  {
		didSet {
			params.showErrorLabel = self.showErrorLabel
		}
	}
	
	@IBInspectable var showErrorBorder: Bool = true  {
		didSet {
			params.showErrorBorder = self.showErrorBorder
		}
	}
	
	var delegate: SFTextFieldDelegate? = nil
	
	// MARK: - Icons attributes
    
    /**
    Icon left color
     */
    @IBInspectable var iconLeftColor: UIColor = .label {
        didSet {
            params.iconLeftColor = self.iconLeftColor
        }
    }
    
    
    /**
    Icon right color
     */
    @IBInspectable var iconRightColor: UIColor = .label {
        didSet {
            params.iconRightColor = self.iconRightColor
        }
    }
    
    
	/**
	 Icon displayed on Left of the text field
	 */
	@IBInspectable var iconLeft: UIImage? {
		didSet {
			params.iconLeft = self.iconLeft
		}
	}
	
	/**
	 Icon displayed on Right of the text field
	 */
	@IBInspectable var iconRight: UIImage? {
		didSet {
			params.iconRight = self.iconRight
		}
	}
	
	/**
	 Icon displayed on Right of the text field when error is not empty
	 */
	@IBInspectable var errorIcon: UIImage? {
		didSet {
			params.errorIcon = self.errorIcon
		}
	}
    
    /**
     Image Template rendering mode for icon left
     */
    var iconLeftTemplateRenderingMode: Image.TemplateRenderingMode = .template {
        didSet {
            params.iconLeftRenderingMode = self.iconLeftTemplateRenderingMode
        }
    }
    
    /**
     Image Template rendering mode for icon right
     */
    var iconRightTemplateRenderingMode: Image.TemplateRenderingMode = .template {
        didSet {
            params.iconRightRenderingMode = self.iconRightTemplateRenderingMode
        }
    }
	
	/**
	 Image Template rendering mode for error icon
	 */
	var errorIconTemplateRenderingMode: Image.TemplateRenderingMode = .template {
		didSet {
			params.errorIconRenderingMode = self.errorIconTemplateRenderingMode
		}
	}
	
	/**
	 Action triggered when user tap on the left icon
	 
	 - parameter iconView: Representation of the image view containing the left icon image
	 */
	var onClickLeft: (() -> Void)? = nil {
		didSet {
			params.onClickLeft = self.onClickLeft
		}
	}
	
	/**
	 Action triggered when user tap on the right icon
	 
	 - parameter iconView: Representation of the image view containing the right icon image
	 */
	var onClickRight: (() -> Void)? = nil {
		didSet {
			params.onClickRight = self.onClickRight
		}
	}
	
	// MARK: - Constraints applied
	/**
	 Insets applied to the field insets
	 */
	var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10) {
		didSet {
			params.contentInsets = self.contentInsets
		}
	}
	
	// MARK: - Views creation
	override var backgroundColor: UIColor? {
		get {
			params.backgroundColor
		}
		set {
			params.backgroundColor = newValue ?? .clear
		}
	}
	
	@IBInspectable var textColor: UIColor = .label {
		didSet {
			params.textColor = self.textColor
		}
	}
	
	@IBInspectable var errorTextColor: UIColor = .red {
		didSet {
			params.errorTextColor = self.errorTextColor
		}
	}
	
	override var tintColor: UIColor! {
		didSet {
			params.tintColor = self.tintColor
		}
	}
	
	@IBInspectable var cornerRadius: CGFloat = 0 {
		didSet {
			params.cornerRadius = self.cornerRadius
		}
	}
	
	@IBInspectable var borderWidth: CGFloat = 0 {
		didSet {
			params.borderWidth = self.borderWidth
		}
	}
	
	@IBInspectable var borderColor: UIColor = .clear {
		didSet {
			params.borderColor = self.borderColor
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		initializeView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		initializeView()
	}
	
	private func initializeView() {
		let fieldView = SFTextFieldView(params: params)
		
		let hostingVC = UIHostingController(rootView: fieldView)
		hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
		hostingVC.view.backgroundColor = .clear
		addSubview(hostingVC.view)
		
		NSLayoutConstraint.activate([
			hostingVC.view.topAnchor.constraint(equalTo: topAnchor),
			hostingVC.view.leadingAnchor.constraint(equalTo: leadingAnchor),
			hostingVC.view.trailingAnchor.constraint(equalTo: trailingAnchor),
			hostingVC.view.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	func registerTextField(withIdentifier name: String, target: SFTextFieldDelegate) {
		self.name = name
		self.delegate = target
	}
	
//	func textChanged() {
//		if let rules = self.delegate?.fieldsRules() {
//			if let fieldRule = rules[self.name] {
//				// TODO: Apply rule
//			}
//		}
//	}
}

struct SFTextFieldView: View {
	@ObservedObject var params: SFTextFieldParams
	
	var body: some View {
		VStack(alignment: .trailing, spacing: 5) {
			HStack(alignment: .center, spacing: 10) {
				if let safeLeftIcon = params.iconLeft {
					Image(uiImage: safeLeftIcon)
						.resizable()
                        .renderingMode(params.iconLeftRenderingMode)
                        .foregroundColor(Color(params.iconLeftColor))
						.scaledToFit()
						.frame(width: 20, height: 20)
                        .onTapGesture {
                            if let handlerOnClickLeft = params.onClickLeft {
                                handlerOnClickLeft()
                            }
                        }
				}
				TextField(params.placeholder, text: $params.value)
					.font(Font(params.font))
					.accentColor(Color(params.tintColor))
					.foregroundColor(Color(params.textColor))
					.keyboardType(params.keyboardType)
					.frame(maxWidth: .infinity, alignment: .leading)
				if let safeErrorIcon = params.errorIcon, !params.error.isEmpty {
					Image(uiImage: safeErrorIcon)
						.resizable()
						.renderingMode(params.errorIconRenderingMode)
						.foregroundColor(Color(params.errorTextColor))
						.scaledToFit()
						.frame(width: 20, height: 20)
						.onTapGesture {
							if let handlerOnClickRight = params.onClickRight {
								handlerOnClickRight()
							}
						}
				} else {
					if let safeRightIcon = params.iconRight {
						Image(uiImage: safeRightIcon)
							.resizable()
							.renderingMode(params.iconRightRenderingMode)
							.foregroundColor(Color(params.iconRightColor))
							.scaledToFit()
							.frame(width: 20, height: 20)
							.onTapGesture {
								if let handlerOnClickRight = params.onClickRight {
									handlerOnClickRight()
								}
							}
					}
				}
			}
			.padding(.leading, params.contentInsets.left)
			.padding(.top, params.contentInsets.top)
			.padding(.trailing, params.contentInsets.right)
			.padding(.bottom, params.contentInsets.bottom)
			.frame(height: params.height)
			.background(Color(params.backgroundColor))
			.cornerRadius(params.cornerRadius)
			.overlay(
				params.borderWidth > 0 ?
				RoundedRectangle(cornerRadius: params.cornerRadius)
					.stroke(Color(!params.error.isEmpty && params.showErrorBorder ? params.errorTextColor : params.borderColor), lineWidth: params.borderWidth)
				:
					(
						!params.error.isEmpty && params.showErrorBorder ?
						RoundedRectangle(cornerRadius: params.cornerRadius)
							.stroke(Color(params.errorTextColor), lineWidth: 1)
						:
							nil
					)
			)
		}
		if !params.error.isEmpty && params.showErrorLabel {
			Text(params.error)
				.foregroundColor(Color(params.errorTextColor))
				.font(Font(params.errorFont))
				.frame(maxWidth: .infinity, alignment: params.errorAlignment == .leading ? .leading : (params.errorAlignment == .trailing ? .trailing : .center))
		}
	}
}

struct SFTextFieldView_Previews: PreviewProvider {
	static var previews: some View {
		SFTextFieldView(params: SFTextFieldParams())
			.previewLayout(.sizeThatFits)
	}
}
