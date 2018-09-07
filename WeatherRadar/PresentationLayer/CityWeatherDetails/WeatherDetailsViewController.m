//
//  WeatherDetailsViewController.m
//  WeatherRadar
//
//  Created by Marian on 9/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "WeatherDetailsViewController.h"

@interface WeatherDetailsViewController ()
    
    @property (nonatomic, strong) UILabel *detailsLabel;
    @property (nonatomic, strong) UILabel *descriptionLabel;
    @property (nonatomic, strong) UIImageView *weatherImageView;
    @property (nonatomic, strong) UILabel *tempretureLabel;
    @property (nonatomic, strong) UILabel *humidityLabel;
    @property (nonatomic, strong) UILabel *windSpeedLabel;


@end

@implementation WeatherDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.detailsLabel = [[UILabel alloc] init];
    self.detailsLabel.numberOfLines = 0;
    self.detailsLabel.text = @"jsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsjjsjsjsjsjsjsjsjsjsj";
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.text = @"descriptionLabel";
    self.tempretureLabel = [[UILabel alloc] init];
    self.tempretureLabel.text = @"tempretureLabel";
    self.humidityLabel = [[UILabel alloc] init];
    self.humidityLabel.text = @"humidityLabel";
    self.windSpeedLabel = [[UILabel alloc] init];
    self.windSpeedLabel.text = @"windSpeedLabel";
    
    [self.detailsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tempretureLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.humidityLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.detailsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.windSpeedLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addSubview:self.detailsLabel];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.tempretureLabel];
    [self.view addSubview:self.humidityLabel];
    [self.view addSubview:self.windSpeedLabel];

    NSDictionary *views = NSDictionaryOfVariableBindings(_detailsLabel, _descriptionLabel,_tempretureLabel,_humidityLabel,_windSpeedLabel);
    
    NSArray *detailsLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_detailsLabel]-20-|" options:0 metrics:nil views:views];
    NSArray *descriptionLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_descriptionLabel]-20-|" options:0 metrics:nil views:views];

    NSArray *tempretureLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_tempretureLabel]-20-|" options:0 metrics:nil views:views];

    NSArray *humidityLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_humidityLabel]-20-|" options:0 metrics:nil views:views];

    NSArray *windSpeedLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_windSpeedLabel]-20-|" options:0 metrics:nil views:views];

    NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_detailsLabel]-20-[_descriptionLabel]-20-[_tempretureLabel]-20-[_humidityLabel]-20-[_windSpeedLabel]->=20-|"  options:0 metrics:nil views:views];
    
    
    [self.view addConstraints:detailsLabelhorizontalConstraints];
    [self.view addConstraints:descriptionLabelhorizontalConstraints];
    [self.view addConstraints:tempretureLabelhorizontalConstraints];
    [self.view addConstraints:humidityLabelhorizontalConstraints];
    [self.view addConstraints:windSpeedLabelhorizontalConstraints];
    [self.view addConstraints:verticalConstraints];

//    NSLog(@"%@",[self.view constraints]);
    
    
}
    
    -(void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
