//
//  CitiesTableViewController.m
//  WeatherRadar
//
//  Created by Marian on 9/7/18.
//  Copyright © 2018 Marian. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "WeatherRemoteDataSource.h"
#import "UIScrollView+EmptyDataSet.h"
#import "CitiesPresenter.h"
#import "WeatherDetailsViewController.h"
#import "CityHistoryTableViewController.h"

@interface CitiesTableViewController ()<UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<City *> *cities ;
@property (strong, nonatomic) id <CitiesPresenterProtocol> presenter;

@end

@implementation CitiesTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.presenter = [[CitiesPresenter alloc] initWithView:self];
    [self.presenter getCities];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBAction

-(IBAction)addCity:(id)sender{
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"City" message: @"Please enter city name" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"City";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * cityNamefield = textfields[0];
        NSLog(@"%@",cityNamefield.text);
        [self.presenter addCity:cityNamefield.text];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - ui setup

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)setupNavigationBarAddButton {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self  action:@selector(addCity:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)setupUI {
    [self setupTableView];
    [self setupNavigationBarAddButton];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.cities.count >0 ) {
        return self.cities.count;
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.cities objectAtIndex:indexPath.row] name];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.presenter deleteCity:[self.cities objectAtIndex:indexPath.row]];
        NSMutableArray *mutableCities = [NSMutableArray arrayWithArray:self.cities];
        [mutableCities removeObjectAtIndex:indexPath.row];
        self.cities = mutableCities;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    City *selectedCity = [self.cities objectAtIndex:indexPath.row];
    CityHistoryTableViewController *cityHistoryTableViewController = [[CityHistoryTableViewController alloc] init];
    cityHistoryTableViewController.city = selectedCity;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cityHistoryTableViewController];
    [self presentViewController:navController animated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    City *selectedCity = [self.cities objectAtIndex:indexPath.row];
    WeatherDetailsViewController *weatherDetailsViewController = [[WeatherDetailsViewController alloc] init];
    weatherDetailsViewController.city = selectedCity;
    [self.navigationController pushViewController:weatherDetailsViewController animated:YES];
}


#pragma mark - CitiesViewProtocol
- (void)showCities:(NSArray<City *> *)cities {
    self.cities = cities;
    [self.tableView reloadData];
}
-(void)showAlertWithText:(NSString*) text{
    [self showAlertWithMessage:text];
    [self.presenter getCities];
    
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = NSLocalizedString(@"EmptyCitiesTable",nil);
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


@end
