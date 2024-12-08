// www.apibug.com
#import <Foundation/Foundation.h>

@interface EtcHostsURLProtocol : NSURLProtocol
@end

@implementation EtcHostsURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSArray *blockedHosts = @[@"thirdwx.qlogo.cn", @"openmobile.qq.com", @"dlied1.tcdn.qq.com", @"127.0.0.1"];
    NSString *host = request.URL.host;
    return [blockedHosts containsObject:host];
}


+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}


- (void)startLoading {
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:self.request.URL
                                                             statusCode:403
                                                            HTTPVersion:@"HTTP/1.1"
                                                           headerFields:@{@"Content-Type": @"text/plain"}];
    //通知客户端接收到响应
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    //通知客户端加载完成
    [[self client] URLProtocolDidFinishLoading:self];
}


- (void)stopLoading {
}

@end

@implementation EtcHostsURLProtocol (Registration)

+ (void)load {
    [NSURLProtocol registerClass:[EtcHostsURLProtocol class]];
    NSLog(@"大风吹倒梧桐树，我叫刺客你记住");
}

+ (void)unload {
    [NSURLProtocol unregisterClass:[EtcHostsURLProtocol class]];
    NSLog(@"大风吹倒梧桐树，刺客死了你记住");
}

@end
