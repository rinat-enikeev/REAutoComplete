# REAutoComplete

[![CI Status](http://img.shields.io/travis/Rinat Enikeev/REAutoComplete.svg?style=flat)](https://travis-ci.org/rinat-enikeev/REAutoComplete)
[![Version](https://img.shields.io/cocoapods/v/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)
[![License](https://img.shields.io/cocoapods/l/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)
[![Platform](https://img.shields.io/cocoapods/p/REAutoComplete.svg?style=flat)](http://cocoapods.org/pods/REAutoComplete)

UITextField category to add autocomplete suggestions in a UITableView.

## Usage

Adapt id<REAutoCompleteItem> protocol: 

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
    // all UITextFieldDelegate calls are forwarded to autoComplete.delegate
    self.textField.autoComplete.delegate = self;
}

#pragma mark <REAutoCompleteDataSource>
- (void)autoComplete:(REAutoComplete*)autoComplete suggestionsFor:(NSString*)query whenReady:(void (^)(NSArray<id<REAutoCompleteItem>>* suggestions))callback {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSMutableArray *array = <array of id<REAutoCompleteItem>>;
        if (query.length > 0) {
            NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] %@", query];
            [array filterUsingPredicate:predicate];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            callback(array);
        });
    });
}

#pragma mark <REAutoCompleteDelegate>
- (void)autoComplete:(REAutoComplete*)autoComplete didSelectObject:(id<REAutoCompleteItem>)object {
    self.textField.text = [object autoCompleteText];
    [self.textField resignFirstResponder];
}

#pragma mark <UITextFieldDelegate>
// all UITextFieldDelegate calls are forwarded to autoComplete.delegate
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"TextField cleared");
    return YES;
}

````

Algorithm based: 
````objc

#import <REAutoComplete/REAutoComplete.h>

@interface ViewController () <REAutoCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

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
