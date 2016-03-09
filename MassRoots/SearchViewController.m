//
//  searchUserDisplayController.m
//  I B Lay Z
//
//  Created by Ryan on 6/11/14.
//
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "NSDictionary+github.h"
#import "Repository.h"
#import "RepositoryCell.h"



@interface SearchViewController() <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSMutableArray *repositoriesArray;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation SearchViewController

@synthesize searchResults;
@synthesize repositoriesArray;
@synthesize webView;
@synthesize userToken;

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchController.searchBar resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:59/255.0f green:152/255.0f blue:146/255.0f alpha:1.0];
    
    [self.searchController.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchController.searchBar;
    
    self.searchController.delegate = self;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES

    self.tableView.bounces = NO;
    
    repositoriesArray = [[NSMutableArray alloc]init];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Github Authenticated"
                                 message:@"Use the search bar to search repositories"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)text {
    [self filterResults:text];
}


-(void)filterResults:(NSString *)searchTerm {
    
    self.searchResults = [[NSArray alloc] init];
    [repositoriesArray removeAllObjects];
    
    if(![searchTerm  isEqual: @""] && searchTerm.length > 1)
    {
        NSString *urlStr = @"https://api.github.com/search/repositories?q=";
        urlStr = [urlStr stringByAppendingString:searchTerm];
        NSLog(@"%@", urlStr);
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *repositoriesJSON = (NSDictionary *)responseObject[@"items"];
         
            
            for (NSDictionary *repository in repositoriesJSON) {
                
                //NSDictionary *repositoryOBJ = [repository repositoryGithub];
                if(repository != nil)
                {
                    Repository *repo = [[Repository alloc] init];
                    //Repository *repo = nil;
                    if ([[repository title] isKindOfClass:[NSNull class]])
                        repo.title    =   @"Unknown";
                    else
                        repo.title = [repository title];
                    
                    if ([[repository summary] isKindOfClass:[NSNull class]])
                        repo.summary    =   @"Unknown";
                    else
                        repo.summary = [repository summary];
                    
                    if ([[repository language] isKindOfClass:[NSNull class]])
                        repo.language    =   @"Unknown";
                    else
                        repo.language = [repository language];
                    
                    if ([[repository ownerAvatar] isKindOfClass:[NSNull class]])
                        repo.ownerAvatar    =   @"Unknown";
                    else
                        repo.ownerAvatar = [repository ownerAvatar];
                    
                    if ([[repository ownerName] isKindOfClass:[NSNull class]])
                        repo.ownerName    =   @"Unknown";
                    else
                        repo.ownerName = [repository ownerName];
                    
                    if ([[repository updated] isKindOfClass:[NSNull class]])
                        repo.updated    =   @"Unknown";
                    else
                        repo.updated = [repository updated];
                    
                    if ([[repository htmlURL] isKindOfClass:[NSNull class]])
                        repo.htmlURL    =   @"Unknown";
                    else
                        repo.htmlURL = [repository htmlURL];
                    
                    [repositoriesArray addObject:repo];
                }
            }
            
            searchResults = [NSMutableArray arrayWithArray:repositoriesArray];
            [self.tableView reloadData];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        [operation start];
    }
   [self.tableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterResults:searchString];
    return YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",(long)self.searchResults.count);
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *RepositoryCellIdentifier = @"RepositoryCell";
    
    RepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:RepositoryCellIdentifier];
    if (cell == nil) {
        cell = [[RepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RepositoryCellIdentifier];
        //[cell setDelegate:self];
    }
    
    Repository *object = [self.searchResults objectAtIndex:indexPath.row];
    
    if(object != nil){
               
        //Display the title of the repository
        cell.titleLabel.text = object.title;
        //Display the Author of the repository
        cell.ownerLabel.text = [@"Author: " stringByAppendingString:object.ownerName];
        //Display the Author of the repository
        cell.updatedLabel.text = object.updated;
        
        NSData *languageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:object.language]];
        if(languageData != nil)
        {
            NSError *localError = nil;
            NSDictionary *parsedLanguage = [NSJSONSerialization JSONObjectWithData:languageData options:0 error:&localError];
            NSMutableString *languageText = [NSMutableString string];
            [languageText appendString:@"Languages: "];
            NSArray *languageValues = [parsedLanguage allKeys];
            for(NSString *key in languageValues)
            {
                [languageText appendString:key];
                if(![key isEqualToString:languageValues[parsedLanguage.count-1]])
                {
                    [languageText appendString:@", "];
                }
            }
            cell.languageLabel.text = languageText;

        }
        

        
        
        NSURLSessionTask *taskLanguages = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:object.language] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError *localError = nil;
                NSDictionary *parsedLanguage = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
                NSMutableString *languageText = [NSMutableString string];
                [languageText appendString:@"Languages: "];
                NSArray *languageValues = [parsedLanguage allKeys];
                for(NSString *key in languageValues)
                {
                    [languageText appendString:key];
                    if(![key isEqualToString:languageValues[parsedLanguage.count-1]])
                    {
                        [languageText appendString:@", "];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.languageLabel.text = languageText;
                });
                
            }
        }];
        [taskLanguages resume];

        
        
        cell.avatarImage.image = nil;
        NSURLSessionTask *taskAvatar = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:object.ownerAvatar] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.avatarImage.image = image;
                    });
                }
            }
        }];
        [taskAvatar resume];
        
        
        //Display the description of the repository
        cell.summaryLabel.text = object.summary;
        
        [cell.starRepoBtn addTarget:self action:@selector(toggleStarButton:) forControlEvents:UIControlEventTouchUpInside];
        cell.starRepoBtn.tag = indexPath.row;
        self.starBtnToggled = NO;
        
        [cell.updatedLabel sizeToFit];
        [cell.ownerLabel sizeToFit];
        [cell.languageLabel sizeToFit];
        [cell.updatedLabel sizeToFit];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Repository *object = [self.searchResults objectAtIndex:indexPath.row];
    webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:object.htmlURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    UIViewController *webViewController = [[UIViewController alloc]init];
    [webViewController.view addSubview: webView];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210.0f;
}

-(void)toggleStarButton:(id)sender {
    if (!self.starBtnToggled) {
        [sender setTitle:@"Unstar Repo" forState:UIControlStateNormal];
        self.starBtnToggled = YES;
    }
    else {
        [sender setTitle:@"Star Repo" forState:UIControlStateNormal];
        self.starBtnToggled = NO;
    }
    
    Repository *object = [self.searchResults objectAtIndex:[sender tag]];
    
    NSString *starRepoStr = [NSString stringWithFormat:@"https://api.github.com/user?%@/starred/%@/%@&Content-Length=0", userToken, object.ownerName, object.title];
    NSLog(@"%@", starRepoStr);
    
    
    NSURL *url = [NSURL URLWithString:starRepoStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Error Starring Repo"
                                             message:[error localizedDescription]
                                             preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action)
                                           {
                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                               
                                           }];
                
                [alert addAction:okButton];
                [self presentViewController:alert animated:YES completion:nil];
            });
            
        });
    }];
    
    [operation start];

    
}





@end
