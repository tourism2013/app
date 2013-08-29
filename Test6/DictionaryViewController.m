//
//  DictionaryViewController.m
//  Test6
//
//  Created by Masashi Kawabe on 2013/08/11.
//  Copyright (c) 2013年 Masashi Kawabe. All rights reserved.
//

#import "DictionaryViewController.h"
#import "SBJson.h"

@interface DictionaryViewController ()

@end

@implementation DictionaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://www.pref.hokkaido.lg.jp/sr/ske/osazu/oz01fis/fis036.htm"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url]; //リクエストの作成
    
    NSURLResponse* resp = nil;
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err]; //// 同期的な呼び出し
    NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *json = [result JSONValue];
    
    NSDictionary *results = [json objectForKey:@"value"];
    NSLog(@"カロリー:%@",results);
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
