//
//  ViewController.m
//  DayCount
//
//  Created by Takehiro Kawahara on 2014/11/26.
//  Copyright (c) 2014年 Takehiro Kawahara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//アウトレット
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *setdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *todaylabel;
@property (weak, nonatomic) IBOutlet UILabel *betweenLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

//日付
@property NSDate *today;
@property NSDate *setday;

//データ保存
@property NSUserDefaults *userDefaults;
@property NSMutableArray *list;

//アクション
- (IBAction)valueChanged:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //For push return to close keyboard
    _textField.delegate = self;
    
    //今日の日付取得
    _today = [NSDate date];
    NSLog(@"%@", _setday);
    
    // NSUserDefaultsからデータを読み込む
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // _setdayの内容をNSDate型として取得
    _setday = [ud objectForKey:@"setday"];
    //初期dateに設定
    _datePicker.date = _setday;
    
    
    // NSUserDefaultsからデータを読み込む
    NSUserDefaults *Udefaults = [NSUserDefaults standardUserDefaults];
    // _betweendaysStrの内容をNSString型として取得
    _betweenLabel.text = [Udefaults objectForKey:@"betweendays"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
// データ読み込み
- (void)loadFromUserDefaults
{
    NSData *listData = [_userDefaults objectForKey:@"UD_LIST_KEY"];
    _list = [[NSMutableArray alloc] init];
    _list = [NSKeyedUnarchiver unarchiveObjectWithData:listData];
}

//データ保存
- (void)saveToUserDefaults
{
    _list = [[NSMutableArray alloc] initWithArray:_list];
    [_list addObject:@"Apple"];
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:_list];
    [_userDefaults setObject:listData forKey:@"UD_LIST_KEY"];
    [_userDefaults synchronize];
}
*/
//キーボードを非表示にする処理
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // キーボードの非表示
    [self.view endEditing:YES];
    // 改行しない
    return NO;
}

//ピッカーの値を変えたら
- (IBAction)valueChanged:(id)sender {
    

    //ピッカーで設定した日付取得
    _setday = _datePicker.date;
    NSLog(@"%@", _setday);
    
    
    // NSUserDefaultsに保存・更新する
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    [ud setObject:_setday forKey:@"setday"];  //セットした日付を"setday"キーで保存
    
    
    //今日とセットした日の日数の差を取得
    NSInteger *betweendays = [DateUtility daysBetween:_today and:_setday];
    NSLog(@"%d", betweendays);
    //NSInteger to NSString
    NSString *betweenStr = [[NSString alloc] initWithFormat:@"%d",betweendays];
    //日数差を表示
    _betweenLabel.text = betweenStr;
    
    // NSUserDefaultsに保存・更新する
    NSUserDefaults *Udefaults = [NSUserDefaults standardUserDefaults];  // 取得
    [Udefaults setObject:betweenStr forKey:@"betweendays"];  //セットした日付を"betweendays"キーで保存
}
@end

//================================================================================
// DateUtilityクラス
//================================================================================
@implementation DateUtility : NSObject

+ (NSDate*)adjustZeroClock:(NSDate*)date withCalendar:(NSCalendar*)calendar
{
    NSDateComponents *components =
    [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                fromDate:date];
    return [calendar dateFromComponents:components];
}

+ (NSInteger*)daysBetween:(NSDate*)startDate and:(NSDate*)endDate
{
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    startDate = [DateUtility adjustZeroClock:startDate withCalendar:calendar];
    endDate = [DateUtility adjustZeroClock:endDate withCalendar:calendar];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit
                                               fromDate:startDate
                                                 toDate:endDate
                                                options:0];
    NSInteger *days = [components day];

    
    return days;
}
@end