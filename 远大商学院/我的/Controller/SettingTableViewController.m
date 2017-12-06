//
//  SettingTableViewController.m
//  BusinessSchoolOf上海中悟信息有限公司
//
//  Created by 上海中悟信息有限公司 on 16/4/20.
//  Copyright © 2016年 上海中悟信息有限公司. All rights reserved.
//

#import "SettingTableViewController.h"
#import "PersonalInfoViewController.h"
#import "VersionCell.h"

@interface SettingTableViewController ()

@property (nonatomic,retain) NSArray *array;
@property (nonatomic,retain) UIAlertController *alert;

@end

@implementation SettingTableViewController

static NSString *identifier=@"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array=@[@"个人设置",@"课程统计",@"课程评估",@"缓存清理",@"版本"];
    // img--@"Course statistics",@"Course assessment",
    self.tableView.tableFooterView=[[UIView alloc] init];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self.tableView registerClass:[VersionCell class] forCellReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.array.count!=0) {
        return self.array.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VersionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row!=4) {
        cell.titleName.text=self.array[indexPath.row];
    }else{
        cell.titleName.text=self.array[indexPath.row];
        cell.version.text=[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.textLabel.text=self.array[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: // 个人设置
        {
            PersonalInfoViewController *personalIVC=[[PersonalInfoViewController alloc] init];
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:personalIVC animated:YES];
        }
            break;
        case 1: // 课程统计
        {
            [self setAlertTitle];
        }
            break;
        case 2: // 课程评估
        {
            [self setAlertTitle];
        }
            break;
        case 3: // 缓存清理
        {
            [self clearCash];
            NSLog(@"缓存清理");
        }
            break;
        default:
            break;
    }
}

- (void)clearCash{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSLog(@"cachPath==%@",cachPath);
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示:清理缓存会导致下次加载时间变长" message:[NSString stringWithFormat:@"清理缓存(%.2fM)",[self folderSizeAtPath:cachPath]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"清理垃圾" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 清理缓存
            [self clearCache:cachPath];
//            NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
//            
//            NSDictionary* dict = [defs dictionaryRepresentation];
//            
//            for(id key in dict) {
//                [defs removeObjectForKey:key];
//            }
//            
//            [defs synchronize];
            

            // 刷新主线程
            [self.tableView reloadData];
        });
    }];
    UIAlertAction *cancleAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertC addAction:alertAction];
    [alertC addAction:cancleAction];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

// 计算缓存大小
- (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

// 清理缓存
- (void)clearCache:(NSString *)cachePath{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *files=[[NSFileManager defaultManager] subpathsAtPath:cachePath];
        NSLog(@"files:%lu",(unsigned long)[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path=[cachePath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
//        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
}

//- (void)clearCacheSuccess{
//    NSLog(@"清理成功");
//}

/*
- (float)fileSizeWithCachePath:(NSString *)cachePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *files = [manager subpathsOfDirectoryAtPath:cachePath error:nil]; // 递归所有子路径
    float totalSize = 0;
    for (NSString *filePath in files) {
        NSString *path = [cachePath stringByAppendingPathComponent:filePath];
        // 判断是否为文件
        BOOL isDir = NO;
        [manager fileExistsAtPath:path isDirectory:&isDir];
        if (!isDir) {
            NSDictionary *attrs = [manager attributesOfItemAtPath:path error:nil];
            totalSize += [attrs[NSFileSize] integerValue];
        }
    }
    return totalSize;
}
 */

/*
// 清理缓存
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        NSLog(@"childerFiles=%@",childerFiles);
//        NSLog(@"childerFiles==%@",childerFiles);
        for (NSString *fileName in childerFiles) {
            NSLog(@"fileName==%@",fileName);
            //如有需要，加入条件，过滤掉不想删除的文件
//            if ([fileName isEqualToString:@"default"]) {
//                NSLog(@"name=%@",fileName);
//            }
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
//            NSLog(@"absolutePath==%@",absolutePath);
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
*/
 
- (void)setAlertTitle{
    self.alert=[UIAlertController alertControllerWithTitle:nil message:@"敬请期待" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.alert removeFromParentViewController];
    }];
    [self.alert addAction:sureAction];
    [self presentViewController:self.alert animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
