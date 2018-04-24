//
//  ViewController.m
//  sdkmobile_example
//
//  Created by user on 14.03.18.
//  Copyright © 2018 mtt. All rights reserved.
//

#import "NumberDialViewController.h"
#import "CallClientWrapper.h"

@implementation NumberDialViewController {
    NSMutableArray * calls;
    NSMutableArray * calls_onhold;
}

-(void)callReceived:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
    [calls addObject:call];
    [tvCalls reloadData];
}

-(void)callTrying:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
    [calls addObject:call];
    [tvCalls reloadData];
}

-(void)callEstablished:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
}

-(void)callPaused:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
    [calls_onhold addObject:call];
    [tvCalls reloadData];
}

-(void)callResuming:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
    [calls_onhold removeObject:call];
    [tvCalls reloadData];
}

-(void)callResumed:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
}

-(void)callError:(Call*)call callError:(CallError)error {
    NSLog(@"%s", __FUNCTION__);
    [calls removeObject:call];
    [calls_onhold removeObject:call];
    [tvCalls reloadData];
}

-(void)callTerminated:(Call*)call {
    NSLog(@"%s", __FUNCTION__);
    [calls removeObject:call];
    [calls_onhold removeObject:call];
    [tvCalls reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CallClientWrapper instance].callsDelegate = self;
    calls = [NSMutableArray new];
    calls_onhold = [NSMutableArray new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [calls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CallCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:100];
    UIButton *button_hold_resume = (UIButton *)[cell viewWithTag:101];
    Call* call = [calls objectAtIndex:indexPath.row];
    label.text = [call number];
    if([calls_onhold containsObject:call])
        [button_hold_resume setImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    else
        [button_hold_resume setImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    return cell;
}

- (IBAction)onEndCall:(id)sender {
    UITableViewCell *cell =(UITableViewCell *)[[sender superview] superview];
    NSIndexPath* indexPath = [tvCalls indexPathForCell:cell];
    if(indexPath.row < calls.count)
    {
        Call* call = [calls objectAtIndex:indexPath.row];
        [call terminate];
    }
}

- (IBAction)onHoldToggle:(id)sender {
    UITableViewCell *cell =(UITableViewCell *)[[sender superview] superview];
    NSIndexPath* indexPath = [tvCalls indexPathForCell:cell];
    if(indexPath.row < calls.count)
    {
        Call* call = [calls objectAtIndex:indexPath.row];
        if([calls_onhold containsObject:call])
            [call resume];
        else
            [call pause];
    }
}

- (IBAction)onToogleCall:(id)sender {
    [[CallClientWrapper instance] callToNumber:[tfNumber text]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    [tfNumber resignFirstResponder];
    return YES;
}


@end
