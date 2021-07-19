//
//  ViewController.m
//  RSSchool_T8
//
//  Created by Татьяна Лузанова on 16.07.2021.
//

#import "ViewController.h"
#import "SubView.h"
#import "DrawingsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *navigatonBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *drawingsButton;

@property UISlider *timerSlider;
@property UILabel *labelCurrent;
@property (weak, nonatomic) IBOutlet UIView *image;
@property (weak, nonatomic) IBOutlet UIButton *openPalette;
@property (weak, nonatomic) IBOutlet UIButton *openTimer;
@property (weak, nonatomic) IBOutlet UIButton *draw;
@property (weak, nonatomic) IBOutlet UIButton *share;

@property (nonatomic, strong) SubView *paletteView;
@property (nonatomic, strong) SubView *timerView;
@property (nonatomic) NSMutableArray<UIButton *> *selectedColors;

@property UIColor *imageColor;

@property UIColor *textBottomColor;
@property UIColor *red;
@property UIColor *blue;
@property UIColor *green;
@property UIColor *gray;
@property UIColor *purple;
@property UIColor *peach;
@property UIColor *yellow;
@property UIColor *lightBlue;
@property UIColor *pink;
@property UIColor *black;
@property UIColor *darkGray;
@property UIColor *vine;

@property(nonatomic) float maximumValue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    setupColors
    self.imageColor = [UIColor colorWithRed:0.0/255 green:178.0/255 blue:255.0/255 alpha:1];
    self.textBottomColor = [UIColor colorWithRed:33.0/255 green:176.0/255 blue:142.0/255 alpha:1];
    self.red = [UIColor colorWithRed:226.0/255 green:27.0/255 blue:44.0/255 alpha:1];
    self.blue = [UIColor colorWithRed:62.0/255 green:23.0/255 blue:204.0/255 alpha:1];
    self.green = [UIColor colorWithRed:0.0/255 green:124.0/255 blue:55.0/255 alpha:1];
    self.gray = [UIColor colorWithRed:128.0/255 green:128.0/255 blue:128.0/255 alpha:1];
    self.purple = [UIColor colorWithRed:157.0/255 green:94.0/255 blue:234.0/255 alpha:1];
    self.peach = [UIColor colorWithRed:255.0/255 green:122.0/255 blue:104.0/255 alpha:1];
    self.yellow = [UIColor colorWithRed:255.0/255 green:173.0/255 blue:84.0/255 alpha:1];
    self.lightBlue = [UIColor colorWithRed:0.0/255 green:174.0/255 blue:237.0/255 alpha:1];
    self.pink = [UIColor colorWithRed:255.0/255 green:119.0/255 blue:162.0/255 alpha:1];
    self.black = [UIColor colorWithRed:0.0/255 green:46.0/255 blue:60.0/255 alpha:1];
    self.darkGray = [UIColor colorWithRed:14.0/255 green:55.0/255 blue:24.0/255 alpha:1];
    self.vine = [UIColor colorWithRed:97.0/255 green:15.0/255 blue:16.0/255 alpha:1];
    
//    setup imageView
    self.image.layer.cornerRadius = 8;
    self.image.layer.shadowColor = self.imageColor.CGColor;
    self.image.layer.shadowRadius = 8;
    self.image.layer.shadowOffset = CGSizeMake(0, 0);
    self.image.layer.shadowOpacity = 0.25;
    
    
//    setup button
    [self.openPalette setTitle:@"Open Palette" forState:UIControlStateNormal];
    self.openPalette.layer.cornerRadius = 10;
    self.openPalette.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.openPalette.layer.shadowColor = UIColor.blackColor.CGColor;
    self.openPalette.layer.shadowRadius = 2;
    self.openPalette.layer.shadowOffset = CGSizeMake(0, 0);
    self.openPalette.layer.shadowOpacity = 0.25;
    

    [self.openTimer setTitle:@"Open Timer" forState:UIControlStateNormal];
    self.openTimer.layer.cornerRadius = 10;
    self.openTimer.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.openTimer.layer.shadowColor = UIColor.blackColor.CGColor;
    self.openTimer.layer.shadowRadius = 2;
    self.openTimer.layer.shadowOffset = CGSizeMake(0, 0);
    self.openTimer.layer.shadowOpacity = 0.25;
    
    [self.draw setTitle:@"Draw" forState:UIControlStateNormal];
    self.draw.layer.cornerRadius = 10;
    self.draw.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.draw.layer.shadowColor = UIColor.blackColor.CGColor;
    self.draw.layer.shadowRadius = 2;
    self.draw.layer.shadowOffset = CGSizeMake(0, 0);
    self.draw.layer.shadowOpacity = 0.25;
    
    [self.share setTitle:@"Share" forState:UIControlStateNormal];
    self.share.layer.cornerRadius = 10;
    self.share.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.share.layer.shadowColor = UIColor.blackColor.CGColor;
    self.share.layer.shadowRadius = 2;
    self.share.layer.shadowOffset = CGSizeMake(0, 0);
    self.share.layer.shadowOpacity = 0.25;
    self.share.alpha = 0.5;
    self.share.enabled = NO;
    
//    setupPaletteColors
    self.selectedColors = [[NSMutableArray alloc] init];
    
    self.paletteView = [[SubView alloc] initWithFrame:CGRectMake(0, 333, 375, 334) andColor:[UIColor whiteColor]];
    [self.view addSubview:self.paletteView];
    self.paletteView.hidden = YES;
    [self setMaskTo:self.paletteView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    self.paletteView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.paletteView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.paletteView.layer.shadowRadius = 8;
    self.paletteView.layer.shadowOffset = CGSizeMake(0, 0);
    self.paletteView.layer.shadowOpacity = 0.25;
    
//  adding SaveColorsButton
    UIButton *saveColorButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 85, 32)];
    [saveColorButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.paletteView addSubview:saveColorButton];
    saveColorButton.layer.cornerRadius = 10;
    [saveColorButton setTitleColor:self.textBottomColor forState:UIControlStateNormal];
    saveColorButton.layer.backgroundColor = UIColor.whiteColor.CGColor;
    saveColorButton.layer.shadowColor = UIColor.blackColor.CGColor;
    saveColorButton.layer.shadowRadius = 2;
    saveColorButton.layer.shadowOffset = CGSizeMake(0, 0);
    saveColorButton.layer.shadowOpacity = 0.25;
   
    [saveColorButton addTarget:self
                            action:@selector(tapSaveColor:)
                            forControlEvents:UIControlEventTouchUpInside];

    [self addColorButton:CGRectMake(17, 92, 40, 40) color:self.red];
    [self addColorButton:CGRectMake(77, 92, 40, 40) color:self.blue];
    [self addColorButton:CGRectMake(137, 92, 40, 40) color:self.green];
    [self addColorButton:CGRectMake(197, 92, 40, 40) color:self.gray];
    [self addColorButton:CGRectMake(257, 92, 40, 40) color:self.purple];
    [self addColorButton:CGRectMake(317, 92, 40, 40) color:self.peach];
    [self addColorButton:CGRectMake(17, 152, 40, 40) color:self.yellow];
    [self addColorButton:CGRectMake(77, 152, 40, 40) color:self.lightBlue];
    [self addColorButton:CGRectMake(137, 152, 40, 40) color:self.pink];
    [self addColorButton:CGRectMake(197, 152, 40, 40) color:self.black];
    [self addColorButton:CGRectMake(257, 152, 40, 40) color:self.darkGray];
    [self addColorButton:CGRectMake(317, 152, 40, 40) color:self.vine];
    
    
//    openPalette action
    [self.openPalette addTarget:self
                              action:@selector(openPaletteTapped:)
                              forControlEvents:UIControlEventTouchUpInside];
    
//    setupTimerView
    self.timerView = [[SubView alloc] initWithFrame:CGRectMake(0, 333, 375, 334) andColor:[UIColor whiteColor]];
    [self.view addSubview:self.timerView];
    self.timerView.hidden = YES;
    [self setMaskTo:self.timerView byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    self.timerView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.timerView.layer.mask.shadowColor = UIColor.blackColor.CGColor;
    self.timerView.layer.mask.shadowRadius = 8;
    self.timerView.layer.mask.shadowOffset = CGSizeMake(0, 0);
    self.timerView.layer.mask.shadowOpacity = 0.25;
    
//  adding SaveTimerButton
    UIButton *saveTimerButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 85, 32)];
    [saveTimerButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.timerView addSubview:saveTimerButton];
    saveTimerButton.layer.cornerRadius = 10;
    [saveTimerButton setTitleColor:self.textBottomColor forState:UIControlStateNormal];
    saveTimerButton.layer.backgroundColor = UIColor.whiteColor.CGColor;
    saveTimerButton.layer.shadowColor = UIColor.blackColor.CGColor;
    saveTimerButton.layer.shadowRadius = 2;
    saveTimerButton.layer.shadowOffset = CGSizeMake(0, 0);
    saveTimerButton.layer.shadowOpacity = 0.25;
    
    //    adding slider-component
    self.timerSlider = [[UISlider alloc] initWithFrame:CGRectMake(58, 92, 255, 44)];
    [self.timerView addSubview:self.timerSlider];
    self.timerSlider.minimumTrackTintColor = self.textBottomColor;
    self.timerSlider.minimumValue = 1;
    self.timerSlider.maximumValue = 5;
    self.timerSlider.value = 1.0;
    
    UILabel *labelMin = [[UILabel alloc] initWithFrame:CGRectMake(30, 102, 255, 20)];
    UILabel *labelMax = [[UILabel alloc] initWithFrame:CGRectMake(320, 102, 255, 20)];
    labelMin.text = @"1.0";
    labelMax.text = @"5.0";
    [self.timerView addSubview:labelMin];
    [self.timerView addSubview:labelMax];
    
    self.labelCurrent = [[UILabel alloc] initWithFrame:CGRectMake(180, 130, 255, 20)];
    [self.timerView addSubview:self.labelCurrent];
    self.timerSlider.continuous = true;
    [self.timerSlider addTarget:self action:@selector(onSlider:) forControlEvents:UIControlEventValueChanged];
    [self onSlider:nil];
       
    [saveTimerButton addTarget:self
                                action:@selector(tapSaveTimer:)
                                forControlEvents:UIControlEventTouchUpInside];
        
    //    openTimer action
        [self.openTimer addTarget:self
                                  action:@selector(openTimerTapped:)
                                  forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addColorButton:(CGRect)rect color:(UIColor *)color {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [self.paletteView addSubview:button];
    button.layer.cornerRadius = 6;
    button.layer.borderColor = UIColor.whiteColor.CGColor;
    button.layer.borderWidth = 2;
    button.layer.backgroundColor = UIColor.whiteColor.CGColor;
    button.layer.shadowColor = UIColor.blackColor.CGColor;
    button.layer.shadowRadius = 2;
    button.layer.shadowOffset = CGSizeMake(0, 0);
    button.layer.shadowOpacity = 0.25;
    CALayer *la = [[CALayer alloc] init];
    la.frame = CGRectMake(8, 8, 24, 24);
    la.backgroundColor = color.CGColor;
    la.cornerRadius = 6;
    [button.layer addSublayer:la];
    [button addTarget:self action:@selector(tapColor:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)onSlider:(id)sender {
    self.labelCurrent.text = [NSString stringWithFormat:@"%.2f", self.timerSlider.value];
}

- (IBAction)onDraw:(id)sender {
    self.image.layer.sublayers = nil;

    NSInteger drawing = 1;
    if ([NSUserDefaults.standardUserDefaults objectForKey:@"Drawing"]) {
        drawing = [NSUserDefaults.standardUserDefaults integerForKey:@"Drawing"];
    }

    if (drawing == 1) {
        [self planet1];
        [self planet2];
        [self planet3];
    }
    else if (drawing == 2) {
        [self head1];
        [self head2];
        [self head3];
    }
    else if (drawing == 3) {
        [self tree1];
        [self tree2];
        [self tree3];
    }
    else if (drawing == 4) {
        [self landScape1];
        [self landScape2];
        [self landScape3];
    }
    
    
}

- (void)head1 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:0];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(184, 100)];
    [bezierPath addLineToPoint: CGPointMake(175.5, 98.5)];
    [bezierPath addLineToPoint: CGPointMake(166, 100.5)];
    [bezierPath addLineToPoint: CGPointMake(158, 101.5)];
    [bezierPath addLineToPoint: CGPointMake(148.5, 100.5)];
    [bezierPath addLineToPoint: CGPointMake(140, 99)];
    [bezierPath addLineToPoint: CGPointMake(133.5, 98.5)];
    [bezierPath addLineToPoint: CGPointMake(126, 100)];
    [bezierPath addLineToPoint: CGPointMake(121.5, 102)];
    [bezierPath addLineToPoint: CGPointMake(127.5, 104.5)];
    [bezierPath addLineToPoint: CGPointMake(132, 108)];
    [bezierPath addLineToPoint: CGPointMake(136.5, 113)];
    [bezierPath addLineToPoint: CGPointMake(142.5, 115.5)];
    [bezierPath addLineToPoint: CGPointMake(150, 116.5)];
    [bezierPath addLineToPoint: CGPointMake(157, 115.5)];
    [bezierPath addLineToPoint: CGPointMake(164.5, 116.5)];
    [bezierPath addLineToPoint: CGPointMake(170.5, 115.5)];
    [bezierPath addLineToPoint: CGPointMake(177, 111.5)];
    [bezierPath addLineToPoint: CGPointMake(184, 103.5)];
    [bezierPath addLineToPoint: CGPointMake(188.5, 97.5)];
    [bezierPath addLineToPoint: CGPointMake(180.5, 96.5)];
    [bezierPath addLineToPoint: CGPointMake(171.5, 95.5)];
    [bezierPath addLineToPoint: CGPointMake(162.5, 93.5)];
    [bezierPath addLineToPoint: CGPointMake(154, 93)];
    [bezierPath addLineToPoint: CGPointMake(144, 94.5)];
    [bezierPath addLineToPoint: CGPointMake(135, 96.5)];
    [bezierPath addLineToPoint: CGPointMake(125, 97.5)];
    [bezierPath addLineToPoint: CGPointMake(118, 97)];
    [bezierPath addLineToPoint: CGPointMake(127.5, 91)];
    [bezierPath addLineToPoint: CGPointMake(136.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(142.5, 81)];
    [bezierPath addLineToPoint: CGPointMake(147.5, 82.5)];
    [bezierPath addLineToPoint: CGPointMake(153, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(159.5, 83.5)];
    [bezierPath addLineToPoint: CGPointMake(166, 82.5)];
    [bezierPath addLineToPoint: CGPointMake(171.5, 82.5)];
    [bezierPath addLineToPoint: CGPointMake(174.5, 84.5)];
    [bezierPath addLineToPoint: CGPointMake(179.5, 89.5)];
    [bezierPath addLineToPoint: CGPointMake(187, 94)];
    
    layer.path = bezierPath.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)head2 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:1];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(61.5, 29)];
    [bezier2Path addLineToPoint: CGPointMake(77, 89)];
    [bezier2Path addLineToPoint: CGPointMake(89, 112)];
    [bezier2Path addLineToPoint: CGPointMake(106.5, 131.5)];
    [bezier2Path addLineToPoint: CGPointMake(133.5, 154)];
    [bezier2Path addLineToPoint: CGPointMake(157, 159.5)];
    [bezier2Path addLineToPoint: CGPointMake(193, 142)];
    [bezier2Path addLineToPoint: CGPointMake(220, 112)];
    [bezier2Path addLineToPoint: CGPointMake(228.5, 100)];
    [bezier2Path addLineToPoint: CGPointMake(228.5, 77.5)];
    [bezier2Path addLineToPoint: CGPointMake(230.5, 50.5)];
    [bezier2Path addLineToPoint: CGPointMake(218.5, 40.5)];
    [bezier2Path addLineToPoint: CGPointMake(202, 43.5)];
    [bezier2Path addLineToPoint: CGPointMake(191, 60.5)];
    [bezier2Path addLineToPoint: CGPointMake(189, 83.5)];
    [bezier2Path addLineToPoint: CGPointMake(193, 96)];
    
    layer.path = bezier2Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)head3 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:2];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(189.5, 102.5)];
    [bezier3Path addLineToPoint: CGPointMake(194, 108.5)];
    [bezier3Path addLineToPoint: CGPointMake(196.5, 115)];
    [bezier3Path addLineToPoint: CGPointMake(193, 124)];
    [bezier3Path addLineToPoint: CGPointMake(186, 132.5)];
    [bezier3Path addLineToPoint: CGPointMake(177, 139.5)];
    [bezier3Path addLineToPoint: CGPointMake(167.5, 132.5)];
    [bezier3Path addLineToPoint: CGPointMake(157, 128.5)];
    [bezier3Path addLineToPoint: CGPointMake(147.5, 128.5)];
    [bezier3Path addLineToPoint: CGPointMake(135.5, 132.5)];
    [bezier3Path addLineToPoint: CGPointMake(127.5, 142)];
    [bezier3Path addLineToPoint: CGPointMake(121, 154.5)];
    [bezier3Path addLineToPoint: CGPointMake(109.5, 147.5)];
    [bezier3Path addLineToPoint: CGPointMake(101.5, 137.5)];
    [bezier3Path addLineToPoint: CGPointMake(93, 128.5)];
    [bezier3Path addLineToPoint: CGPointMake(93, 142)];
    [bezier3Path addLineToPoint: CGPointMake(93, 170.5)];
    [bezier3Path addLineToPoint: CGPointMake(93, 187.5)];
    [bezier3Path addLineToPoint: CGPointMake(86, 199)];
    [bezier3Path addLineToPoint: CGPointMake(74.5, 207.5)];
    [bezier3Path addLineToPoint: CGPointMake(63.5, 214.5)];
    [bezier3Path addLineToPoint: CGPointMake(81, 221)];
    [bezier3Path addLineToPoint: CGPointMake(94.5, 229.5)];
    [bezier3Path addLineToPoint: CGPointMake(105, 243.5)];
    [bezier3Path addLineToPoint: CGPointMake(119, 261)];
    [bezier3Path addLineToPoint: CGPointMake(138, 279)];
    [bezier3Path addLineToPoint: CGPointMake(157, 285.5)];
    [bezier3Path addLineToPoint: CGPointMake(171, 285.5)];
    [bezier3Path addLineToPoint: CGPointMake(186, 277.5)];
    [bezier3Path addLineToPoint: CGPointMake(199.5, 261)];
    [bezier3Path addLineToPoint: CGPointMake(209.5, 239.5)];
    [bezier3Path addLineToPoint: CGPointMake(219, 223.5)];
    [bezier3Path addLineToPoint: CGPointMake(233.5, 217)];
    [bezier3Path addLineToPoint: CGPointMake(237, 217)];
    [bezier3Path addLineToPoint: CGPointMake(230.5, 201.5)];
    [bezier3Path addLineToPoint: CGPointMake(221, 173)];
    [bezier3Path addLineToPoint: CGPointMake(219, 150)];
    [bezier3Path addLineToPoint: CGPointMake(219, 126.5)];
    [bezier3Path addLineToPoint: CGPointMake(212, 137.5)];
    [bezier3Path addLineToPoint: CGPointMake(204, 145.5)];
    [bezier3Path addLineToPoint: CGPointMake(196.5, 154.5)];
    [bezier3Path addLineToPoint: CGPointMake(180, 170.5)];
    [bezier3Path addLineToPoint: CGPointMake(170, 185)];
    [bezier3Path addLineToPoint: CGPointMake(161.5, 206.5)];
    [bezier3Path addLineToPoint: CGPointMake(158.5, 232.5)];
    [bezier3Path addLineToPoint: CGPointMake(158.5, 261)];
    [bezier3Path addLineToPoint: CGPointMake(158.5, 279)];

    
    layer.path = bezier3Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
    
}

- (void)planet1 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:0];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(156, 114.5)];
    [bezierPath addLineToPoint: CGPointMake(162, 111.5)];
    [bezierPath addLineToPoint: CGPointMake(171.5, 106)];
    [bezierPath addLineToPoint: CGPointMake(181, 99)];
    [bezierPath addLineToPoint: CGPointMake(187.5, 92)];
    [bezierPath addLineToPoint: CGPointMake(191.5, 85)];
    [bezierPath addLineToPoint: CGPointMake(194, 79)];
    [bezierPath moveToPoint: CGPointMake(109.5, 93)];
    [bezierPath addLineToPoint: CGPointMake(102.5, 92.5)];
    [bezierPath addLineToPoint: CGPointMake(96.5, 90.5)];
    [bezierPath addLineToPoint: CGPointMake(91.5, 87.5)];
    [bezierPath moveToPoint: CGPointMake(120, 91.5)];
    [bezierPath addLineToPoint: CGPointMake(127.5, 89.5)];
    [bezierPath addLineToPoint: CGPointMake(135.5, 87)];
    [bezierPath addLineToPoint: CGPointMake(143.5, 82.5)];
    [bezierPath addCurveToPoint: CGPointMake(151, 77) controlPoint1: CGPointMake(145.83, 80.83) controlPoint2: CGPointMake(150.6, 77.4)];
    [bezierPath addCurveToPoint: CGPointMake(155.5, 72) controlPoint1: CGPointMake(151.4, 76.6) controlPoint2: CGPointMake(154.17, 73.5)];
    [bezierPath addLineToPoint: CGPointMake(157.5, 67.5)];
    [bezierPath moveToPoint: CGPointMake(97.5, 108.5)];
    [bezierPath addLineToPoint: CGPointMake(102, 109.5)];
    [bezierPath addLineToPoint: CGPointMake(109.5, 109.5)];
    [bezierPath addLineToPoint: CGPointMake(117.5, 108.5)];
    [bezierPath addLineToPoint: CGPointMake(124.5, 107)];
    [bezierPath addLineToPoint: CGPointMake(133, 105)];
    [bezierPath moveToPoint: CGPointMake(103, 128)];
    [bezierPath addCurveToPoint: CGPointMake(107, 127.5) controlPoint1: CGPointMake(103.4, 128) controlPoint2: CGPointMake(105.83, 127.67)];
    [bezierPath addLineToPoint: CGPointMake(111.5, 127)];
    [bezierPath addLineToPoint: CGPointMake(115.5, 126)];
    [bezierPath moveToPoint: CGPointMake(94.5, 127.5)];
    [bezierPath addLineToPoint: CGPointMake(87, 127)];
    [bezierPath addLineToPoint: CGPointMake(80, 124.5)];
    [bezierPath addCurveToPoint: CGPointMake(73.5, 121.5) controlPoint1: CGPointMake(78, 123.5) controlPoint2: CGPointMake(73.9, 121.5)];
    [bezierPath addCurveToPoint: CGPointMake(69, 119) controlPoint1: CGPointMake(73.1, 121.5) controlPoint2: CGPointMake(70.33, 119.83)];
    [bezierPath moveToPoint: CGPointMake(86.5, 166.5)];
    [bezierPath addLineToPoint: CGPointMake(78.5, 165)];
    [bezierPath addLineToPoint: CGPointMake(69.5, 161.5)];
    [bezierPath addLineToPoint: CGPointMake(60.5, 156)];
    [bezierPath moveToPoint: CGPointMake(106.5, 166.5)];
    [bezierPath addLineToPoint: CGPointMake(112, 166.5)];
    [bezierPath addLineToPoint: CGPointMake(116.5, 166)];
    [bezierPath addLineToPoint: CGPointMake(125.5, 164.5)];
    [bezierPath addLineToPoint: CGPointMake(136, 162)];
    [bezierPath addLineToPoint: CGPointMake(145.5, 159.5)];
    [bezierPath addLineToPoint: CGPointMake(155, 156.5)];
    [bezierPath addLineToPoint: CGPointMake(164.5, 153.5)];
    [bezierPath addLineToPoint: CGPointMake(174.5, 149)];
    [bezierPath addLineToPoint: CGPointMake(184, 144.5)];
    [bezierPath addLineToPoint: CGPointMake(192, 139.5)];
    [bezierPath addLineToPoint: CGPointMake(198, 135.5)];
    [bezierPath addLineToPoint: CGPointMake(203.5, 132)];
    [bezierPath moveToPoint: CGPointMake(212, 124)];
    [bezierPath addLineToPoint: CGPointMake(216, 119)];
    [bezierPath addLineToPoint: CGPointMake(219.5, 113)];
    [bezierPath addLineToPoint: CGPointMake(222.5, 105.5)];
    [bezierPath moveToPoint: CGPointMake(125.5, 145)];
    [bezierPath addLineToPoint: CGPointMake(133.5, 143)];
    [bezierPath addLineToPoint: CGPointMake(146.5, 139)];
    [bezierPath addLineToPoint: CGPointMake(155, 136)];
    [bezierPath addLineToPoint: CGPointMake(164, 132)];
    [bezierPath addLineToPoint: CGPointMake(171.5, 128.5)];
    [bezierPath addLineToPoint: CGPointMake(178, 125)];
    [bezierPath moveToPoint: CGPointMake(86.5, 184)];
    [bezierPath addLineToPoint: CGPointMake(93.5, 184.5)];
    [bezierPath addLineToPoint: CGPointMake(101, 184.5)];
    [bezierPath addLineToPoint: CGPointMake(109, 183.5)];
    [bezierPath moveToPoint: CGPointMake(190.5, 159.5)];
    [bezierPath addLineToPoint: CGPointMake(196.5, 157.5)];
    [bezierPath addLineToPoint: CGPointMake(204, 153)];
    [bezierPath addLineToPoint: CGPointMake(213, 146)];
    [bezierPath addLineToPoint: CGPointMake(219, 141.5)];
    [bezierPath addLineToPoint: CGPointMake(223, 137)];
    [bezierPath moveToPoint: CGPointMake(167, 213.5)];
    [bezierPath addLineToPoint: CGPointMake(171.5, 212.5)];
    [bezierPath addLineToPoint: CGPointMake(180.5, 209)];
    [bezierPath addLineToPoint: CGPointMake(188.5, 205.5)];
    [bezierPath addLineToPoint: CGPointMake(195, 202.5)];
    [bezierPath addLineToPoint: CGPointMake(201, 199.5)];
    [bezierPath addLineToPoint: CGPointMake(203.5, 196.5)];
    [bezierPath moveToPoint: CGPointMake(208.5, 209)];
    [bezierPath addLineToPoint: CGPointMake(214.5, 205.5)];
    [bezierPath addLineToPoint: CGPointMake(220, 201.5)];
    [bezierPath addLineToPoint: CGPointMake(227.5, 194)];
    [bezierPath moveToPoint: CGPointMake(198, 215)];
    [bezierPath addLineToPoint: CGPointMake(190.5, 218.5)];
    [bezierPath addLineToPoint: CGPointMake(180, 222.5)];
    [bezierPath addLineToPoint: CGPointMake(170, 226)];
    [bezierPath addLineToPoint: CGPointMake(159, 229)];
    [bezierPath addLineToPoint: CGPointMake(148.5, 231.5)];
    [bezierPath addLineToPoint: CGPointMake(134.5, 233)];
    [bezierPath addLineToPoint: CGPointMake(121, 233.5)];
    [bezierPath addLineToPoint: CGPointMake(109.5, 233)];
    
    layer.path = bezierPath.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)planet2 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:1];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(60.5, 154)];
    [bezier2Path addLineToPoint: CGPointMake(51.5, 158)];
    [bezier2Path addLineToPoint: CGPointMake(42.5, 165)];
    [bezier2Path addLineToPoint: CGPointMake(34, 173)];
    [bezier2Path addLineToPoint: CGPointMake(28, 181)];
    [bezier2Path addLineToPoint: CGPointMake(26, 189)];
    [bezier2Path addLineToPoint: CGPointMake(27, 197)];
    [bezier2Path addLineToPoint: CGPointMake(31, 203.5)];
    [bezier2Path addLineToPoint: CGPointMake(38, 209)];
    [bezier2Path addLineToPoint: CGPointMake(48.5, 213.5)];
    [bezier2Path addLineToPoint: CGPointMake(59.5, 216)];
    [bezier2Path addLineToPoint: CGPointMake(71, 217)];
    [bezier2Path addLineToPoint: CGPointMake(82, 217.5)];
    [bezier2Path addLineToPoint: CGPointMake(88.5, 217.3)];
    [bezier2Path moveToPoint: CGPointMake(60.5, 154)];
    [bezier2Path addLineToPoint: CGPointMake(61, 147)];
    [bezier2Path addLineToPoint: CGPointMake(63.5, 134.5)];
    [bezier2Path addLineToPoint: CGPointMake(67, 124)];
    [bezier2Path addLineToPoint: CGPointMake(71.5, 112.5)];
    [bezier2Path addLineToPoint: CGPointMake(77, 104)];
    [bezier2Path addLineToPoint: CGPointMake(84, 94.5)];
    [bezier2Path addLineToPoint: CGPointMake(92, 87)];
    [bezier2Path addLineToPoint: CGPointMake(100, 81.5)];
    [bezier2Path addLineToPoint: CGPointMake(108.5, 76.5)];
    [bezier2Path addCurveToPoint: CGPointMake(120, 71.5) controlPoint1: CGPointMake(112.17, 75) controlPoint2: CGPointMake(119.6, 71.9)];
    [bezier2Path addCurveToPoint: CGPointMake(131, 68) controlPoint1: CGPointMake(120.4, 71.1) controlPoint2: CGPointMake(127.5, 69)];
    [bezier2Path addLineToPoint: CGPointMake(147.5, 66.5)];
    [bezier2Path addLineToPoint: CGPointMake(161.5, 67.5)];
    [bezier2Path addLineToPoint: CGPointMake(175.5, 70)];
    [bezier2Path addLineToPoint: CGPointMake(188, 75)];
    [bezier2Path addLineToPoint: CGPointMake(200, 82.5)];
    [bezier2Path addLineToPoint: CGPointMake(208.5, 89.5)];
    [bezier2Path addLineToPoint: CGPointMake(215.5, 96.5)];
    [bezier2Path addLineToPoint: CGPointMake(221.5, 103.5)];
    [bezier2Path moveToPoint: CGPointMake(60.5, 154)];
    [bezier2Path addLineToPoint: CGPointMake(60.5, 160.5)];
    [bezier2Path addLineToPoint: CGPointMake(61.5, 168)];
    [bezier2Path moveToPoint: CGPointMake(221.5, 103.5)];
    [bezier2Path addLineToPoint: CGPointMake(230.5, 102)];
    [bezier2Path addLineToPoint: CGPointMake(242.5, 101.5)];
    [bezier2Path addLineToPoint: CGPointMake(254, 103)];
    [bezier2Path addLineToPoint: CGPointMake(264.5, 107)];
    [bezier2Path addLineToPoint: CGPointMake(271.5, 112.5)];
    [bezier2Path addLineToPoint: CGPointMake(274, 120)];
    [bezier2Path addLineToPoint: CGPointMake(273.5, 129)];
    [bezier2Path addLineToPoint: CGPointMake(270, 137.5)];
    [bezier2Path addLineToPoint: CGPointMake(259.5, 151)];
    [bezier2Path addLineToPoint: CGPointMake(251, 159.5)];
    [bezier2Path addLineToPoint: CGPointMake(238, 169.5)];
    [bezier2Path addLineToPoint: CGPointMake(234.67, 171.5)];
    [bezier2Path moveToPoint: CGPointMake(221.5, 103.5)];
    [bezier2Path addLineToPoint: CGPointMake(225, 108.5)];
    [bezier2Path addLineToPoint: CGPointMake(228, 115)];
    [bezier2Path moveToPoint: CGPointMake(61.5, 168)];
    [bezier2Path addLineToPoint: CGPointMake(57.5, 170.5)];
    [bezier2Path addLineToPoint: CGPointMake(54, 175)];
    [bezier2Path addLineToPoint: CGPointMake(52.5, 180)];
    [bezier2Path addLineToPoint: CGPointMake(53, 185)];
    [bezier2Path addLineToPoint: CGPointMake(55.5, 189)];
    [bezier2Path addLineToPoint: CGPointMake(60.5, 192)];
    [bezier2Path addLineToPoint: CGPointMake(68, 195)];
    [bezier2Path addLineToPoint: CGPointMake(70.5, 195.47)];
    [bezier2Path moveToPoint: CGPointMake(61.5, 168)];
    [bezier2Path addLineToPoint: CGPointMake(64, 176.5)];
    [bezier2Path addLineToPoint: CGPointMake(66.5, 185)];
    [bezier2Path addLineToPoint: CGPointMake(70.5, 195.47)];
    [bezier2Path moveToPoint: CGPointMake(228, 115)];
    [bezier2Path addLineToPoint: CGPointMake(234.5, 115)];
    [bezier2Path addLineToPoint: CGPointMake(242.5, 118)];
    [bezier2Path addLineToPoint: CGPointMake(245.5, 122)];
    [bezier2Path addLineToPoint: CGPointMake(246, 128)];
    [bezier2Path addLineToPoint: CGPointMake(244.5, 133.5)];
    [bezier2Path addLineToPoint: CGPointMake(240.5, 139)];
    [bezier2Path addLineToPoint: CGPointMake(236.83, 143)];
    [bezier2Path moveToPoint: CGPointMake(228, 115)];
    [bezier2Path addLineToPoint: CGPointMake(231, 122)];
    [bezier2Path addLineToPoint: CGPointMake(234.67, 133.5)];
    [bezier2Path addLineToPoint: CGPointMake(236.83, 143)];
    [bezier2Path moveToPoint: CGPointMake(88.5, 217.3)];
    [bezier2Path addLineToPoint: CGPointMake(98.5, 217)];
    [bezier2Path addLineToPoint: CGPointMake(119.5, 214.5)];
    [bezier2Path addLineToPoint: CGPointMake(137, 211)];
    [bezier2Path addLineToPoint: CGPointMake(152.5, 207)];
    [bezier2Path addLineToPoint: CGPointMake(172, 201)];
    [bezier2Path addLineToPoint: CGPointMake(191.5, 193.5)];
    [bezier2Path addLineToPoint: CGPointMake(207, 186.5)];
    [bezier2Path addLineToPoint: CGPointMake(223, 178.5)];
    [bezier2Path addLineToPoint: CGPointMake(234.67, 171.5)];
    [bezier2Path moveToPoint: CGPointMake(88.5, 217.3)];
    [bezier2Path addLineToPoint: CGPointMake(93.5, 223)];
    [bezier2Path addLineToPoint: CGPointMake(101.5, 229)];
    [bezier2Path addLineToPoint: CGPointMake(110.5, 233.5)];
    [bezier2Path addLineToPoint: CGPointMake(119.5, 237)];
    [bezier2Path addLineToPoint: CGPointMake(130.5, 240.5)];
    [bezier2Path addLineToPoint: CGPointMake(143, 242.5)];
    [bezier2Path addLineToPoint: CGPointMake(155, 242.5)];
    [bezier2Path addLineToPoint: CGPointMake(166, 241.5)];
    [bezier2Path addLineToPoint: CGPointMake(175.5, 239)];
    [bezier2Path addLineToPoint: CGPointMake(183, 236)];
    [bezier2Path addLineToPoint: CGPointMake(192.5, 231.5)];
    [bezier2Path addLineToPoint: CGPointMake(200, 226.5)];
    [bezier2Path addLineToPoint: CGPointMake(206, 222)];
    [bezier2Path addLineToPoint: CGPointMake(214, 213.5)];
    [bezier2Path addLineToPoint: CGPointMake(222, 203.5)];
    [bezier2Path addLineToPoint: CGPointMake(227.5, 194)];
    [bezier2Path addLineToPoint: CGPointMake(232.5, 182)];
    [bezier2Path addLineToPoint: CGPointMake(234.67, 171.5)];
    [bezier2Path moveToPoint: CGPointMake(236.83, 143)];
    [bezier2Path addLineToPoint: CGPointMake(235, 145)];
    [bezier2Path addLineToPoint: CGPointMake(230, 150)];
    [bezier2Path addLineToPoint: CGPointMake(224, 154.5)];
    [bezier2Path addLineToPoint: CGPointMake(216.5, 159.5)];
    [bezier2Path addLineToPoint: CGPointMake(209.5, 164)];
    [bezier2Path addLineToPoint: CGPointMake(202.5, 168)];
    [bezier2Path addLineToPoint: CGPointMake(195.5, 171.5)];
    [bezier2Path addLineToPoint: CGPointMake(186.5, 176)];
    [bezier2Path addLineToPoint: CGPointMake(175, 181)];
    [bezier2Path addLineToPoint: CGPointMake(163.5, 185)];
    [bezier2Path addLineToPoint: CGPointMake(151.5, 188.5)];
    [bezier2Path addLineToPoint: CGPointMake(140, 191.5)];
    [bezier2Path addLineToPoint: CGPointMake(128, 194)];
    [bezier2Path addLineToPoint: CGPointMake(116, 196)];
    [bezier2Path addLineToPoint: CGPointMake(104, 197)];
    [bezier2Path addLineToPoint: CGPointMake(92.5, 197.5)];
    [bezier2Path addLineToPoint: CGPointMake(83.5, 197)];
    [bezier2Path addLineToPoint: CGPointMake(76, 196.5)];
    [bezier2Path addLineToPoint: CGPointMake(70.5, 195.47)];

    
    layer.path = bezier2Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)planet3 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:2];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(252.5, 181)];
    [bezier3Path addLineToPoint: CGPointMake(257.5, 177.5)];
    [bezier3Path addLineToPoint: CGPointMake(264.5, 178)];
    [bezier3Path addLineToPoint: CGPointMake(269, 181.5)];
    [bezier3Path addLineToPoint: CGPointMake(270.5, 186.5)];
    [bezier3Path addLineToPoint: CGPointMake(269.5, 191)];
    [bezier3Path addLineToPoint: CGPointMake(266.5, 195.5)];
    [bezier3Path addLineToPoint: CGPointMake(261.5, 197)];
    [bezier3Path addLineToPoint: CGPointMake(255.5, 196)];
    [bezier3Path addLineToPoint: CGPointMake(251.5, 192)];
    [bezier3Path addLineToPoint: CGPointMake(250, 187)];
    [bezier3Path addLineToPoint: CGPointMake(252.5, 181)];
    
    [bezier3Path moveToPoint: CGPointMake(240, 211)];
    [bezier3Path addLineToPoint: CGPointMake(242, 209)];
    [bezier3Path addLineToPoint: CGPointMake(244.5, 209)];
    [bezier3Path addLineToPoint: CGPointMake(246.5, 210.5)];
    [bezier3Path addLineToPoint: CGPointMake(247, 213)];
    [bezier3Path addLineToPoint: CGPointMake(246, 215)];
    [bezier3Path addLineToPoint: CGPointMake(243.5, 216)];
    [bezier3Path addLineToPoint: CGPointMake(241, 215.5)];
    [bezier3Path addLineToPoint: CGPointMake(239.5, 213.5)];
    [bezier3Path addLineToPoint: CGPointMake(240, 211)];

    [bezier3Path moveToPoint: CGPointMake(74.5, 242)];
    [bezier3Path addLineToPoint: CGPointMake(76.5, 241)];
    [bezier3Path addLineToPoint: CGPointMake(79.5, 242)];
    [bezier3Path addCurveToPoint: CGPointMake(81, 244.5) controlPoint1: CGPointMake(80, 242.67) controlPoint2: CGPointMake(81, 244.1)];
    [bezier3Path addCurveToPoint: CGPointMake(81, 247.5) controlPoint1: CGPointMake(81, 244.9) controlPoint2: CGPointMake(81.17, 246.83)];
    [bezier3Path addLineToPoint: CGPointMake(78.5, 249)];
    [bezier3Path addLineToPoint: CGPointMake(75, 249)];
    [bezier3Path addLineToPoint: CGPointMake(73.5, 247)];
    [bezier3Path addLineToPoint: CGPointMake(73, 244.5)];
    [bezier3Path addLineToPoint: CGPointMake(74.5, 242)];
    
    [bezier3Path moveToPoint: CGPointMake(35.5, 76.5)];
    [bezier3Path addCurveToPoint: CGPointMake(41.5, 72) controlPoint1: CGPointMake(37.33, 75) controlPoint2: CGPointMake(41.1, 72)];
    [bezier3Path addLineToPoint: CGPointMake(48, 71)];
    [bezier3Path addLineToPoint: CGPointMake(54.5, 73)];
    [bezier3Path addLineToPoint: CGPointMake(60.5, 80)];
    [bezier3Path addLineToPoint: CGPointMake(61, 89.5)];
    [bezier3Path addLineToPoint: CGPointMake(57, 97)];
    [bezier3Path addLineToPoint: CGPointMake(48.5, 101)];
    [bezier3Path addLineToPoint: CGPointMake(39.5, 99)];
    [bezier3Path addLineToPoint: CGPointMake(33.5, 94.5)];
    [bezier3Path addLineToPoint: CGPointMake(31.5, 85.5)];
    [bezier3Path addLineToPoint: CGPointMake(35.5, 76.5)];
    
    [bezier3Path moveToPoint: CGPointMake(217, 51)];
    [bezier3Path addCurveToPoint: CGPointMake(222.5, 50) controlPoint1: CGPointMake(218, 50.67) controlPoint2: CGPointMake(222.1, 50)];
    [bezier3Path addLineToPoint: CGPointMake(227, 53)];
    [bezier3Path addLineToPoint: CGPointMake(227.5, 58)];
    [bezier3Path addLineToPoint: CGPointMake(225.5, 62)];
    [bezier3Path addLineToPoint: CGPointMake(220.5, 63.5)];
    [bezier3Path addLineToPoint: CGPointMake(215.5, 61)];
    [bezier3Path addLineToPoint: CGPointMake(214, 55.5)];
    [bezier3Path addLineToPoint: CGPointMake(217, 51)];

    
    layer.path = bezier3Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (CGColorRef)getColor:(NSInteger)index {
    
    if (self.selectedColors.count < (index + 1))
        return UIColor.blackColor.CGColor;
    else
        return self.selectedColors[index].layer.sublayers[0].backgroundColor;
}

- (void)landScape1 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    
    layer.strokeColor = [self getColor:0];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(103.5, 153)];
    [bezierPath addLineToPoint: CGPointMake(105.5, 159.5)];
    [bezierPath addLineToPoint: CGPointMake(106.5, 170.5)];
    [bezierPath addLineToPoint: CGPointMake(104, 189)];
    [bezierPath addLineToPoint: CGPointMake(100.5, 206.5)];
    [bezierPath addLineToPoint: CGPointMake(101, 216)];
    [bezierPath addLineToPoint: CGPointMake(104, 224)];
    [bezierPath moveToPoint: CGPointMake(108.5, 224)];
    [bezierPath addLineToPoint: CGPointMake(109.5, 212.5)];
    [bezierPath moveToPoint: CGPointMake(110.5, 208.5)];
    [bezierPath addLineToPoint: CGPointMake(109.5, 196.5)];
    [bezierPath addLineToPoint: CGPointMake(108.5, 188.5)];
    [bezierPath addLineToPoint: CGPointMake(107.5, 181)];
    [bezierPath moveToPoint: CGPointMake(116, 175.5)];
    [bezierPath addLineToPoint: CGPointMake(118, 183.5)];
    [bezierPath addLineToPoint: CGPointMake(119.5, 194)];
    [bezierPath moveToPoint: CGPointMake(121, 184.5)];
    [bezierPath addLineToPoint: CGPointMake(121.5, 190.5)];
    [bezierPath addLineToPoint: CGPointMake(124, 199.5)];
    [bezierPath addLineToPoint: CGPointMake(126.5, 205.5)];
    [bezierPath moveToPoint: CGPointMake(125, 194)];
    [bezierPath addLineToPoint: CGPointMake(125.5, 198.5)];
    [bezierPath addLineToPoint: CGPointMake(129, 204.5)];
    [bezierPath moveToPoint: CGPointMake(138, 182)];
    [bezierPath addLineToPoint: CGPointMake(139, 189)];
    [bezierPath addLineToPoint: CGPointMake(140.5, 196)];
    [bezierPath addLineToPoint: CGPointMake(143, 201.5)];
    [bezierPath moveToPoint: CGPointMake(146.5, 203)];
    [bezierPath addLineToPoint: CGPointMake(143.5, 197)];
    [bezierPath addLineToPoint: CGPointMake(142, 192)];
    [bezierPath addLineToPoint: CGPointMake(141.5, 187)];
    [bezierPath moveToPoint: CGPointMake(139, 196)];
    [bezierPath addLineToPoint: CGPointMake(137, 190)];
    [bezierPath addLineToPoint: CGPointMake(136, 184)];
    [bezierPath addLineToPoint: CGPointMake(135.5, 176)];
    [bezierPath addLineToPoint: CGPointMake(136, 169)];
    [bezierPath moveToPoint: CGPointMake(79, 158.5)];
    [bezierPath addLineToPoint: CGPointMake(76.5, 166)];
    [bezierPath addLineToPoint: CGPointMake(75.5, 173)];
    [bezierPath addLineToPoint: CGPointMake(75.5, 181)];
    [bezierPath moveToPoint: CGPointMake(73.5, 175.5)];
    [bezierPath addLineToPoint: CGPointMake(74, 167.5)];
    [bezierPath addLineToPoint: CGPointMake(76.5, 158.5)];
    [bezierPath addLineToPoint: CGPointMake(80, 151)];
    [bezierPath moveToPoint: CGPointMake(82.5, 140)];
    [bezierPath addLineToPoint: CGPointMake(78.5, 146)];
    [bezierPath addLineToPoint: CGPointMake(75.5, 152)];
    [bezierPath moveToPoint: CGPointMake(38.5, 181)];
    [bezierPath addLineToPoint: CGPointMake(36.5, 189)];
    [bezierPath addLineToPoint: CGPointMake(33.5, 196.5)];
    [bezierPath addLineToPoint: CGPointMake(30.5, 202)];
    [bezierPath moveToPoint: CGPointMake(41.5, 181)];
    [bezierPath addLineToPoint: CGPointMake(39.5, 188.5)];
    [bezierPath addLineToPoint: CGPointMake(36, 197.5)];
    [bezierPath moveToPoint: CGPointMake(43, 173)];
    [bezierPath addLineToPoint: CGPointMake(42, 178.5)];
    [bezierPath moveToPoint: CGPointMake(56.5, 159.5)];
    [bezierPath addLineToPoint: CGPointMake(54, 169)];
    [bezierPath moveToPoint: CGPointMake(55.5, 172)];
    [bezierPath addLineToPoint: CGPointMake(54, 178.5)];
    [bezierPath addLineToPoint: CGPointMake(53.5, 186)];
    [bezierPath moveToPoint: CGPointMake(52.5, 174.5)];
    [bezierPath addLineToPoint: CGPointMake(51.5, 184)];
    [bezierPath moveToPoint: CGPointMake(62.5, 187)];
    [bezierPath addLineToPoint: CGPointMake(63, 193)];
    [bezierPath moveToPoint: CGPointMake(64.5, 194)];
    [bezierPath addLineToPoint: CGPointMake(64.5, 208.5)];
    [bezierPath moveToPoint: CGPointMake(80, 174.5)];
    [bezierPath addLineToPoint: CGPointMake(80.5, 185.5)];
    [bezierPath addLineToPoint: CGPointMake(81.5, 194)];
    [bezierPath moveToPoint: CGPointMake(191.5, 141)];
    [bezierPath addLineToPoint: CGPointMake(192, 145.5)];
    [bezierPath addLineToPoint: CGPointMake(194.5, 152)];
    [bezierPath addLineToPoint: CGPointMake(195.04, 154.5)];
    [bezierPath moveToPoint: CGPointMake(194.5, 166.5)];
    [bezierPath addLineToPoint: CGPointMake(196, 159)];
    [bezierPath addLineToPoint: CGPointMake(195.04, 154.5)];
    [bezierPath moveToPoint: CGPointMake(196, 140.5)];
    [bezierPath addLineToPoint: CGPointMake(195.5, 146.5)];
    [bezierPath addLineToPoint: CGPointMake(195.04, 154.5)];
    [bezierPath moveToPoint: CGPointMake(207.5, 133.5)];
    [bezierPath addLineToPoint: CGPointMake(205.5, 141)];
    [bezierPath addLineToPoint: CGPointMake(203.5, 148.5)];
    [bezierPath moveToPoint: CGPointMake(226, 144)];
    [bezierPath addLineToPoint: CGPointMake(227.5, 153.5)];
    [bezierPath addLineToPoint: CGPointMake(233.5, 166.5)];
    [bezierPath moveToPoint: CGPointMake(205.5, 188.5)];
    [bezierPath addLineToPoint: CGPointMake(210, 196)];
    [bezierPath addLineToPoint: CGPointMake(215, 201.5)];
    [bezierPath moveToPoint: CGPointMake(203.5, 202)];
    [bezierPath addLineToPoint: CGPointMake(198, 198.5)];
    [bezierPath moveToPoint: CGPointMake(253.5, 151)];
    [bezierPath addLineToPoint: CGPointMake(253.5, 154.5)];
    [bezierPath moveToPoint: CGPointMake(258, 153.5)];
    [bezierPath addLineToPoint: CGPointMake(258, 158.5)];
    [bezierPath addLineToPoint: CGPointMake(260.5, 162.5)];
    [bezierPath moveToPoint: CGPointMake(119.5, 136)];
    [bezierPath addLineToPoint: CGPointMake(121.5, 145.5)];
    [bezierPath addLineToPoint: CGPointMake(126.5, 148.5)];
    [bezierPath addLineToPoint: CGPointMake(129, 154.5)];
    [bezierPath moveToPoint: CGPointMake(219, 116.5)];
    [bezierPath addLineToPoint: CGPointMake(221, 120)];
    [bezierPath addLineToPoint: CGPointMake(221, 124)];
    [bezierPath moveToPoint: CGPointMake(215, 122.5)];
    [bezierPath addLineToPoint: CGPointMake(213.5, 132.5)];
    [bezierPath moveToPoint: CGPointMake(223.5, 196)];
    [bezierPath addLineToPoint: CGPointMake(226, 197.5)];
    [bezierPath addLineToPoint: CGPointMake(231, 199.5)];
    [bezierPath addLineToPoint: CGPointMake(239.5, 206.5)];
    [bezierPath moveToPoint: CGPointMake(159.5, 174.5)];
    [bezierPath addLineToPoint: CGPointMake(162, 181)];
    [bezierPath addLineToPoint: CGPointMake(168.5, 188.5)];

    
    layer.path = bezierPath.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)landScape2 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:1];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(249, 134)];
    [bezier2Path addLineToPoint: CGPointMake(255.5, 143.5)];
    [bezier2Path addLineToPoint: CGPointMake(268, 156)];
    [bezier2Path addLineToPoint: CGPointMake(267, 139.5)];
    [bezier2Path addLineToPoint: CGPointMake(264.5, 124)];
    [bezier2Path addLineToPoint: CGPointMake(259.5, 110.5)];
    [bezier2Path addLineToPoint: CGPointMake(255.5, 102)];
    [bezier2Path addLineToPoint: CGPointMake(251.5, 94.5)];
    [bezier2Path addLineToPoint: CGPointMake(245.5, 86)];
    [bezier2Path addLineToPoint: CGPointMake(240.5, 85.5)];
    [bezier2Path addLineToPoint: CGPointMake(238, 85.5)];
    [bezier2Path addLineToPoint: CGPointMake(234, 86)];
    [bezier2Path addLineToPoint: CGPointMake(230, 87.5)];
    [bezier2Path addLineToPoint: CGPointMake(226.5, 85.5)];
    [bezier2Path addLineToPoint: CGPointMake(223.5, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(219.5, 85.5)];
    [bezier2Path addLineToPoint: CGPointMake(214.5, 85.5)];
    [bezier2Path addLineToPoint: CGPointMake(210, 87.5)];
    [bezier2Path addLineToPoint: CGPointMake(207, 86)];
    [bezier2Path addLineToPoint: CGPointMake(203, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(199, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(192, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(185.5, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(182.5, 86)];
    [bezier2Path addLineToPoint: CGPointMake(176, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(170, 84.5)];
    [bezier2Path addLineToPoint: CGPointMake(166, 83.5)];
    [bezier2Path addLineToPoint: CGPointMake(160.5, 85.5)];
    [bezier2Path addLineToPoint: CGPointMake(157, 83.5)];
    [bezier2Path addLineToPoint: CGPointMake(150, 83.5)];
    [bezier2Path addLineToPoint: CGPointMake(155.5, 82)];
    [bezier2Path addLineToPoint: CGPointMake(159, 79)];
    [bezier2Path addLineToPoint: CGPointMake(160.5, 77)];
    [bezier2Path addLineToPoint: CGPointMake(163.5, 74.5)];
    [bezier2Path addLineToPoint: CGPointMake(166, 71)];
    [bezier2Path addLineToPoint: CGPointMake(170, 71)];
    [bezier2Path addLineToPoint: CGPointMake(177.5, 71)];
    [bezier2Path addLineToPoint: CGPointMake(183, 71)];
    [bezier2Path addLineToPoint: CGPointMake(188, 68)];
    [bezier2Path addLineToPoint: CGPointMake(190, 64)];
    [bezier2Path addLineToPoint: CGPointMake(196.5, 63)];
    [bezier2Path addLineToPoint: CGPointMake(200, 65.5)];
    [bezier2Path addLineToPoint: CGPointMake(204, 64)];
    [bezier2Path addLineToPoint: CGPointMake(208, 65.5)];
    [bezier2Path addLineToPoint: CGPointMake(210, 61.5)];
    [bezier2Path addLineToPoint: CGPointMake(214.5, 59.5)];
    [bezier2Path addLineToPoint: CGPointMake(220.5, 59.5)];
    [bezier2Path addLineToPoint: CGPointMake(210, 52)];
    [bezier2Path addLineToPoint: CGPointMake(196.5, 44.5)];
    [bezier2Path addLineToPoint: CGPointMake(179, 37.5)];
    [bezier2Path addLineToPoint: CGPointMake(159, 33.5)];
    [bezier2Path addLineToPoint: CGPointMake(143.5, 32.5)];
    [bezier2Path addLineToPoint: CGPointMake(126.5, 33.5)];
    [bezier2Path addLineToPoint: CGPointMake(110, 36)];
    [bezier2Path addLineToPoint: CGPointMake(97, 41)];
    [bezier2Path addLineToPoint: CGPointMake(85.5, 46)];
    [bezier2Path addLineToPoint: CGPointMake(91, 49)];
    [bezier2Path addLineToPoint: CGPointMake(95, 53)];
    [bezier2Path addLineToPoint: CGPointMake(98, 58.5)];
    [bezier2Path addLineToPoint: CGPointMake(98.5, 64)];
    [bezier2Path addLineToPoint: CGPointMake(95, 72)];
    [bezier2Path addLineToPoint: CGPointMake(89.5, 77)];
    [bezier2Path addLineToPoint: CGPointMake(85.5, 79)];
    [bezier2Path addLineToPoint: CGPointMake(81, 79)];
    [bezier2Path addLineToPoint: CGPointMake(74, 76)];
    [bezier2Path addLineToPoint: CGPointMake(69, 72)];
    [bezier2Path addLineToPoint: CGPointMake(65.5, 65.5)];
    [bezier2Path addLineToPoint: CGPointMake(65.5, 59.5)];
    [bezier2Path addLineToPoint: CGPointMake(53, 70.5)];
    [bezier2Path addLineToPoint: CGPointMake(44.5, 80.5)];
    [bezier2Path addLineToPoint: CGPointMake(37, 92)];
    [bezier2Path addLineToPoint: CGPointMake(31.5, 103)];
    [bezier2Path addLineToPoint: CGPointMake(30, 109)];
    [bezier2Path addLineToPoint: CGPointMake(33.5, 109)];
    [bezier2Path addLineToPoint: CGPointMake(37, 108)];
    [bezier2Path addLineToPoint: CGPointMake(43.5, 112)];
    [bezier2Path addLineToPoint: CGPointMake(49.5, 112)];
    [bezier2Path addLineToPoint: CGPointMake(55.5, 117)];
    [bezier2Path addLineToPoint: CGPointMake(59, 116)];
    [bezier2Path addLineToPoint: CGPointMake(64, 118.5)];
    [bezier2Path addLineToPoint: CGPointMake(61.5, 119.5)];
    [bezier2Path addLineToPoint: CGPointMake(55.5, 121)];
    [bezier2Path addLineToPoint: CGPointMake(50.5, 120)];
    [bezier2Path addLineToPoint: CGPointMake(48.5, 121)];
    [bezier2Path addLineToPoint: CGPointMake(44.5, 121)];
    [bezier2Path addLineToPoint: CGPointMake(41.5, 121)];
    [bezier2Path addLineToPoint: CGPointMake(39.5, 123)];
    [bezier2Path addLineToPoint: CGPointMake(37.5, 122)];
    [bezier2Path addLineToPoint: CGPointMake(35.5, 122)];
    [bezier2Path addLineToPoint: CGPointMake(30, 119.5)];
    [bezier2Path addLineToPoint: CGPointMake(24.5, 122)];
    [bezier2Path addLineToPoint: CGPointMake(22, 130.5)];
    [bezier2Path addLineToPoint: CGPointMake(20, 156.5)];
    [bezier2Path addLineToPoint: CGPointMake(24.5, 186.5)];
    [bezier2Path addLineToPoint: CGPointMake(31.5, 179.5)];
    [bezier2Path addLineToPoint: CGPointMake(37, 175.5)];
    [bezier2Path addLineToPoint: CGPointMake(48.5, 163)];
    [bezier2Path addLineToPoint: CGPointMake(59, 151.5)];
    [bezier2Path moveToPoint: CGPointMake(249, 134)];
    [bezier2Path addLineToPoint: CGPointMake(238, 139.5)];
    [bezier2Path moveToPoint: CGPointMake(249, 134)];
    [bezier2Path addLineToPoint: CGPointMake(247.17, 143.5)];
    [bezier2Path addLineToPoint: CGPointMake(247.17, 155)];
    [bezier2Path moveToPoint: CGPointMake(238, 139.5)];
    [bezier2Path addLineToPoint: CGPointMake(226.5, 116)];
    [bezier2Path addLineToPoint: CGPointMake(218, 108.5)];
    [bezier2Path addLineToPoint: CGPointMake(210, 118.5)];
    [bezier2Path addLineToPoint: CGPointMake(199, 131)];
    [bezier2Path addLineToPoint: CGPointMake(194.5, 128.5)];
    [bezier2Path addLineToPoint: CGPointMake(177.5, 146.5)];
    [bezier2Path addLineToPoint: CGPointMake(163.5, 167)];
    [bezier2Path moveToPoint: CGPointMake(238, 139.5)];
    [bezier2Path addLineToPoint: CGPointMake(242, 146.5)];
    [bezier2Path addLineToPoint: CGPointMake(247.17, 155)];
    [bezier2Path moveToPoint: CGPointMake(163.5, 167)];
    [bezier2Path addLineToPoint: CGPointMake(155.5, 158)];
    [bezier2Path addLineToPoint: CGPointMake(135, 138)];
    [bezier2Path addLineToPoint: CGPointMake(127.5, 118.5)];
    [bezier2Path addLineToPoint: CGPointMake(123, 118.5)];
    [bezier2Path addLineToPoint: CGPointMake(116.5, 108.5)];
    [bezier2Path moveToPoint: CGPointMake(163.5, 167)];
    [bezier2Path addLineToPoint: CGPointMake(163.5, 169.5)];
    [bezier2Path addLineToPoint: CGPointMake(167, 173)];
    [bezier2Path addLineToPoint: CGPointMake(174.25, 180.25)];
    [bezier2Path moveToPoint: CGPointMake(116.5, 108.5)];
    [bezier2Path addLineToPoint: CGPointMake(105, 117)];
    [bezier2Path addLineToPoint: CGPointMake(101.5, 124)];
    [bezier2Path addLineToPoint: CGPointMake(90.5, 136.5)];
    [bezier2Path addLineToPoint: CGPointMake(84.5, 134)];
    [bezier2Path moveToPoint: CGPointMake(116.5, 108.5)];
    [bezier2Path addLineToPoint: CGPointMake(112.5, 116)];
    [bezier2Path addLineToPoint: CGPointMake(111, 124)];
    [bezier2Path moveToPoint: CGPointMake(84.5, 134)];
    [bezier2Path addLineToPoint: CGPointMake(69, 154)];
    [bezier2Path addLineToPoint: CGPointMake(59, 151.5)];
    [bezier2Path moveToPoint: CGPointMake(84.5, 134)];
    [bezier2Path addLineToPoint: CGPointMake(84.5, 146.5)];
    [bezier2Path addLineToPoint: CGPointMake(86.5, 158)];
    [bezier2Path moveToPoint: CGPointMake(59, 151.5)];
    [bezier2Path addLineToPoint: CGPointMake(62.5, 157.5)];
    [bezier2Path addLineToPoint: CGPointMake(64, 164.5)];
    [bezier2Path addLineToPoint: CGPointMake(64, 174)];
    [bezier2Path addLineToPoint: CGPointMake(69, 183.5)];
    [bezier2Path moveToPoint: CGPointMake(181.5, 187.5)];
    [bezier2Path addLineToPoint: CGPointMake(174.25, 180.25)];
    [bezier2Path moveToPoint: CGPointMake(258.5, 175)];
    [bezier2Path addLineToPoint: CGPointMake(249, 158)];
    [bezier2Path addLineToPoint: CGPointMake(247.17, 155)];
    [bezier2Path moveToPoint: CGPointMake(174.25, 180.25)];
    [bezier2Path addLineToPoint: CGPointMake(188, 175.5)];
    [bezier2Path addLineToPoint: CGPointMake(189.16, 177)];
    [bezier2Path moveToPoint: CGPointMake(196.5, 186.5)];
    [bezier2Path addLineToPoint: CGPointMake(189.16, 177)];
    [bezier2Path moveToPoint: CGPointMake(189.16, 177)];
    [bezier2Path addLineToPoint: CGPointMake(196.5, 174)];
    [bezier2Path addLineToPoint: CGPointMake(203, 177)];
    [bezier2Path addLineToPoint: CGPointMake(213, 183.5)];
    [bezier2Path addLineToPoint: CGPointMake(223.5, 187.5)];
    [bezier2Path addLineToPoint: CGPointMake(232, 194.5)];
    [bezier2Path addLineToPoint: CGPointMake(238, 196)];
    [bezier2Path addLineToPoint: CGPointMake(253.5, 208)];
    [bezier2Path moveToPoint: CGPointMake(108, 149)];
    [bezier2Path addLineToPoint: CGPointMake(108, 140.5)];
    [bezier2Path addLineToPoint: CGPointMake(109.5, 131)];

    
    layer.path = bezier2Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)landScape3 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:2];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(35.5, 213.5)];
    [bezier3Path addLineToPoint: CGPointMake(50, 213.5)];
    [bezier3Path addLineToPoint: CGPointMake(64, 210)];
    [bezier3Path addLineToPoint: CGPointMake(81.5, 200.5)];
    [bezier3Path addLineToPoint: CGPointMake(98.5, 195.5)];
    [bezier3Path addLineToPoint: CGPointMake(114.5, 202)];
    [bezier3Path addLineToPoint: CGPointMake(127.25, 207.75)];
    [bezier3Path moveToPoint: CGPointMake(140, 213.5)];
    [bezier3Path addLineToPoint: CGPointMake(127.25, 207.75)];
    [bezier3Path moveToPoint: CGPointMake(127.25, 207.75)];
    [bezier3Path addLineToPoint: CGPointMake(140, 204)];
    [bezier3Path addLineToPoint: CGPointMake(150, 205.5)];
    [bezier3Path addLineToPoint: CGPointMake(159.5, 207.75)];
    [bezier3Path addLineToPoint: CGPointMake(173, 210)];
    [bezier3Path addLineToPoint: CGPointMake(195, 217.5)];
    [bezier3Path moveToPoint: CGPointMake(185.5, 220)];
    [bezier3Path addLineToPoint: CGPointMake(198, 217.5)];
    [bezier3Path addLineToPoint: CGPointMake(208.5, 212)];
    [bezier3Path addLineToPoint: CGPointMake(222.5, 212)];
    [bezier3Path addLineToPoint: CGPointMake(237, 212)];
    [bezier3Path addLineToPoint: CGPointMake(257, 207.75)];
    [bezier3Path moveToPoint: CGPointMake(56.5, 241.5)];
    [bezier3Path addLineToPoint: CGPointMake(70.5, 241.5)];
    [bezier3Path addLineToPoint: CGPointMake(87.5, 238)];
    [bezier3Path addLineToPoint: CGPointMake(104.5, 241.5)];
    [bezier3Path addLineToPoint: CGPointMake(129, 244.5)];
    [bezier3Path addLineToPoint: CGPointMake(173, 249)];
    [bezier3Path moveToPoint: CGPointMake(140, 258.5)];
    [bezier3Path addLineToPoint: CGPointMake(163.5, 252.5)];
    [bezier3Path addLineToPoint: CGPointMake(185.5, 241.5)];
    [bezier3Path addLineToPoint: CGPointMake(198, 235)];
    [bezier3Path addLineToPoint: CGPointMake(216.5, 235)];
    [bezier3Path addLineToPoint: CGPointMake(238.5, 235)];
    [bezier3Path moveToPoint: CGPointMake(86, 265)];
    [bezier3Path addLineToPoint: CGPointMake(98.5, 262.5)];
    [bezier3Path addLineToPoint: CGPointMake(123, 265)];
    [bezier3Path addLineToPoint: CGPointMake(151, 266)];
    [bezier3Path addLineToPoint: CGPointMake(173, 266)];
    [bezier3Path addLineToPoint: CGPointMake(195, 258.5)];
    [bezier3Path addLineToPoint: CGPointMake(218, 256)];


    
    layer.path = bezier3Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
    
}

- (void)tree1 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:0];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(62, 248.5)];
    [bezierPath addCurveToPoint: CGPointMake(123.5, 185.5) controlPoint1: CGPointMake(81.83, 242.67) controlPoint2: CGPointMake(121.9, 221.9)];
    [bezierPath addCurveToPoint: CGPointMake(113.5, 138.5) controlPoint1: CGPointMake(125.1, 149.1) controlPoint2: CGPointMake(117.5, 139)];
    [bezierPath moveToPoint: CGPointMake(205.5, 254)];
    [bezierPath addCurveToPoint: CGPointMake(152, 225) controlPoint1: CGPointMake(187.17, 253) controlPoint2: CGPointMake(150.8, 245.8)];
    [bezierPath addCurveToPoint: CGPointMake(163, 166.5) controlPoint1: CGPointMake(153.2, 204.2) controlPoint2: CGPointMake(159.83, 177.33)];
    [bezierPath addCurveToPoint: CGPointMake(172.5, 154.5) controlPoint1: CGPointMake(165.17, 162.17) controlPoint2: CGPointMake(170.1, 153.7)];
    [bezierPath moveToPoint: CGPointMake(138.5, 163)];
    [bezierPath addCurveToPoint: CGPointMake(131, 212) controlPoint1: CGPointMake(137, 178.17) controlPoint2: CGPointMake(133.4, 209.2)];
    [bezierPath moveToPoint: CGPointMake(143.5, 237.5)];
    [bezierPath addCurveToPoint: CGPointMake(148.5, 166.5) controlPoint1: CGPointMake(143.5, 229.5) controlPoint2: CGPointMake(142.5, 181)];
    [bezierPath moveToPoint: CGPointMake(125, 205.5)];
    [bezierPath addCurveToPoint: CGPointMake(104.5, 234.5) controlPoint1: CGPointMake(112, 224.5) controlPoint2: CGPointMake(110.5, 229)];
    
    layer.path = bezierPath.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)tree2 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:1];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;
    
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(79.25, 241.25)];
    [bezier2Path addCurveToPoint: CGPointMake(45.75, 246.56) controlPoint1: CGPointMake(71.25, 232.75) controlPoint2: CGPointMake(56.15, 233.36)];
    [bezier2Path moveToPoint: CGPointMake(19.25, 252.75)];
    [bezier2Path addCurveToPoint: CGPointMake(43.25, 245.75) controlPoint1: CGPointMake(22.58, 248.92) controlPoint2: CGPointMake(32.05, 242.15)];
    [bezier2Path addCurveToPoint: CGPointMake(53.75, 249.75) controlPoint1: CGPointMake(54.45, 249.35) controlPoint2: CGPointMake(54.92, 249.92)];
    [bezier2Path moveToPoint: CGPointMake(157.75, 238.25)];
    [bezier2Path addCurveToPoint: CGPointMake(181.25, 238.25) controlPoint1: CGPointMake(162.75, 235.48) controlPoint2: CGPointMake(174.45, 231.6)];
    [bezier2Path addCurveToPoint: CGPointMake(186.49, 244.25) controlPoint1: CGPointMake(183.53, 240.48) controlPoint2: CGPointMake(185.23, 242.49)];
    [bezier2Path moveToPoint: CGPointMake(189.75, 251.25)];
    [bezier2Path addCurveToPoint: CGPointMake(186.49, 244.25) controlPoint1: CGPointMake(189.75, 250.21) controlPoint2: CGPointMake(189, 247.74)];
    [bezier2Path moveToPoint: CGPointMake(186.49, 244.25)];
    [bezier2Path addCurveToPoint: CGPointMake(221.25, 245.75) controlPoint1: CGPointMake(198.08, 241.08) controlPoint2: CGPointMake(221.25, 236.95)];
    [bezier2Path addCurveToPoint: CGPointMake(204.25, 253.75) controlPoint1: CGPointMake(221.25, 254.55) controlPoint2: CGPointMake(205.58, 252.92)];
    
    layer.path = bezier2Path.CGPath;
    
    [CATransaction begin];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];
 
    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];
     
    [self.image.layer addSublayer:layer];
}

- (void)tree3 {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.strokeColor = [self getColor:2];
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.lineWidth = 1.0;

//    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    UIBezierPath* bezier3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(89, 44, 157, 110)];

    layer.path = bezier3Path.CGPath;

    [CATransaction begin];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = self.timerSlider.value;

    [CATransaction setCompletionBlock:^{
        NSLog(@"Animation completed");
    }];

    [layer addAnimation:animation forKey:@"myStroke"];
    [CATransaction commit];

    [self.image.layer addSublayer:layer];

}

-(void)openPaletteTapped: (UIButton *)sender {
    self.paletteView.hidden = NO;
}

-(void)tapSaveColor: (UIButton *)sender {
    self.paletteView.hidden = YES;
}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(40.0, 40.0)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

-(void)openTimerTapped: (UIButton *)sender {
    self.timerView.hidden = NO;
}

-(void)tapSaveTimer: (UIButton *)sender {
    self.timerView.hidden = YES;
}

-(void)tapColor:(UIButton *)sender {
    CALayer *la = sender.layer.sublayers[0];
    if ([self.selectedColors containsObject:sender]) {
        //[CATransaction setDisableAnimations:YES];
        la.frame = CGRectMake(8, 8, 24, 24);
        //[CATransaction setDisableAnimations:NO];
        self.paletteView.layer.backgroundColor = UIColor.whiteColor.CGColor;
        [UIView animateWithDuration:1 animations:^{
            self.paletteView.layer.backgroundColor = UIColor.whiteColor.CGColor;
        }];
        [self.selectedColors removeObject:sender];
    }
    else {
        //[CATransaction setDisableAnimations:YES];
        la.frame = CGRectMake(2, 2, 36, 36);
        //[CATransaction setDisableAnimations:NO];
        self.paletteView.layer.backgroundColor = la.backgroundColor;
        [UIView animateWithDuration:1 animations:^{
            self.paletteView.layer.backgroundColor = la.backgroundColor;
        }];
        
        if (self.selectedColors.count == 3) {
            UIButton *button = self.selectedColors[0];
            button.layer.sublayers[0].frame = CGRectMake(8, 8, 24, 24);
            [self.selectedColors removeObjectAtIndex:0];
            [self.selectedColors addObject:sender];
        }
        else {
            [self.selectedColors addObject:sender];
        }
    }
    

}




@end
