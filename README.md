# FTColorPickerRecognizer

## Goal

The goal here is to create a ColorPicker (as an UIView) just like in Snapchat application. Here is an example of what it looks like.



## Installation

Just import the ```FTColorPickerRecognizer.swift``` file in your project and you are done. Maybe this should become a POD (?)

## Usage

I've provide a project sample to show how to use the component. It creates a view that size the given view in parameter. So then you have to add this view to your ```UIViewController.view```. Basically what you have to do is this in a ```UIViewController```:

```swift
let colorPicker = FTColorPickerRecognizer(view:self.view, withImagePicker: true)
colorPicker.delegate = self
self.view.addSubview(colorPicker)
```

Then, in order to get the color when it has changed, you just have to implement the following protocol :

```swift
protocol FTColorPickerRecognizerDelegate{
    func didChangeColor(color:UIColor)
}
```

And you are done! You can also hide the color spectrum on the right writing ```false``` instead of ```true``` in the ```withImagePicker``` parameter of the constructor.


