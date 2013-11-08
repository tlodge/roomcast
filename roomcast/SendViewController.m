//
//  SendViewController.m
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "SendViewController.h"

@interface SendViewController ()

@end

MessageView* aView;

@implementation SendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"am her!");
    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"Ok am initing!!");
        // Custom initialization
        self.messages = [NSMutableArray arrayWithCapacity: 20];
        Message *m = [[Message alloc] init];
        m.from = @"Tom";
        m.body = @"Hello everyone!";
        [self.messages addObject: m];
        
        m = [[Message alloc] init];
        m.from = @"Simon";
        m.body = @"Hello everyone again!!";
        [self.messages addObject: m];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"am returning %d", [self.messages count]);
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Message *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = message.from;
    cell.detailTextLabel.text = message.body;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

/*
- (IBAction)sendMessage:(id)sender {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MessageView"
                                                         owner:self
                                                       options:nil];
    //I'm assuming here that your nib's top level contains only the view
    //you want, so it's the only item in the array.
    CGRect mainframe = [[UIScreen mainScreen] bounds];
    float width = mainframe.size.width;
    float height = mainframe.size.height;
    
    aView = [nibContents objectAtIndex:0];
    [aView.testButton addTarget:self action:@selector(attemptLogin:)
               forControlEvents:UIControlEventTouchUpInside];
    
    aView.frame = CGRectMake(0,height,width,200); //or whatever coordinates you need
    [self.view addSubview:aView];
    [UIView beginAnimations:@"SwitchToMessageView" context:nil];
    [UIView setAnimationDuration:0.5];
    aView.frame = CGRectMake(0,height-250,width,200);
    [UIView commitAnimations];
    
}

-(void)attemptLogin:(UIButton *)sender{
    [aView removeFromSuperview];
}*/

@end
