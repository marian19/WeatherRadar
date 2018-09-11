//
//  CitiesTableViewController.m
//  WeatherRadar
//
//  Created by Marian on 9/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "CityHistoryTableViewController.h"
#import "WeatherRemoteDataSource.h"
#import "UIScrollView+EmptyDataSet.h"
#import "CityHistoryPresenter.h"
#import "WeatherDetailsViewController.h"
#import "NSDate+ManipulateDate.h"
#import "HistoryTableViewCell.h"

@interface CityHistoryTableViewController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<WeatherInfo *> *weatherInfoArray ;
@property (strong, nonatomic) id <CityHistoryPresenterProtocol> presenter;

@end

@implementation CityHistoryTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ Historical", self.city.name];
    self.presenter = [[CityHistoryPresenter alloc] initWithView:self];
    [self.presenter getCityHistory:self.city];
    [self setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup UI

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
        [self.tableView registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)setupNavigationBarDoneButton {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self  action:@selector(doneButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}


- (void)setupUI {
    [self setupTableView];
    [self setupNavigationBarDoneButton];
}

#pragma mark - Actions

-(void)doneButtonTapped:(UIBarButtonItem*)item{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.weatherInfoArray.count >0 ) {
        return self.weatherInfoArray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    WeatherInfo *weatherInfo = [self.weatherInfoArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [[weatherInfo date] convertToString];
    NSString *weatherString= [NSString stringWithFormat:@"%@, %@",weatherInfo.weatherDescription,[NSString stringWithFormat:@"Tempreture: %d%@", (int)weatherInfo.temp,@"\u00B0"]];
    cell.detailTextLabel.text = weatherString;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeatherInfo *selectedWeather = [self.weatherInfoArray objectAtIndex:indexPath.row];
    
    WeatherDetailsViewController *weatherDetailsViewController = [[WeatherDetailsViewController alloc] init];
    weatherDetailsViewController.weather = [[Weather alloc] initWithWeatherInfo:selectedWeather];
    [self.navigationController pushViewController:weatherDetailsViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

#pragma mark - CityHistoryViewProtocol

-(void)showAlertWithText:(NSString*) text{
    [self showAlertWithMessage:text];
    
}

- (void)showCityHistory:(NSArray<WeatherInfo *> *)weatherInfoArray {
    self.weatherInfoArray = weatherInfoArray;
    [self.tableView reloadData];
    
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = NSLocalizedString(@"NoHistory",nil);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
