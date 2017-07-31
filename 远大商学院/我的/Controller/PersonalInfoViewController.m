//
//  PersonalInfoViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/5/14.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "PersonalInfoViewController.h"

@interface PersonalInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSUserDefaults *defaults;
@property (nonatomic,strong) UIImagePickerController *imgPicker;
// 存储用户头像图片
@property (nonatomic,strong) UIImage *image;
@property (nonatomic, strong) NSString *filePatch;

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
@property (nonatomic, strong) UIActionSheet *myActionSheet;
#pragma clang diagnostic pop

// 用户个人信息
@property (nonatomic,strong) UITextField *nickName;
@property (nonatomic,strong) UITextField *gender;
@property (nonatomic,strong) UITextField *birthday;
@property (nonatomic,strong) UIImageView *headerView;

@property (nonatomic,strong) UIDatePicker *datePicker;

@end

@implementation PersonalInfoViewController

// 编辑
- (void)edit:(UIBarButtonItem *)sender{
    if ([self.navigationItem.rightBarButtonItem.title isEqual:@"编辑"]) {
        self.nickName.userInteractionEnabled=YES;
        self.gender.userInteractionEnabled=YES;
        [self.birthday removeFromSuperview];
        
        self.navigationItem.rightBarButtonItem.title=@"确定";
        // 添加时间选择器
        self.datePicker=[[UIDatePicker alloc] init];
        self.datePicker.frame=CGRectMake(60, kHEIGHT/16.0*7+64, kWIDTH-70, 50);
        self.datePicker.datePickerMode=UIDatePickerModeDate;
        self.datePicker.date=[NSDate date];
        [self.datePicker addTarget:self action:@selector(dateSelect) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:self.datePicker];
    }else if ([self.navigationItem.rightBarButtonItem.title isEqual:@"确定"]){
        self.nickName.userInteractionEnabled=NO;
        self.gender.userInteractionEnabled=NO;
        [self.view addSubview:self.birthday];
        
        self.navigationItem.rightBarButtonItem.title=@"编辑";
        if (self.datePicker!=nil) {
            [self.datePicker removeFromSuperview];
        }
    }
}

#pragma mark--UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
        // 存储
    if (textField==self.nickName) {
        [self.defaults setValue:self.nickName.text forKey:@"nickName"];
        [_defaults synchronize];
    }else if (textField==self.gender){
        [self.defaults setValue:self.gender.text forKey:@"gender"];
        [_defaults synchronize];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nickName resignFirstResponder];
    [self.gender resignFirstResponder];
}

- (void)dateSelect{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MM-dd"];
    NSString *str=[outputFormatter stringFromDate:self.datePicker.date];
    self.birthday.text=str;
    // 存储
    [self.defaults setValue:str forKey:@"birthday"];
    [_defaults synchronize];
}

- (void)changeImg:(UIButton *)sender{
    self.myActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil  otherButtonTitles: @"打开照相机", @"从手机相册获取",nil];
    [self.myActionSheet showInView:self.view];
}

#pragma mark  --- 点击按钮时
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == self.myActionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}
#pragma clang diagnostic pop

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark --  UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    
//    NSString *type = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //当选择的类型是图片
        //先把图片转成NSData
        
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        self.image = image;
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSLog(@"%@",DocumentsPath);
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //得到选择后沙盒中图片的完整路径
        _filePatch = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
//        NSLog(@"%@",image);
        [_defaults setObject:@"image.png" forKey:@"imgName"];
        
        // 读取图片
        UIImage *img=[[UIImage alloc] initWithContentsOfFile:_filePatch];
        _headerView.image=img;
}
//当选择一张图片后进入这里
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil ];
}

-(void)sendInfo
{
    NSLog(@"图片的路径是：%@", self.filePatch);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"个人设置";
    self.view.backgroundColor=[UIColor whiteColor];
    self.defaults=[NSUserDefaults standardUserDefaults];
    
    [self buildUI];
}

- (void)buildUI{
    // 头像
    UIImageView *headerView=[[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH/2.0-kHEIGHT/8.0, 64, kHEIGHT/4.0, kHEIGHT/4.0)];
    _headerView=headerView;
    // 圆角
    headerView.layer.masksToBounds=YES;
    headerView.layer.cornerRadius=kHEIGHT/8.0;
    //    headerView.backgroundColor=[UIColor orangeColor];
    NSString *imgName=[_defaults valueForKey:@"imgName"];
    if ([imgName isEqual:@""] || imgName==nil) {
        headerView.image=[UIImage imageNamed:@"logo"];
    }else{
        // 读取图片
        NSString *path=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName];
        UIImage *img=[[UIImage alloc] initWithContentsOfFile:path];
        headerView.image=img;
    }
    [self.view addSubview:headerView];
    
    // 头像
    UIButton *imgBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    imgBtn.frame=CGRectMake(10, kHEIGHT/4.0+64, 60, kHEIGHT/16.0);
    [imgBtn setTitle:@"换头像" forState:UIControlStateNormal];
    [imgBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(changeImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn];
    
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, kHEIGHT/16.0*5+kHEIGHT/16.0*i+64, 50, kHEIGHT/16.0)];
        UITextField *textField=[[UITextField alloc] initWithFrame:CGRectMake(60, kHEIGHT/16.0*5+kHEIGHT/16.0*i+64, kWIDTH-70, kHEIGHT/16.0)];
        switch (i) {
            case 0: // 昵称--nickName
            {
                label.text=@"昵称:";
                self.nickName=textField;
                self.nickName.delegate=self;
                NSString *nick=[_defaults valueForKey:@"nickName"];
                if ([nick isEqual:@""] || nick==nil) {
                    self.nickName.placeholder=@"请输入少于9个字的昵称";
                }else{
                    self.nickName.text=nick;
                    self.nickName.placeholder=nil;
                }
            }
                break;
            case 1: // 性别
            {
                label.text=@"性别:";
                self.gender=textField;
                self.gender.delegate=self;
                NSString *gender=[_defaults valueForKey:@"gender"];
                if ([gender isEqual:@""] || gender==nil) {
                    self.gender.placeholder=@"请填写性别";
                }else{
                    self.gender.text=gender;
                    self.gender.placeholder=nil;
                }
            }
                break;
            case 2: // 生日
            {
                label.text=@"生日:";
                self.birthday=textField;
                NSString *birthdayDate=[_defaults valueForKey:@"birthday"];
                if ([birthdayDate isEqual:@""] || birthdayDate==nil) {
                    self.birthday.placeholder=@"请选择生日";
                }else{
                    self.birthday.text=birthdayDate;
                    self.birthday.placeholder=nil;
                }
            }
                break;
            default:
                break;
        }
        // 圆角和边框
        textField.layer.masksToBounds=YES;
        textField.layer.cornerRadius=8;
        // 交互
        textField.userInteractionEnabled=NO;
        // 字体大小
        label.font=[UIFont systemFontOfSize:20];
        textField.font=[UIFont systemFontOfSize:20];
        
        [self.view addSubview:textField];
        [self.view addSubview:label];
    }
    
    // 编辑
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
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
