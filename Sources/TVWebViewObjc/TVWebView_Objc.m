//
//  WebView.m
//  Browser
//
//  Created by nasir on 24/08/2023.
//

#import "TVWebView_Objc.h"

@interface TVWebView_Objc()
@property id webview;
@end

@implementation TVWebView_Objc

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initWebView];
}

- (void)commonInit {
    [self initWebView];
}

-(void)initWebView {
    [self.webview removeFromSuperview];

    self.webview = [[NSClassFromString(@"UIWebView") alloc] init];
    [self.webview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.webview setClipsToBounds:NO];
    
    [self addSubview: self.webview];

    [self.webview setFrame:self.bounds];
    [self.webview setDelegate:self];
    [self.webview setLayoutMargins:UIEdgeInsetsZero];
    UIScrollView *scrollView = [self.webview scrollView];
    [scrollView setLayoutMargins:UIEdgeInsetsZero];
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    scrollView.contentOffset = CGPointZero;
    
    scrollView.contentInset = UIEdgeInsetsZero;
//    scrollView.frame = self.view.bounds;
    scrollView.clipsToBounds = NO;
    [scrollView setNeedsLayout];
    [scrollView layoutIfNeeded];
    scrollView.bounces = NO;
    scrollView.panGestureRecognizer.allowedTouchTypes = @[ @(UITouchTypeIndirect) ];
    scrollView.scrollEnabled = NO;
    
    [self enableInteraction:NO];
}

- (void) loadURL: (NSURL*)url {
    [self.webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void) reload {
    [self.webview reload];
}

-(void) enableInteraction: (BOOL)isEnabled
{
    UIScrollView *scrollView = [self.webview scrollView];
    scrollView.scrollEnabled = isEnabled;
    [self.webview setUserInteractionEnabled:isEnabled];
}

- (nullable NSString*) evaluateJavascript: (NSString*)js {
    return [self.webview stringByEvaluatingJavaScriptFromString: js];
}

#pragma mark - UIWebViewDelegate
-(void) webViewDidStartLoad:(id)webView {
    
}

-(void) webViewDidFinishLoad:(id)webView {
    
}

- (BOOL)webView:(id)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType {
    return YES;
}

- (void)webView:(id)webView didFailLoadWithError:(NSError *)error {
    [self.delegate didFailWithError: error];
}

@end
