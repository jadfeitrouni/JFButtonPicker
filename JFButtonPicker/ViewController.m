//
//  ViewController.m
//  JFButtonPicker
//
//  Created by Phoenikia on 9/13/15.
//  Copyright (c) 2015 jad. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.date setWithPickerType:JFPickerTypeDate data:nil delegate:self];
    [self.time setWithPickerType:JFPickerTypeTime data:nil delegate:self];
    [self.dateTime setWithPickerType:JFPickerTypeDateTime data:nil delegate:self];
    NSArray *array1 = @[@"arr1Obj1",@"arr1Obj2",@"arr1Obj3",@"arr1Obj4",@"arr1Obj5"];
    NSArray *array2 = @[@"arr2Obj1",@"arr2Obj2",@"arr2Obj3",@"arr2Obj4",@"arr2Obj5",@"arr2Obj6"];
    NSArray *array3 = @[@"arr3Obj1",@"arr3Obj2",@"arr3Obj3",@"arr3Obj4"];
    
    NSArray *pickerData = @[array1,array2,array3];
    [self.data setWithPickerType:JFPickerTypeData data:pickerData delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonPickerDelegate

-(void)didSelectDate:(NSDate *)date
{
    NSLog(@"Date Selected: %@",date);
}

-(void)didSelectRow:(NSInteger)row InSection:(NSInteger)section
{
    NSLog(@"Row %li in Section %li",(long)row,(long)section);
}

-(void)didSelectItems:(NSArray *)items
{
    NSLog(@"%@",items);
}

@end
