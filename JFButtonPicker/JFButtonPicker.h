//
//  JFButtonPicker.h
//  JFButtonPicker
//
//  Created by Phoenikia on 9/13/15.
//  Copyright (c) 2015 jad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JFPickerType)
{
    JFPickerTypeData,
    JFPickerTypeDate,
    JFPickerTypeTime,
    JFPickerTypeDateTime
};



@protocol buttonPickerDelegate <NSObject>

-(void)didSelectDate:(NSDate*)date;
-(void)didSelectRow:(NSInteger)row InSection:(NSInteger)section;
-(void)didSelectItems:(NSArray*)items;

@end

@interface JFButtonPicker : UIButton <UIPickerViewDataSource,UIPickerViewDelegate>

@property id<buttonPickerDelegate>delegate;

- (void)setWithPickerType:(JFPickerType)_type data:(NSArray *)_dataOrNil delegate:(id<buttonPickerDelegate>)_delegate;

-(void)setDateFormat:(NSString*)dateFormat LocalIdentifier:(NSString*)localeIdentifier;
-(void)setSeperatorFormat:(NSString*)seperator;



@end
