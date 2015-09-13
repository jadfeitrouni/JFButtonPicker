//
//  JFButtonPicker.m
//  JFButtonPicker
//
//  Created by Phoenikia on 9/13/15.
//  Copyright (c) 2015 jad. All rights reserved.
//

#import "JFButtonPicker.h"

@interface JFButtonPicker ()
{
    JFPickerType pickerType;
    UIPickerView *picker;
    UIDatePicker *datePicker;
    NSMutableArray *pickerElements, *pickerElements2, *pickerElements3;
    NSInteger columns;
    UIView *pickerViewPopUp;
    UIView *view;
    NSMutableArray *data;
    
    NSString *dateFormat;
    NSString *localeIdentifier;
    NSString *seperator;
}

@end

@implementation JFButtonPicker

@synthesize delegate;

#pragma mark - Set up


-(void)defaultValuesForType:(JFPickerType)_type
{
    if (_type == JFPickerTypeDate)
        dateFormat = @"dd-MM-yyyy";
    else if (_type == JFPickerTypeTime)
        dateFormat = @"hh:mm a";
    else if (_type == JFPickerTypeDateTime)
        dateFormat = @"dd-MM-yyyy hh:mm";
    seperator = @" ";
    localeIdentifier = @"en_US";
}


- (void)setWithPickerType:(JFPickerType)_type data:(NSMutableArray *)_dataOrNil delegate:(id<buttonPickerDelegate>)_delegate
{
    [self addTarget:self action:@selector(handleButtonPickerm) forControlEvents:UIControlEventTouchUpInside];
    self.delegate = _delegate;
    NSLog(@"%@",delegate);
    data = _dataOrNil;
    pickerType = _type;
    
    [self defaultValuesForType:pickerType];
    
    
    // initialise pickerViewPopUp
    CGRect screenSize = [[UIScreen mainScreen]bounds];
    pickerViewPopUp = [[UIView alloc] init];
    view = [[UIView alloc]initWithFrame:screenSize];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    // toolbar initialisation
    UIToolbar *pickerToolbar = [[UIToolbar alloc]init];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(categoryDoneButtonPressed)];
    
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    
    doneBtn.tintColor = [UIColor whiteColor];
    cancelBtn.tintColor = [UIColor whiteColor];
    
    [pickerToolbar setItems:@[cancelBtn, flexSpace, doneBtn] animated:YES];
    
    
    //check picker type and add it to the pickerviewpopup
    
    switch (pickerType) {
        case JFPickerTypeData:
            picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, screenSize.size.width, 100)];
            picker.dataSource = self;
            picker.delegate = self;
            [pickerViewPopUp addSubview:picker];
            
            break;
            
        case JFPickerTypeDate:
            datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, screenSize.size.width, 100)];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [pickerViewPopUp addSubview:datePicker];
            
            break;
        case JFPickerTypeTime:
            datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, screenSize.size.width, 100)];
            datePicker.datePickerMode = UIDatePickerModeTime;
            [pickerViewPopUp addSubview:datePicker];
            
            break;
        case JFPickerTypeDateTime:
            datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, screenSize.size.width, 100)];
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            [pickerViewPopUp addSubview:datePicker];
            
        default:
            break;
    }
    
    
    [pickerViewPopUp addSubview:pickerToolbar];
    [pickerViewPopUp setFrame:CGRectMake(0, screenSize.size.height, screenSize.size.width, 464)];
    [pickerViewPopUp setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    [view addSubview:pickerViewPopUp];
    
    // to close the picker view when user press outside
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    singleTap.numberOfTapsRequired = 1;
    [view addGestureRecognizer:singleTap];
}



-(void)categoryDoneButtonPressed
{
    if (pickerType == JFPickerTypeDate)
    {
        NSDate *chosenDate=[datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
        [self setTitle:[dateFormatter stringFromDate:chosenDate] forState:UIControlStateNormal];
        [delegate didSelectDate:chosenDate];
    }
    else if (pickerType == JFPickerTypeTime)
    {
        NSDate *chosenTime=[datePicker date];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:dateFormat];
        [timeFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
        [self setTitle:[timeFormatter stringFromDate:chosenTime] forState:UIControlStateNormal];
        [delegate didSelectDate:chosenTime];
    }
    else if (pickerType == JFPickerTypeDateTime)
    {
        NSDate *chosenDateTime=[datePicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
        [self setTitle:[dateFormatter stringFromDate:chosenDateTime] forState:UIControlStateNormal];
        [delegate didSelectDate:chosenDateTime];
    }
    else if (pickerType == JFPickerTypeData)
    {
        NSMutableString *result = [NSMutableString string];
        NSMutableArray *dataArray = [NSMutableArray new];
        for (int i=0; i<[data count]; i++)
        {
            if (i == 0)
                [result appendString:[NSString stringWithFormat:@"%@",[[data objectAtIndex:i] objectAtIndex:[picker selectedRowInComponent:i]]]];
            else
                [result appendString:[NSString stringWithFormat:@"%@%@",seperator,[[data objectAtIndex:i] objectAtIndex:[picker selectedRowInComponent:i]]]];
            [dataArray addObject:[[data objectAtIndex:i] objectAtIndex:[picker selectedRowInComponent:i]]];
            NSInteger row = [picker selectedRowInComponent:i];
            [delegate didSelectRow:row InSection:i];
        }
        
        [delegate didSelectItems:dataArray];
        [self setTitle:result forState:UIControlStateNormal];
    }
    
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self closeView];
    
}


-(void)closeView
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         [pickerViewPopUp setFrame:CGRectMake(pickerViewPopUp.frame.origin.x, pickerViewPopUp.frame.origin.y+250, pickerViewPopUp.frame.size.width, pickerViewPopUp.frame.size.height )];
                         [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
                     }
                     completion:^(BOOL finished) {
                         [view removeFromSuperview];
                         
                     }];
}

-(void)setDateFormat:(NSString *)_dateFormat LocalIdentifier:(NSString *)_localeIdentifier
{
    dateFormat = _dateFormat;
    localeIdentifier = _localeIdentifier;
}

-(void)setSeperatorFormat:(NSString *)_seperator
{
    seperator = _seperator;
}


#pragma mark - Picker methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([data count] > 0) {
        return [data count];
    }
    else return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([[data objectAtIndex:component] count]>0) {
        return [[data objectAtIndex:component] count];
    }
    else return 1;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([[data objectAtIndex:component] count]>0)
    {
        return [[data objectAtIndex:component] objectAtIndex:row];
    }
    else
    {
        return @"No Data";
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}



- (void)handleButtonPickerm
{
    [self.superview addSubview:view];
    [view setHidden:NO];
    [view setFrame:self.superview.frame];
    [UIView animateWithDuration:0.3
                     animations:^{
                         [pickerViewPopUp setFrame:CGRectMake(pickerViewPopUp.frame.origin.x,pickerViewPopUp.frame.origin.y-250, pickerViewPopUp.frame.size.width, pickerViewPopUp.frame.size.height)];
                         [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
                     }
                     completion:nil];
    
}






@end