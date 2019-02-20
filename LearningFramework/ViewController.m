//
//  ViewController.m
//  LearningFramework
//
//  Created by mac on 2017/9/26.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "ViewController.h"
#import "ZQKnobControl.h"

@interface ViewController (){
    ZQKnobControl *_knobControl;
}

@property (weak, nonatomic) IBOutlet UISwitch *animationSwitch;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *knobPlaceHolder;
@property (weak, nonatomic) IBOutlet UISlider *valueSender;
@property (weak, nonatomic) IBOutlet UISlider *valueSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _knobControl = [[ZQKnobControl alloc] initWithFrame:self.knobPlaceHolder.bounds];
    [self.knobPlaceHolder addSubview:_knobControl];
    _knobControl.lineWidth = 4.0;
    _knobControl.pointerLength = 8.0;
    self.view.tintColor = [UIColor redColor];
    [_knobControl addObserver:self forKeyPath:@"value" options:0 context:NULL];
    [_knobControl addTarget:self action:@selector(handleValueChanged:) forControlEvents:UIControlEventValueChanged];
    _knobControl.continuous = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)randomValueDidPressed:(id)sender {
    CGFloat randomValue =  (arc4random() % 101) / 100.f;
    [_knobControl setValue:randomValue animated:self.animationSwitch.on];
    [self.valueSender setValue:randomValue animated:self.animationSwitch.on];
//    [_knobControl setBounds:CGRectMake(0, 0, 100, 100)];
}
- (IBAction)sliderMoved:(UISlider *)sender {
    _knobControl.value = sender.value;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if(object == _knobControl && [keyPath isEqualToString:@"value"]) {
        self.valueLabel.text = [NSString stringWithFormat:@"%0.2f", _knobControl.value];
    }
}

- (void)handleValueChanged:(id)sender{
    if (sender == _knobControl) {
        self.valueSlider.value = _knobControl.value;
    }else if (sender == self.valueSlider){
        _knobControl.value = self.valueSlider.value;
    }
}

@end
