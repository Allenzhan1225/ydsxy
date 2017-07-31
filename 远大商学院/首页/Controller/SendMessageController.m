//
//  SendMessageController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/8.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "SendMessageController.h"

@interface SendMessageController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *titleA;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIAlertController *alert;
@property (nonatomic,strong) UIAlertAction *sureAction;
@property (nonatomic,strong) UIAlertAction *cancleAction;

@property (nonatomic,strong) NSUserDefaults *defaults;

@end

@implementation SendMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

// setupUI
- (void)setupUI{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    
    // title
    [self setTtile];
    // textView
    [self setTextview];
    
    // 弹出框提示信息——需要进行判断：①是否已编辑文字？即是否写有文字内容？②若已经编辑完成，是否确认发布信息？
    _alert=[UIAlertController alertControllerWithTitle:@"贴心提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    _sureAction=[UIAlertAction actionWithTitle:@"确定发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确认发送消息，请求给后台，后台保存
        if (![_textView.text isEqual:@""] || _textView.text!=nil) {
            [self storageMessage];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    _cancleAction=[UIAlertAction actionWithTitle:@"取消编辑" style:UIAlertActionStyleCancel handler:nil];
    [self.alert addAction:_cancleAction];
    [self.alert addAction:_sureAction];
}

// 保存信息
- (void)storageMessage{
    _defaults=[NSUserDefaults standardUserDefaults];
    NSInteger u_id=[_defaults integerForKey:@"u_id"];
    NSString *string=[kURLOFADD_MESSAGE stringByAppendingString:[NSString stringWithFormat:@"u_id=%ld&title=%@&content=%@",(long)u_id,_titleA.text,_textView.text]];
    NSString *encode=[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    sessionManager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [sessionManager GET:encode parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"downloadProgress=%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"SendMessageSuccess!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"SendMessageError=%@",error);
    }];
}

- (void)setTtile{
    self.title=@"发布消息";
    for (int i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(5, 70+45*i, 60, 40)];
        if (i==0) {
            label.text=@"标题";
        }else{
            label.text=@"正文";
        }
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.layer.masksToBounds=YES;
        label.layer.cornerRadius=8;
        label.backgroundColor=[UIColor colorWithRed:14/255.0 green:113/255.0 blue:166/255.0 alpha:1];
        [self.view addSubview:label];
    }
    
    _titleA=[[UITextField alloc] initWithFrame:CGRectMake(70, 70, kWIDTH-75, 40)];
    _titleA.textAlignment=NSTextAlignmentLeft;
    _titleA.placeholder=@"标题";
    _titleA.backgroundColor=[UIColor lightGrayColor];
    _titleA.layer.masksToBounds=YES;
    _titleA.layer.cornerRadius=8;
    self.titleA.delegate=self;
    [self.view addSubview:_titleA];
    
    // 添加添加图片按钮
    UIImageView *imgView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic"]];
    imgView.frame=CGRectMake(70, 115, 40, 40);
    [self.view addSubview:imgView];
    
    // clearBtn
    UIButton *clearBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame=CGRectMake(kWIDTH-80, 115, 75, 40);
    [clearBtn setTitle:@"清除所有" forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.backgroundColor=[UIColor colorWithRed:14/255.0 green:113/255.0 blue:166/255.0 alpha:1];
    clearBtn.layer.masksToBounds=YES;
    clearBtn.layer.cornerRadius=8;
    [self.view addSubview:clearBtn];
}

- (void)clear{
    self.textView.text=nil;
}

- (void)setTextview{
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(5, 160, kWIDTH-10, kHEIGHT-210)];
//    _textView.backgroundColor=[UIColor orangeColor];
    _textView.font=[UIFont systemFontOfSize:17];
    _textView.layer.masksToBounds=YES;
    _textView.layer.cornerRadius=10;
    _textView.layer.borderWidth=1.0;
    [self.view addSubview:_textView];
}

- (void)sendMessage{
    if (_textView.text==nil || [_textView.text isEqual:@""]) {
        _alert.message=@"尚未编辑任何内容，是否放弃此次编辑？(注:确定将发送空消息并返回信息列表界面)";
    }else{
        _alert.message=@"是否发布消息？";
//        [self presentViewController:_alert animated:YES completion:nil];
    }
    [self presentViewController:_alert animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.titleA resignFirstResponder];
    [self.textView resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
    [self.titleA resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.alert removeFromParentViewController];
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
