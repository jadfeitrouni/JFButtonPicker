//
//  ViewController.h
//  JFButtonPicker
//
//  Created by Phoenikia on 9/13/15.
//  Copyright (c) 2015 jad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFButtonPicker.h"

@interface ViewController : UIViewController <buttonPickerDelegate>

@property (weak, nonatomic) IBOutlet JFButtonPicker *date;
@property (weak, nonatomic) IBOutlet JFButtonPicker *time;
@property (weak, nonatomic) IBOutlet JFButtonPicker *dateTime;
@property (weak, nonatomic) IBOutlet JFButtonPicker *data;


@end

