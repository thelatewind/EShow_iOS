//
//  MineBankSetInfoViewController.m
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "MineBankSetInfoViewController.h"

@interface MineBankSetInfoViewController ()<UITextViewDelegate>{
    UITextView *textF;
    UILabel *numLab;
    int num;
    UILabel *defaultLab;
}

@end

@implementation MineBankSetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    num = 30;
    self.title = _infoStr;
//    self.view.backgroundColor = [JKUtil getColor:@"eeeeee"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnPressed)];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

}
- (void)viewWillAppear:(BOOL)animated
{
    [self setupTextField];
}

- (void)rightBtnPressed{
    if (self.backInfoBlock) {
        self.backInfoBlock(textF.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tapAction
{
    [self.view endEditing:YES];
}

- (void)setupTextField
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 15, ScreenWidth, 44*ScaleSize)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    textF = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 44*ScaleSize)];
    textF.scrollEnabled = NO;
    if (_isNumber) {
        textF.keyboardType = UIKeyboardTypeNumberPad;
    }
    textF.delegate = self;
    textF.font = [UIFont systemFontOfSize:18];
    textF.backgroundColor = [UIColor whiteColor];
    [view addSubview:textF];
    [textF becomeFirstResponder];
    defaultLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth-30, 44*ScaleSize)];
    if (textF.text.length==0) {
        defaultLab.hidden = NO;
    }else{
        defaultLab.hidden = YES;;
    }
    defaultLab.text = [NSString stringWithFormat:@"请输入%@",_infoStr];
    defaultLab.textColor = [UIColor grayColor];
    defaultLab.font = [UIFont systemFontOfSize:16];
    [view addSubview:defaultLab];
    
}
#pragma mark - uitextview delegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textF.text.length==0) {
        defaultLab.hidden = NO;
    }else{
        defaultLab.hidden = YES;
    }
    if (textView.text.length > num)
    {
        textView.text = [textView.text substringToIndex:num];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""]){
        return YES;
    }
    if (textView.text.length +text.length - range.length > num)
    {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
