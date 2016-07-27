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
    [self styleSuggestionTableView];
}

- (void)styleSuggestionTableView {
    self.textField.autoComplete.tableViewCellTextColor = [UIColor colorWithRed:23.0/255.0 green:119.0/206.0 blue:255.0/225.0 alpha:1.0];
    self.textField.autoComplete.tableViewCellApplyBoldEffect = YES;
    self.textField.autoComplete.tableViewTopMargin = 5;
    self.textField.autoComplete.tableViewBottomMargin = 5;
    self.textField.autoComplete.tableViewAutoHeight = YES;
    self.textField.autoComplete.tableView.layer.cornerRadius = 5;
    self.textField.autoComplete.tableView.layer.borderWidth = 1;
    self.textField.autoComplete.tableView.layer.borderColor = [UIColor colorWithRed:181.0/255.0 green:204.0/255.0 blue:255.0/225.0 alpha:1.0].CGColor;
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
