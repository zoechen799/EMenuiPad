//
//  OrderViewController.m
//  EMenu
//
//  Created by Chen, Jonny on 11/29/12.
//  Copyright (c) 2012 NA. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHelper.h"
#import "OrderListCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation OrderViewController
@synthesize appCallback;
- (void)viewWillLayoutSubviews
{
    if(self.view.frame.size.height > self.view.frame.size.width){
        orderList.frame = CGRectMake(15, 50, 700, self.view.frame.size.height-400);
        totalGroup.frame = CGRectMake(15, self.view.frame.size.height-350, 300, 150);
        seatGroup.frame= CGRectMake(15, self.view.frame.size.height-175, 300, 150);
        submitGroup.frame = CGRectMake(375, self.view.frame.size.height-350, 300, 300);
    }else{
        orderList.frame = CGRectMake(15, 50, 700, self.view.frame.size.height-70);
        titleView.frame = CGRectMake(15, 5, 700, 45);
        totalGroup.frame = CGRectMake(720, 5, 300, 150);
        seatGroup.frame= CGRectMake(720, 170, 300, 150);
        submitGroup.frame = CGRectMake(720, 350, 300, 300);
    }
    
}
-(void)viewDidLoad
{
    self.view.backgroundColor =[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg3.png"]];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回菜单" style:UIBarButtonItemStylePlain target:self action:@selector(onBackButtonClicked:)];
    [backBtn setTitle:@"返回菜单"];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem =backBtn;
    [self addTable: self.view];
    [self addTotalGroup:self.view];
    [self addSeatGroup:self.view];
    [self addSubmitGroup:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeWhenOrderChanged:) name:NOTIFICATION_ORDER_CHANGED object:nil];
}

-(void)addTable:(UIView *)parentView;
{
    orderList =[[UITableView alloc] initWithFrame:CGRectMake(15, 50, 700, self.view.frame.size.height-70) style:UITableViewStylePlain];
    orderList.backgroundColor =[UIColor clearColor];
    orderList.dataSource =self;
    orderList.delegate =self;
    [parentView addSubview:orderList];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 5, 700, 45)];
    titleView.backgroundColor =[UIColor clearColor];
    [parentView addSubview:titleView];
    
    UILabel * nameLabel =[[UILabel alloc] init];
    nameLabel.frame = CGRectMake(10, 5, 200, 32);
    nameLabel.backgroundColor =[UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"菜名";
    nameLabel.font =[UIFont fontWithName:@"Helvetica" size:20];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [titleView addSubview:nameLabel];
    [nameLabel release];
    
    UIView * sep1 = [[UIView alloc] initWithFrame:CGRectMake(160, 12, 1, 19)];
    sep1.backgroundColor =[UIColor grayColor];
    sep1.layer.shadowColor = [[UIColor grayColor] CGColor];
    sep1.layer.shadowOffset = CGSizeMake(1.0f,0.0f);
    sep1.layer.shadowOpacity = .5f;
    sep1.layer.shadowRadius = 1.0f;
    [titleView addSubview:sep1];
    [sep1 release];
    
    UILabel * priceLabel =[[UILabel alloc] init];
    priceLabel.frame = CGRectMake(210, 5, 100, 32);
    priceLabel.backgroundColor =[UIColor clearColor];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.text=@"菜价";
    priceLabel.font =[UIFont fontWithName:@"Helvetica" size:20];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    [titleView addSubview:priceLabel];
    [priceLabel release];
    
    UIView * sep2 = [[UIView alloc] initWithFrame:CGRectMake(275, 12, 1, 19)];
    sep2.backgroundColor =[UIColor grayColor];
    sep2.layer.shadowColor = [[UIColor grayColor] CGColor];
    sep2.layer.shadowOffset = CGSizeMake(1.0f,0.0f);
    sep2.layer.shadowOpacity = .5f;
    sep2.layer.shadowRadius = 1.0f;
    [titleView addSubview:sep2];
    [sep2 release];
    
    UILabel * quantityLabel =[[UILabel alloc] init];
    quantityLabel.frame = CGRectMake(310, 5, 100, 32);
    quantityLabel.backgroundColor =[UIColor clearColor];
    quantityLabel.textColor = [UIColor whiteColor];
    quantityLabel.text = @"数量";
    quantityLabel.font =[UIFont fontWithName:@"Helvetica" size:20];
    quantityLabel.textAlignment = NSTextAlignmentLeft;
    [titleView addSubview:quantityLabel];
    [quantityLabel release];
    
    UIView * sep3 = [[UIView alloc] initWithFrame:CGRectMake(590, 12, 1, 19)];
    sep3.backgroundColor =[UIColor grayColor];
    sep3.layer.shadowColor = [[UIColor grayColor] CGColor];
    sep3.layer.shadowOffset = CGSizeMake(1.0f,0.0f);
    sep3.layer.shadowOpacity = .5f;
    sep3.layer.shadowRadius = 1.0f;
    [titleView addSubview:sep3];
    [sep3 release];
    
    UILabel * totalPriceLabel =[[UILabel alloc] init];
    totalPriceLabel.frame = CGRectMake(595, 5, 100, 32);
    totalPriceLabel.backgroundColor =[UIColor clearColor];
    totalPriceLabel.textColor = [UIColor whiteColor];
    totalPriceLabel.text =@"合计";
    totalPriceLabel.font =[UIFont fontWithName:@"Helvetica" size:20];
    totalPriceLabel.textAlignment = NSTextAlignmentRight;
    [titleView addSubview:totalPriceLabel];
    [totalPriceLabel release];
}
-(void)addTotalGroup:(UIView*)parentView
{
    totalGroup =[[UIView alloc] initWithFrame: CGRectMake(720, 5, 300, 150)];
    totalGroup.backgroundColor = HEXCOLOR(0xFCE8BBB1);
    [totalGroup.layer setCornerRadius:14];
    [totalGroup.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    UILabel * _totalLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 70, 32)];
    _totalLabel.text=@"总数量:";
    _totalLabel.font =[UIFont boldSystemFontOfSize:20];
    _totalLabel.backgroundColor =[UIColor clearColor];
    _totalLabel.textColor = [UIColor whiteColor];
    [totalGroup addSubview:_totalLabel];
    
    _totalQty =[[UILabel alloc] initWithFrame:CGRectMake(100, 10, 100, 32)];
    _totalQty.font =[UIFont boldSystemFontOfSize:20];
    _totalQty.backgroundColor =[UIColor clearColor];
    _totalQty.text = [NSString stringWithFormat:@"%d",[[OrderHelper sharedOrderHelper] totalQuantity]];
    _totalQty.textColor = [UIColor redColor];
    _totalQty.textAlignment =UITextAlignmentRight;
    [totalGroup addSubview:_totalQty];
    
    UILabel * _totalPrice =[[UILabel alloc] initWithFrame:CGRectMake(15, 100, 70, 32)];
    _totalPrice.text=@"总金额:";
    _totalPrice.font =[UIFont boldSystemFontOfSize:20];
    _totalPrice.backgroundColor =[UIColor clearColor];
    _totalPrice.textColor = [UIColor whiteColor];
    [totalGroup addSubview:_totalPrice];
    
    _totalPrc =[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 150, 32)];
    _totalPrc.font =[UIFont boldSystemFontOfSize:24];
    _totalPrc.backgroundColor =[UIColor clearColor];
    _totalPrc.text = [NSString stringWithFormat:@"%.2f元",[[OrderHelper sharedOrderHelper] totalPrice]];
    _totalPrc.textColor = [UIColor redColor];
    _totalPrc.textAlignment =UITextAlignmentRight;
    [totalGroup addSubview:_totalPrc];
    [parentView addSubview:totalGroup];
}

-(void)addSeatGroup:(UIView*)parentView
{
    seatGroup =[[UIView alloc] initWithFrame: CGRectMake(720, 170, 300, 150)];
    seatGroup.backgroundColor = HEXCOLOR(0xFCE8BBB1);
    [seatGroup.layer setCornerRadius:14];
    [seatGroup.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    UILabel * _seatLabel =[[UILabel alloc] initWithFrame:CGRectMake(75, 10, 150, 40)];
    _seatLabel.text=@"您的餐桌号:";
    _seatLabel.font =[UIFont boldSystemFontOfSize:20];
    _seatLabel.backgroundColor =[UIColor clearColor];
    _seatLabel.textColor = [UIColor whiteColor];
    _seatLabel.textAlignment = UITextAlignmentCenter;
    [seatGroup addSubview:_seatLabel];
    [_seatLabel release];
    
    _seatNo = [[UITextField alloc] initWithFrame:CGRectMake(75, 70, 150, 45)];
    _seatNo.keyboardType =UIKeyboardTypeNumberPad;
    _seatNo.backgroundColor = HEXCOLOR(0xFCF5E3FF);
    _seatNo.delegate = self;
    _seatNo.borderStyle = UITextBorderStyleBezel;
    _seatNo.font= [UIFont boldSystemFontOfSize:26];
    _seatNo.textAlignment = UITextAlignmentCenter;
    [seatGroup addSubview:_seatNo];
    [parentView addSubview:seatGroup];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


-(void)noticeWhenOrderChanged:(NSNotification *)notification
{
    _totalQty.text = [NSString stringWithFormat:@"%d",[[OrderHelper sharedOrderHelper] totalQuantity]];
    _totalPrc.text = [NSString stringWithFormat:@"%.2f元",[[OrderHelper sharedOrderHelper] totalPrice]];
}
-(void)onBackButtonClicked:(id)sender
{
    if(appCallback!=nil && self.restaurant!=nil)
        [appCallback loadSpliterViewController:self.restaurant aBrandNew:NO];
}

-(void)addSubmitGroup:(UIView *)parentView
{
    submitGroup=[[UIView alloc] initWithFrame: CGRectMake(720, 350, 300, 300)];
    submitGroup.backgroundColor = HEXCOLOR(0xFCE8BBB1);
    [submitGroup.layer setCornerRadius:14];
    [submitGroup.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    _succLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 40)];
    _succLabel.text=@"下单成功!";
    _succLabel.font =[UIFont boldSystemFontOfSize:25];
    _succLabel.backgroundColor =[UIColor clearColor];
    _succLabel.textColor = [UIColor redColor];
    _succLabel.textAlignment = UITextAlignmentCenter;
    _succLabel.hidden = YES;
    [submitGroup addSubview:_succLabel];
    
    confirmBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame =CGRectMake(100, 5, 100, 40);
    [confirmBtn setTitle: NSLocalizedString(@"确认下单", nil) forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(onSubmitClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitGroup addSubview:confirmBtn];
    
    _readLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 280, 200)];
    _readLabel.text=@"感谢您使用电子点餐系统。点击按钮下单后，我们厨房的大师傅在第一时间就会为您服务。";
    _readLabel.font =[UIFont boldSystemFontOfSize:20];
    _readLabel.backgroundColor =HEXCOLOR(0xFCF5E3FF);
    _readLabel.textColor = [UIColor orangeColor];
    _readLabel.textAlignment = UITextAlignmentLeft;
    _readLabel.numberOfLines=0;
    [submitGroup addSubview:_readLabel];
    
    _newOrderBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _newOrderBtn.frame=CGRectMake(100, 255, 100, 40);
    [_newOrderBtn setTitle: NSLocalizedString(@"新的订单", nil) forState:UIControlStateNormal];
    [_newOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_newOrderBtn addTarget:self action:@selector(onNewOrder:) forControlEvents:UIControlEventTouchUpInside];
    [submitGroup addSubview:_newOrderBtn];
    _newOrderBtn.hidden = YES;
    
    [parentView addSubview:submitGroup];
}
-(void)onSubmitClicked:(id)sender
{
    if (_seatNo.text==nil || _seatNo.text.length==0) {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入餐桌编号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [confirmBtn setEnabled:NO];
        confirmBtn.hidden = YES;
        _succLabel.hidden = NO;
        _newOrderBtn.hidden =NO;
        _readLabel.text=[NSString stringWithFormat: @"感谢您使用电子点餐系统订餐,您已成功下单，订单编码是11073,共%d例菜肴,订单金额:%.2f元。我们将给您提供优质的服务,如果需要点其他菜，请点击\"新的订单\"按钮。谢谢！",[OrderHelper sharedOrderHelper].totalQuantity,[OrderHelper sharedOrderHelper].totalPrice];
    }
}
-(void)onNewOrder:(id)sender
{
    if(self.appCallback!=nil)
    [self.appCallback restartOrder:self.restaurant];
}
#pragma mark -
#pragma mark UITextFieldDelegate
- (IBAction)keyboardWillHide:(NSNotification *)note
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [_seatNo resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + seatGroup.frame.origin.y+ 50 - (self.view.frame.size.height - 216.0);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -220,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}
#pragma mark -

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[OrderHelper sharedOrderHelper].list count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderCellIdentifier";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OrderListCell alloc] init];
        Dish * _dish = [[OrderHelper sharedOrderHelper].list objectAtIndex:indexPath.row];
        cell.dish =_dish;
        cell.dishQuantity = [[OrderHelper sharedOrderHelper] quantityForDish:_dish];
    }
    return cell;
}
@end
