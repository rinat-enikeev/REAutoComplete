//
//  REViewController.m
//  REAutoComplete
//
//  Created by Rinat Enikeev on 07/25/2016.
//  Copyright (c) 2016 Rinat Enikeev. All rights reserved.
//

#import "REAlgorithmViewController.h"
#import <REAutoComplete/REAutoComplete.h>
#import "REDataProvider.h"

@interface REAlgorithmViewController () <REAutoCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation REAlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id<REAutoCompleteAlgorithm> algorithm = [[REAutoCompleteAlgorithmContains alloc] initWithSuggestions:[[REDataProvider sharedProvider] countriesArray]];
    self.textField.autoComplete.algorithm = algorithm;
    
    // all UITextFieldDelegate calls are forwarded to autoComplete.delegate
    self.textField.autoComplete.delegate = self;
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

@end
