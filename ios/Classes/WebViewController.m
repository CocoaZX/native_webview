//
//  WebViewController.m
//  Runner
//
//  Created by Crow on 2019/7/9.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

+ (WebViewController *)singleton{
    static dispatch_once_t onceToken;
    __block WebViewController *_sing = nil;
    dispatch_once(&onceToken, ^{
        _sing = [[WebViewController alloc] init];
    });
    return _sing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [WebViewController singleton].webView = [[WKWebView alloc] init];
//    [WebViewController singleton].webView.frame = [UIApplication sharedApplication].keyWindow.frame;
    // Do any additional setup after loading the view.
}

+(void)showView:(id)info{
    WKWebView *webview = nil;
    if ([info isKindOfClass:[NSString class]]) {
        webview = [[WebViewController singleton] findWebView:info];
        //TODO:刘海屏
        webview.frame = CGRectMake(0, 64, [UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height) ;
        webview.hidden = false;
        [self loadWeb:webview url:info];
    }else if ([info isKindOfClass:[NSDictionary class]]){
        NSString *url = [((NSDictionary *)info) objectForKey:@"url"];
        webview = [[WebViewController singleton] findWebView:url];
        //TODO:设置大小
        //        webview.frame = info
        webview.frame = [UIApplication sharedApplication].keyWindow.frame;
        webview.hidden = false;
        [self loadWeb:webview url:url];
    }else{
        return;
    }
}

+(void)hiddenView:(NSString *)url{
    if (url) {
        WKWebView *webview = [[WebViewController singleton] findWebView:url];
        webview.hidden = true;
    }else{
        if ([[UIApplication sharedApplication].keyWindow.rootViewController.view.subviews.lastObject isKindOfClass:[WKWebView class]]){
            [UIApplication sharedApplication].keyWindow.rootViewController.view.subviews.lastObject.hidden = true;
        }
    }
}

+(void)deleteView:(NSString *)url{
    if (url) {
        WKWebView *webview = [[WebViewController singleton] findWebView:url];
        [[WebViewController singleton].webViews removeObject:webview];
        [webview removeFromSuperview];
    }else{
        if ([[UIApplication sharedApplication].keyWindow.rootViewController.view.subviews.lastObject isKindOfClass:[WKWebView class]]){
            [[UIApplication sharedApplication].keyWindow.rootViewController.view.subviews.lastObject removeFromSuperview];
            [[WebViewController singleton].webViews removeLastObject];
        }
    }
}

+(void)loadWeb:(WKWebView *)webView url:(NSString *)url{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
}

-(WKWebView *)findWebView:(NSString *)url{
    for (WKWebView *item in [WebViewController singleton].webViews) {
        if ([[item.URL absoluteString] isEqualToString:url]) {
            return item;
        }
    }
    return [self createNewWeb:url];
}


-(WKWebView *)createNewWeb:(NSString *)url{
    WKWebView *webViewNew = [[WKWebView alloc] init];
    [[WebViewController singleton].webViews addObject:webViewNew];
    [self addNewWeb:webViewNew];
    return webViewNew;
}


-(void)addNewWeb:(WKWebView *)webView{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:webView];
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
