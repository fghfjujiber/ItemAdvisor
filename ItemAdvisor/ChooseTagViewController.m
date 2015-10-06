//
//  ChooseTagViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 27/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "ChooseTagViewController.h"

@interface ChooseTagViewController ()

@property(strong,nonatomic)UIScrollView *itemList;
@property(strong,nonatomic)UIScrollView *catalogList;
@property(strong,nonatomic)UIScrollView *selectedList;
@property(strong,nonatomic)UIButton *clearButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *NextStepButton;

@end

@implementation ChooseTagViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)goToPreview:(id)sender {
    if ([_addedTagArray count]>0) {
        [self.delegate addItemViewController:self didFinishEnteringItems:_addedTagArray];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _addedTagArray = [[NSMutableArray alloc]init];
    
    //set next button to gray
    _NextStepButton.tintColor = [UIColor grayColor];
    
    _selectedList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 121)];
    [_selectedList setContentSize:CGSizeMake(325, _selectedList.frame.size.height)];
    [self setUpScrollView:_selectedList with:UIColorFromRGB(0x2D9DD7)];
    [self initialSelectedList];
    [self.view addSubview:_selectedList];
    
    _itemList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 121, 320, 262)];
    //[_itemList setContentSize:CGSizeMake(640, _itemList.frame.size.height)];
    [self setUpScrollView:_itemList with:UIColorFromRGB(0xFFB837)];
    [self initialItemList];
    [self.view addSubview:_itemList];
    
    _catalogList = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 383, 320, 121)];
    [self setUpScrollView:_catalogList with:UIColorFromRGB(0x54B547)];
    [self initialCatalogList];
    [self.view addSubview:_catalogList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpScrollView:(UIScrollView *)scrollView with:(UIColor *)color{
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.backgroundColor = color;
    scrollView.delegate = self;
}

-(void)initialItemList{
    //create label for title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 310, 40)];
    title.text = [NSString stringWithFormat:@"可选物品"];
    title.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    [_itemList addSubview:title];
    
    //set contentsize
    [_itemList setContentSize:CGSizeMake(325, _itemList.frame.size.height)];
    
    //Insert buttons(show the catalog clothes first)
    for (int i=0; i<9; i++) {
        UIButton *itemButton = [self createButtonsBy:i];
        [itemButton setBackgroundColor:UIColorFromRGB(0xFF9C00)];
        [itemButton addTarget:self action:@selector(updateSelectedListBy:) forControlEvents:UIControlEventTouchUpInside];
        [itemButton setTag:100+i];
        [self fillContentIntoButton:itemButton withText:[self getItemTitleForTag:100+i]];
        
        [_itemList setTag:i+1];
        [_itemList addSubview: itemButton];
    }
}

-(void)initialCatalogList{
    //Create label for title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 310, 40)];
    title.text = [NSString stringWithFormat:@"物品类别"];
    title.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    [_catalogList addSubview:title];
    
    //Set contentSize
    [_catalogList setContentSize:CGSizeMake(710, _catalogList.frame.size.height)];
    
    //Insert buttons in the scrollview
    for (int i=0; i<7; i++) {
        UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectMake(10*(i+1)+90*i, 45, 90, 55)];
        [itemButton setBackgroundColor:UIColorFromRGB(0x119800)];
        [itemButton addTarget:self action:@selector(updateItemListBy:) forControlEvents:UIControlEventTouchUpInside];
        [itemButton setTag:(i+1)*100];
        [self fillContentIntoButton:itemButton withText:[self getItemTitleForTag:(i+1)*100]];
        [_catalogList addSubview: itemButton];
    
    }

}

-(UIButton *)createButtonsBy:(int)numOfPosition{
    switch (numOfPosition) {
        //row 1
        case 0:
            return [[UIButton alloc]initWithFrame:CGRectMake(10, 45, 90, 55)];
            break;
        case 1:
            return [[UIButton alloc]initWithFrame:CGRectMake(110, 45, 90, 55)];
            break;
            
        case 2:
            return [[UIButton alloc]initWithFrame:CGRectMake(210, 45, 90, 55)];
            break;
        //row 2
        case 3:
            return [[UIButton alloc]initWithFrame:CGRectMake(10, 115, 90, 55)];
            break;
            
        case 4:
            return [[UIButton alloc]initWithFrame:CGRectMake(110, 115, 90, 55)];
            break;
            
        case 5:
            return [[UIButton alloc]initWithFrame:CGRectMake(210, 115, 90, 55)];
            break;
        //row 3
        case 6:
            return [[UIButton alloc]initWithFrame:CGRectMake(10, 185, 90, 55)];
            break;
            
        case 7:
            return [[UIButton alloc]initWithFrame:CGRectMake(110, 185, 90, 55)];
            break;
            
        case 8:
            return [[UIButton alloc]initWithFrame:CGRectMake(210, 185, 90, 55)];
            break;
        //extra >9 column 1
        case 9:
            return [[UIButton alloc]initWithFrame:CGRectMake(310, 45, 90, 55)];
            break;
            
        case 10:
            return [[UIButton alloc]initWithFrame:CGRectMake(310, 115, 90, 55)];
            break;
            
        case 11:
            return [[UIButton alloc]initWithFrame:CGRectMake(310, 185, 90, 55)];
            break;
        //column 2
        case 12:
            return [[UIButton alloc]initWithFrame:CGRectMake(410, 45, 90, 55)];
            break;
            
        default: return [[UIButton alloc]initWithFrame:CGRectMake(10, 45, 90, 55)];
            break;
    }
}

-(void)updateItemListBy:(UIButton *)sender{
    if (sender.tag/100 != _itemList.tag) {
        [self clearButtonsIn:_itemList];
        for (int i = 0; i < [self numOfItemsIn:(int)sender.tag]; i++) {
            UIButton *itemButton = [self createButtonsBy:i];
            [itemButton setBackgroundColor:UIColorFromRGB(0xFF9C00)];
            [itemButton addTarget:self action:@selector(updateSelectedListBy:) forControlEvents:UIControlEventTouchUpInside];
            [itemButton setTag:sender.tag+i];
            [self fillContentIntoButton:itemButton withText:[self getItemTitleForTag:(int)sender.tag+i]];
            
            [_itemList setTag:sender.tag/100];
            [_itemList addSubview: itemButton];
        }
        if ([self numOfItemsIn:(int)sender.tag] > 9) {
            [_itemList setContentSize:CGSizeMake(510, _itemList.frame.size.height)];
        }else {
            [_itemList setContentSize:CGSizeMake(325, _itemList.frame.size.height)];
        }
    }
    _itemList.showsHorizontalScrollIndicator = NO;
    _itemList.showsHorizontalScrollIndicator = YES;
}

-(void)updateSelectedListBy:(UIButton *)sender{
    _clearButton.hidden = NO;
    
    //add object in array
    NSNumber *num = [NSNumber numberWithInt:(int)sender.tag];
    [_addedTagArray addObject:num];
    
    if ([_addedTagArray count] == 0) {
        //set next button to gray
        _NextStepButton.tintColor = [UIColor grayColor];
    }else{
        //set next button to white
        _NextStepButton.tintColor = [UIColor whiteColor];
    }
    
    //create button
    UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectMake(10+100*([_addedTagArray count]-1), 45, 90, 55)];
    [itemButton setBackgroundColor:UIColorFromRGB(0x0076C7)];
    [itemButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [self fillContentIntoButton:itemButton withText:[self getItemTitleForTag:(int)sender.tag]];
    [_selectedList addSubview: itemButton];
    
    //set scrollview
    if ([_addedTagArray count]>3) {
        [_selectedList setContentSize:CGSizeMake([_addedTagArray count]*100+10, _selectedList.frame.size.height)];
    }else{
        [_selectedList setContentSize:CGSizeMake(325, _selectedList.frame.size.height)];
    }
    [_selectedList setContentOffset:CGPointMake(0, 0)];
    _selectedList.showsHorizontalScrollIndicator = NO;
    _selectedList.showsHorizontalScrollIndicator = YES;
}

-(void)deleteButton:(UIButton *)sender{
    nil;
}

-(void)clearButtonsIn:(UIScrollView *)scrollView{
    for (UIView *v in scrollView.subviews) {
        if (![v isKindOfClass:[UILabel class]]) {
            [v removeFromSuperview];
        }
    }
}

-(int)numOfItemsIn:(int)num{
    switch (num) {
        case 100:
            return 9;
            break;
            
        case 200:
            return 6;
            break;
            
        case 300:
            return 7;
            break;
            
        case 400:
            return 6;
            break;
            
        case 500:
            return 4;
            break;
            
        case 600:
            return 4;
            break;
            
        case 700:
            return 13;
            break;
            
        default:
            return 0;
            break;
    }
}

-(void)fillContentIntoButton:(UIButton *)button withText:(NSString *)text{
    //create imageview for logo
    //UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(2.5, 2.5, 50, 50)];
    
    //create label for item title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 35, 40)];
    title.text = text;
    title.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    [title sizeToFit];
    [button addSubview:title];
    
}

-(NSString *)getItemTitleForTag:(int )number{
    switch (number) {
        case 100:
            return [NSString stringWithFormat:@"衣物"];
            break;
        
        case 101:
            return [NSString stringWithFormat:@"短袖"];
            break;
            
        case 102:
            return [NSString stringWithFormat:@"长袖"];
            break;
            
        case 103:
            return [NSString stringWithFormat:@"外套"];
            break;
            
        case 104:
            return [NSString stringWithFormat:@"长裙"];
            break;
            
        case 105:
            return [NSString stringWithFormat:@"短裙"];
            break;
            
        case 106:
            return [NSString stringWithFormat:@"长裤"];
            break;
            
        case 107:
            return [NSString stringWithFormat:@"短裤"];
            break;
            
        case 108:
            return [NSString stringWithFormat:@"背心"];
            break;
            
        case 200:
            return [NSString stringWithFormat:@"鞋子"];
            break;
            
        case 201:
            return [NSString stringWithFormat:@"高跟鞋"];
            break;
            
        case 202:
            return [NSString stringWithFormat:@"运动"];
            break;
            
        case 203:
            return [NSString stringWithFormat:@"皮鞋"];
            break;
            
        case 204:
            return [NSString stringWithFormat:@"人字拖"];
            break;
            
        case 205:
            return [NSString stringWithFormat:@"靴子"];
            break;
            
        case 300:
            return [NSString stringWithFormat:@"配件"];
            break;
            
        case 301:
            return [NSString stringWithFormat:@"手表"];
            break;
            
        case 302:
            return [NSString stringWithFormat:@"首饰"];
            break;
            
        case 303:
            return [NSString stringWithFormat:@"眼镜"];
            break;
            
        case 304:
            return [NSString stringWithFormat:@"包包"];
            break;
            
        case 305:
            return [NSString stringWithFormat:@"背包"];
            break;
            
        case 306:
            return [NSString stringWithFormat:@"帽子"];
            break;
        
        case 400:
            return [NSString stringWithFormat:@"食物"];
            break;
            
        case 401:
            return [NSString stringWithFormat:@"甜品"];
            break;
            
        case 402:
            return [NSString stringWithFormat:@"小吃"];
            break;
            
        case 403:
            return [NSString stringWithFormat:@"菜肴"];
            break;
            
        case 404:
            return [NSString stringWithFormat:@"饮品"];
            break;
            
        case 405:
            return [NSString stringWithFormat:@"酒精"];
            break;
        
        case 500:
            return [NSString stringWithFormat:@"数码"];
            break;
            
        case 501:
            return [NSString stringWithFormat:@"手机"];
            break;
            
        case 502:
            return [NSString stringWithFormat:@"相机"];
            break;
            
        case 503:
            return [NSString stringWithFormat:@"平板"];
            break;
            
        case 600:
            return [NSString stringWithFormat:@"交通工具"];
            break;
            
        case 601:
            return [NSString stringWithFormat:@"汽车"];
            break;
            
        case 602:
            return [NSString stringWithFormat:@"单车"];
            break;
            
        case 603:
            return [NSString stringWithFormat:@"摩托车"];
            break;
            
        case 700:
            return [NSString stringWithFormat:@"其他"];
            break;
            
        case 701:
            return [NSString stringWithFormat:@"宠物"];
            break;
            
        case 702:
            return [NSString stringWithFormat:@"猫"];
            break;
            
        case 703:
            return [NSString stringWithFormat:@"狗"];
            break;
            
        case 704:
            return [NSString stringWithFormat:@"书籍"];
            break;
            
        case 705:
            return [NSString stringWithFormat:@"唱片"];
            break;
            
        case 706:
            return [NSString stringWithFormat:@"电影"];
            break;
            
        case 707:
            return [NSString stringWithFormat:@"邮票"];
            break;
            
        case 708:
            return [NSString stringWithFormat:@"图集"];
            break;
            
        case 709:
            return [NSString stringWithFormat:@"个人收藏"];
            break;
            
        case 710:
            return [NSString stringWithFormat:@"古董"];
            break;
            
        case 711:
            return [NSString stringWithFormat:@"玩偶"];
            break;
            
        case 712:
            return [NSString stringWithFormat:@"家具"];
            break;
            
        default:
            return nil;
            break;
    }
}

-(void)initialSelectedList{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 310, 40)];
    title.text = [NSString stringWithFormat:@"已选物品"];
    title.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentLeft;
    [_selectedList addSubview:title];
    
    _clearButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 14, 60, 20)];
    [_clearButton setBackgroundColor:UIColorFromRGB(0x0076C7)];
    [_clearButton addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    [_clearButton setTitle:@"Clear All" forState:UIControlStateNormal];
    [_clearButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    _clearButton.hidden = YES;
    [_selectedList addSubview: _clearButton];

}

-(void)clearAll{
    [_addedTagArray removeAllObjects];
    //set next button to gray
    _NextStepButton.tintColor = [UIColor grayColor];
    [self clearButtonsIn:_selectedList];
    _clearButton.hidden = YES;
    [_selectedList addSubview:_clearButton];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if([segue.identifier isEqualToString:@"ChooseTag"]){
//         MakePostViewController *controller = (MakePostViewController *)segue.destinationViewController;
//        controller.addedTagArray = [[NSMutableArray alloc]initWithArray:_addedTagArray];
//    }
//}

@end









