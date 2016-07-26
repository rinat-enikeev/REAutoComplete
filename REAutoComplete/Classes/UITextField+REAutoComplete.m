//
//  UITextField+REAutoComplete.m
//  Pods
//
//  Created by Rinat Enikeev on 25/07/16.
//
//

#import <objc/runtime.h>
#import "UITextField+REAutoComplete.h"

@interface REAutoComplete() <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) UITextField* textField;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray<id<REAutoCompleteItem>> *suggestions;
@end

@implementation UITextField(REAutoComplete)

static char _autoComplete;

- (REAutoComplete*)autoComplete {
    id autoComplete = objc_getAssociatedObject(self, &_autoComplete);
    if (autoComplete == nil) {
        REAutoComplete* obj = [[REAutoComplete alloc] init];
        obj.textField = self;
        obj.textField.delegate = obj;
        autoComplete = obj;
        self.autoComplete = obj;
    }
    return autoComplete;
}

- (void)setAutoComplete:(REAutoComplete *)autoComplete {
    objc_setAssociatedObject(self, &_autoComplete, autoComplete, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation REAutoComplete

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tableView = [self constructTableView];
        self.tableViewHeight = 100; // default
        self.tableViewFrame = CGRectZero;
    }
    return self;
}

- (UITableView*)constructTableView {
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.tableViewFrame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
}

- (CGRect)tableViewFrame {
    if (CGRectEqualToRect(_tableViewFrame, CGRectZero)) {
        CGRect frame = self.textField.frame;
        frame.origin.y += self.textField.frame.size.height;
        frame.size.height = self.tableViewHeight;
        return frame;
    } else {
        return _tableViewFrame;
    }
}

- (void)setAutoCompleteTableVisibility:(BOOL)visible {
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    self.tableView.hidden = !visible;
    
    if (visible) {
        if ([self.delegate respondsToSelector:@selector(autoCompleteWillAppear:)]) {
            [self.delegate autoCompleteWillAppear:self];
        }
        
        if (!self.keyboardAccessory) {
            if (self.tableView.superview == nil) {
                self.tableView.frame = self.tableViewFrame;
                [self.textField.superview addSubview:self.tableView];
            }
        } else {
            if (self.textField.inputAccessoryView == nil) {
                self.tableView.frame = self.tableViewFrame;
                [self.textField setInputAccessoryView:self.tableView];
                [self.textField reloadInputViews];
            }
        }
    } else {
        if (self.tableView.superview != nil || self.textField.inputAccessoryView != nil) {
            if ([self.delegate respondsToSelector:@selector(autoCompleteWillDissapear:)]) {
                [self.delegate autoCompleteWillDissapear:self];
            }
        }
        
        [self.tableView removeFromSuperview];
        [self.textField setInputAccessoryView:nil];
        [self.textField reloadInputViews];
    }
}

- (void)refreshSuggestionsForQuery:(NSString*)query {
    if (query.length >= self.minimumCharacters) {
        [self.algorithm suggestionsFor:query whenReady:^(NSArray<id<REAutoCompleteItem>> *suggestions) {
            [self setAutoCompleteTableVisibility:YES];
            self.suggestions = suggestions;
            [self.tableView reloadData];
        }];
    } else {
        if (!self.showAlways) {
            [self setAutoCompleteTableVisibility:NO];
            self.suggestions = nil;
            [self.tableView reloadData];
        }
    }
}

#pragma mark <UITextFieldDelegate>
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.showAlways) {
        [self setAutoCompleteTableVisibility:YES];
        [self refreshSuggestionsForQuery:@""];
    }
    
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        [self.delegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *query = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self refreshSuggestionsForQuery:query];
    
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldClear:textField];
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldReturn:textField];
    }
    return NO;
}

#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.suggestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<REAutoCompleteItem> suggestion = self.suggestions[indexPath.row];
    
    if (self.cellReuseIdentifier != nil && [self.delegate respondsToSelector:@selector(autoComplete:configureCell:withObject:)]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier];
        [self.delegate autoComplete:self configureCell:cell withObject:suggestion];
        return cell;
    } else {
        static NSString *cellIdentifier = @"DefaultCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        [cell.textLabel setText:[suggestion autoCompleteText]];
        
        return cell;
    }
    
    return nil;
}

#pragma mark <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(autocomplete:heightForRowAtIndexPath:)]) {
        return [self.delegate autoComplete:self heightForRowAtIndexPath:indexPath];
    }
    return 35.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(autoComplete:didSelectObject:)]) {
        id<REAutoCompleteItem> suggestion = self.suggestions[indexPath.row];
        [self.delegate autoComplete:self didSelectObject:suggestion];
    }
    [self setAutoCompleteTableVisibility:NO];
}


@end