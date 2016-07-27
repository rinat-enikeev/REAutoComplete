# REAutoComplete

[![CI Status](http://img.shields.io/travis/Rinat Enikeev/REAutoComplete.svg?style=flat)](https://travis-ci.org/rinat-enikeev/REAutoComplete)
[![Version](https://img.shields.io/cocoapods/v/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)
[![License](https://img.shields.io/cocoapods/l/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)
[![Platform](https://img.shields.io/cocoapods/p/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)

UITextField category to add autocomplete suggestions in a UITableView.

## Usage

Adapt REAutoCompleteItem protocol: 

````objc
#import <REAutoComplete/REAutoComplete.h>

@interface NSString (REAutoCompleteItem) <REAutoCompleteItem>
@end
@implementation NSString (REAutoCompleteItem)
- (NSString*)autoCompleteText {
    return self;
}
@end
````

DataSource based: 

````objc
#import <REAutoComplete/REAutoComplete.h>

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textField.autoComplete.dataSource = self;
    self.textField.autoComplete.delegate = self;
}

#pragma mark <REAutoCompleteDataSource>
- (void)autoComplete:(REAutoComplete*)autoComplete suggestionsFor:(NSString*)query whenReady:(void (^)(NSArray<id<REAutoCompleteItem>>* suggestions))callback {
    callback(@[@"suggestion"]);
}

````

Algorithm based: 

````objc

#import <REAutoComplete/REAutoComplete.h>

- (void)viewDidLoad {
    [super viewDidLoad];
    id<REAutoCompleteAlgorithm> algorithm = <algorithm>;
    self.textField.autoComplete.algorithm = algorithm;
    self.textField.autoComplete.delegate = self;
}
````

## Installation

REAutoComplete is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'REAutoComplete'
```

## Author

Rinat Enikeev, http://rinat-enikeev.github.io

## License

REAutoComplete is available under the MIT license. See the LICENSE file for more info.
