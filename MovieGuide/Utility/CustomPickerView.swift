//
//  CustomPickerView.swift
//  MovieGuide
//
//  Created by Saket Gupte on 07/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import UIKit

protocol CustomPickerDelegate: class {
  func selectedValueInPicker(picker: CustomPicker, index: Int, value: String)
  func canceledSelection(picker: CustomPicker)
}

class CustomPicker: NSObject {
  
  let title: String
  var items: [String]
  var pickerBackgroundColor: UIColor = UIColor.white
  var barButtonColor: UIColor = UIColor.blue

  weak var delegate: CustomPickerDelegate?
  
  fileprivate lazy var overlayView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = true
    view.backgroundColor = UIColor(white: 0, alpha: 0.25)
    return view
  }()
  
  fileprivate lazy var toolbar: UIToolbar = {
    let toolbar = UIToolbar()
    toolbar.delegate = self
    toolbar.autoresizingMask = .flexibleWidth;
    return toolbar
  }()
  
  fileprivate lazy var pickerContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = self.pickerBackgroundColor
    return view
  }()
  
  fileprivate lazy var picker: UIPickerView = {
    let picker = UIPickerView()
    picker.delegate = self
    picker.dataSource = self
    return picker
  }()
  
  fileprivate lazy var backgroundTapGesture: UITapGestureRecognizer = {
    let gestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
    return gestureRecongnizer
  }()
  
  fileprivate lazy var cancelButton: UIBarButtonItem = {

    let cancelButton = UIBarButtonItem(title: "Cancel",
                                       style: .plain,
                                       target: self,
                                       action: #selector(cancelButtonTapped))

    cancelButton.tintColor = self.barButtonColor
    return cancelButton
  }()
  
  @objc fileprivate func cancelButtonTapped() {
    self.delegate?.canceledSelection(picker: self)
    self.dismissPickerView()
  }
  
  lazy var selectButton: UIBarButtonItem = {

    let selectButton = UIBarButtonItem(title: "Select",
                                       style: .plain,
                                       target: self,
                                       action: #selector(selectButtonTapped))

    selectButton.tintColor = self.barButtonColor
    return selectButton
  }()
  
  @objc fileprivate func selectButtonTapped() {
    let selectedIndex = self.picker.selectedRow(inComponent: 0)
    let selectedValue = self.items[selectedIndex]
    
    self.delegate?.selectedValueInPicker(picker: self, index: selectedIndex, value: selectedValue)
    self.dismissPickerView()
  }

  fileprivate lazy var titleLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.text = self.title
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.sizeToFit()
    return label
  }()
  
  init(title: String, items:[String]) {
    self.title = title
    self.items = items
  }

  convenience init(title: String) {
    self.init(title: title, items:[])
  }

  func presentPickerOnView(view: UIView) ->  Void {
    let viewFrame: CGRect? = view.window?.frame

    view.endEditing(true)

    configureOverlayView(frame:viewFrame)
    view.window?.addSubview(overlayView)

    let pickerContainerSourceFrame: CGRect = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 260.0)

    let pickerContainerDestinationFrame: CGRect = CGRect(x: 0, y: view.frame.height - 260.0, width: view.frame.width, height: 260.0)

    pickerContainerView.frame = pickerContainerSourceFrame
    view.window?.addSubview(pickerContainerView)

    toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44.0)
    configureToolbar()
    pickerContainerView.addSubview(toolbar)

    picker.frame = CGRect(x: 0, y: 44.0, width: view.frame.width, height: 260.0)
    pickerContainerView.addSubview(picker)

    showOverlay()
    showPickerView(destinationFrame: pickerContainerDestinationFrame)
  }

  func selectedItem(item: String?) {

    guard let item = item else {
      return
    }

    let selectedIndex = self.items.index(of: item) ?? 0
    self.picker.selectRow(selectedIndex, inComponent: 0, animated: true)
  }

  fileprivate func configureOverlayView(frame: CGRect?) {
    
    guard let frame = frame else {
      return
    }
    
    overlayView.alpha = 0
    overlayView.frame = frame
    overlayView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
    overlayView.addGestureRecognizer(backgroundTapGesture)
  }

  fileprivate func configureToolbar() {
    
    let fixedSpaceItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
    fixedSpaceItem.width = 15.0
    
    let flexibleSpaceItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    let titleContainer: UIBarButtonItem = UIBarButtonItem(customView: titleLabel)
    
    let toolBarItems: [UIBarButtonItem] = [fixedSpaceItem, cancelButton, flexibleSpaceItem, titleContainer, flexibleSpaceItem, selectButton, fixedSpaceItem]
    
    toolbar.setItems(toolBarItems, animated: true)
  }
  
  fileprivate func showOverlay() {
    UIView.animate(withDuration: 0.3, animations: {
      self.overlayView.alpha = 1.0
    })
  }
  
  fileprivate func showPickerView(destinationFrame: CGRect) {
    UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
      self.pickerContainerView.frame = destinationFrame
    })
  }
  
  fileprivate func dismissPickerView() {
    let pickerContainerViewDestinationFrame = CGRect(x: 0.0,
                                                     y: pickerContainerView.frame.origin.y + 260.0,
                                                     width: pickerContainerView.frame.size.width,
                                                     height: 260.0)
    
    hideOverlay()
    hidePickerView(destinationFrame: pickerContainerViewDestinationFrame)
  }
  
  fileprivate func hideOverlay() {
    UIView.animate(withDuration: 0.3, animations: {
      self.overlayView.alpha = 0
    }) { (finished) in
      self.overlayView.removeFromSuperview()
      self.overlayView.removeGestureRecognizer((self.overlayView.gestureRecognizers?.first)!)
    }
  }
  
  fileprivate func hidePickerView(destinationFrame: CGRect) {
    UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
      self.pickerContainerView.frame = destinationFrame
    }) { (finishsed) in
      self.pickerContainerView.removeFromSuperview()
    }
  }
}



extension CustomPicker: UIToolbarDelegate {
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return UIBarPosition.any
  }
  
}

extension CustomPicker: UIPickerViewDelegate, UIPickerViewDataSource {
 
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return items.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return items[row]
  }
  
}
