//
//  NotificationViewController.m
//  roomcast
//
//  Created by Tom Lodge on 22/03/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()
-(void) recalculateBadge;
-(unsigned long) colourForName:(NSString *) name;
@end

@implementation NotificationViewController

@synthesize notifications;
NSManagedObjectContext *context;
//unsigned long colours[5] = {0x839973,0xaac390,0xd48037,0xbe885a,0x201f1f};

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //need to pull this from server...
    self.colours = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithLong:0x839973],[NSNumber numberWithLong:0xaac390],[NSNumber numberWithLong:0xd48037],[NSNumber numberWithLong:0xbe885a],[NSNumber numberWithLong:0x201f1f]] forKeys:@[@"security",@"maintenance",@"concierge",@"cleaner",@"feedback"]];
    
    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"dd MMM HH:mm"];
    [self setupRefreshControl];
    
    id delegate = [[UIApplication sharedApplication] delegate];
    context = [delegate managedObjectContext];

    self.notifications = [[DataManager sharedManager] notificationsForUser];
    [self recalculateBadge];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"notificationsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.notifications = [[DataManager sharedManager] notificationsForUser];
        
        [self recalculateBadge];
        [self.tableView reloadData];
        
    }];
}

-(void) recalculateBadge{
    int unread = 0;
    
    for (int i =0; i < [self.notifications count]; i++){
        Notification *n = [notifications objectAtIndex:i];
        if (n.read == nil){
            unread +=1;
        }
    }
    
    if (unread > 0){
        [[self navigationController] tabBarItem].badgeValue = [NSString stringWithFormat:@"%d",unread];
    }else{
          [[self navigationController] tabBarItem].badgeValue = nil;
    }
}

-(void) setupRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlRequest) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating..." attributes:nil];
     
    [self setRefreshControl:self.refreshControl];
}

-(void) refreshControlRequest{
    self.notifications = [[DataManager sharedManager] notificationsForUser];
    [self.refreshControl endRefreshing];
    [self recalculateBadge];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Notification *n = [notifications objectAtIndex:indexPath.row];
    
    if (n.read == nil){
        n.read = [NSDate date];
        NSError *derror;
        [context save:&derror];
        
        NSLog(@"saving %@", n);
        
        if (derror){
            NSLog(@"error updating notification %@", derror);
        }else{
            NSLog(@"successfully updated the notificatioN!");
        }
    }
    [self recalculateBadge];
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Notification *n = [notifications objectAtIndex:indexPath.row];
    
    NotificationCell *cell = nil;
    

    if ([n.type isEqualToString:@"feedback"]){
        cell = (FeedbackCell*) [tableView dequeueReusableCellWithIdentifier:@"FeedbackCell" forIndexPath:indexPath];
         cell.fromImage.image = [UIImage imageNamed:@"notification_feedback.png"];
        unsigned long colour = [self colourForName:@"feedback"];
        [cell.fromView setFillColor: UIColorFromRGB(colour)];
    }else{
        cell = (NotificationCell*) [tableView dequeueReusableCellWithIdentifier:@"NotificationCell" forIndexPath:indexPath];
        
        unsigned long colour = [self colourForName:n.from];
        
        cell.fromImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"notification_%@.png", n.from]];
        [cell.fromView setFillColor: UIColorFromRGB(colour)];
        [cell.fromView setNeedsDisplay];
    }
       
        
    if ([n.priority intValue] > 0){
        cell.backgroundColor = UIColorFromRGB(0xa02c2c);
        cell.fromLabel.textColor = [UIColor whiteColor];
        cell.messageLabel.textColor = [UIColor whiteColor];
        cell.dateLabel.textColor = [UIColor whiteColor];
    }
    if (n.read == nil){
        cell.readLabel.text = @"new";
    }else{
         cell.readLabel.text = @"";
    }
    
    cell.fromLabel.text = n.from;
    cell.messageLabel.text = n.message;
    cell.dateLabel.text = [self.formatter stringFromDate:n.lastUpdate];
    
    return cell;
}

-(unsigned long) colourForName:(NSString*)name{
    
    NSNumber* colour = [self.colours objectForKey:name];
    if (colour){
        return [colour longValue];
    }else{
        return 0x201f1f;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74.0;
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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    Notification *n = [notifications objectAtIndex:path.row];
    
    RootFeedbackController* fc = (RootFeedbackController*) [segue destinationViewController];
    
    fc.notificationId = n.objectId;
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
