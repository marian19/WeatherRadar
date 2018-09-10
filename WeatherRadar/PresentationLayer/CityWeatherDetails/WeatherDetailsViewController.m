//
//  WeatherDetailsViewController.m
//  WeatherRadar
//
//  Created by Marian on 9/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "WeatherDetailsViewController.h"
#import "Constaints.h"
#import "NSDate+ManipulateDate.h"
#import "WeatherDetailsPresenter.h"
#import "UIImageView+Download.h"

@interface WeatherDetailsViewController ()

@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;
@property (nonatomic, strong) UILabel *tempretureLabel;
@property (nonatomic, strong) UILabel *humidityLabel;
@property (nonatomic, strong) UILabel *windSpeedLabel;
@property (strong, nonatomic) id <WeatherDetailsPresenterProtocol> presenter;

@end

@implementation WeatherDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    if (self.weather == nil) {
        self.presenter = [[WeatherDetailsPresenter alloc] initWithView:self];
        [self.presenter getWeatherDetailsforCity:self.city];
    }else{
        [self showWeatherDetails:self.weather];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup UI

- (void)createUIComponents {
    self.detailsLabel = [[UILabel alloc] init];
    self.detailsLabel.numberOfLines = 0;
    
    self.descriptionLabel = [[UILabel alloc] init];
    [self.descriptionLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    
    self.tempretureLabel = [[UILabel alloc] init];
    [self.tempretureLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    
    self.humidityLabel = [[UILabel alloc] init];
    [self.humidityLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    
    self.windSpeedLabel = [[UILabel alloc] init];
    [self.windSpeedLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    
    self.weatherImageView = [[UIImageView alloc] init];
    
    [self.detailsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tempretureLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.humidityLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.detailsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.windSpeedLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.weatherImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.detailsLabel];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.tempretureLabel];
    [self.view addSubview:self.humidityLabel];
    [self.view addSubview:self.windSpeedLabel];
    [self.view addSubview:self.weatherImageView];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_detailsLabel, _descriptionLabel,_tempretureLabel,_humidityLabel,_windSpeedLabel,_weatherImageView);
    
    NSArray *detailsLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_detailsLabel]-20-|" options:0 metrics:nil views:views];
    NSArray *descriptionLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_weatherImageView(70)]-20-[_descriptionLabel]-20-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    
    NSArray *tempretureLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_tempretureLabel]-20-|" options:0 metrics:nil views:views];
    
    NSArray *humidityLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_humidityLabel]-20-|" options:0 metrics:nil views:views];
    
    NSArray *windSpeedLabelhorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_windSpeedLabel]-20-|" options:0 metrics:nil views:views];
    
    NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[_detailsLabel]-20-[_weatherImageView(70)]-20-[_tempretureLabel]-20-[_humidityLabel]-20-[_windSpeedLabel]->=20-|"  options:0 metrics:nil views:views];
    
    
    [self.view addConstraints:detailsLabelhorizontalConstraints];
    [self.view addConstraints:descriptionLabelhorizontalConstraints];
    [self.view addConstraints:tempretureLabelhorizontalConstraints];
    [self.view addConstraints:humidityLabelhorizontalConstraints];
    [self.view addConstraints:windSpeedLabelhorizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

- (void)setupUI {
    
    if (self.weather == nil) {
        self.navigationItem.title = self.city.name;
    }else{
        self.navigationItem.title = self.weather.city;
    }
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self createUIComponents];
    
    [self setupConstraints];
}

#pragma mark - WeatherDetailsViewProtocol

- (void)showAlertWithText:(NSString *)text {
    [self showAlertWithMessage:text];
}

- (void)showWeatherDetails:(Weather *)weatherDetails {
    self.weather = weatherDetails;
    NSString *cityName = nil;
    if (self.weather == nil) {
        cityName = self.city.name;
        
    }else{
        cityName = self.weather.city;
    }
    self.detailsLabel.text = [NSString stringWithFormat:kDetailsString,cityName, [weatherDetails.date convertToString]];
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@", weatherDetails.weatherDescription] ;
    self.tempretureLabel.text = [NSString stringWithFormat:@"Tempreture: %d%@", (int)weatherDetails.temp,@"\u00B0"];
    self.humidityLabel.text = [NSString stringWithFormat:@"Humidity: %d%%",(int)weatherDetails.humidity];
    self.windSpeedLabel.text =[NSString stringWithFormat:@"Wind Speed: %.1f kmh",weatherDetails.windSpeed];
    [self.weatherImageView setImageFromIcon:weatherDetails.icon];
}


@end
