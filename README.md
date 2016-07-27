# REAutoComplete

[![CI Status](http://img.shields.io/travis/Rinat Enikeev/REAutoComplete.svg?style=flat)](https://travis-ci.org/rinat-enikeev/REAutoComplete)
[![Version](https://img.shields.io/cocoapods/v/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)
[![License](https://img.shields.io/cocoapods/l/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)
[![Platform](https://img.shields.io/cocoapods/p/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)

UITextField category to add autocomplete suggestions in a UITableView.

## Usage

````objc

#import <REAutoComplete/REAutoComplete.h>

- (void)viewDidLoad {
    [super viewDidLoad];
    id<REAutoCompleteAlgorithm> algorithm = <algorithm>;
    self.textField.autoComplete.algorithm = algorithm;
    self.textField.autoComplete.delegate = self;
}

#pragma mark <REAutoCompleteDelegate>
- (void)autoComplete:(REAutoComplete*)autoComplete didSelectObject:(id<REAutoCompleteItem>)object {
    self.textField.text = [object autoCompleteText];
}

````

## Requirements

iOS 8+

## Installation

REAutoComplete is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'REAutoComplete'
```

## Author

Rinat Enikeev, rinat-enikeev.github.io

## License

REAutoComplete is available under the MIT license. See the LICENSE file for more info.
