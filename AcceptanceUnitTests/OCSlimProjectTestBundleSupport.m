//
//  OCSlimProjectTestBundleSupport.m
//  OCSlimProjectTestBundleSupport
//
//  Created by OCSlimProject on 20/11/2017.
//  MIT License
//  © 2016 Paul Stringer
//
//

#if __has_include(<OCSlimProjectTestBundleSupport/OCSPTestSuite.h>)
#else
#pragma GCC error "Target requires pod 'OCSlimProjectTestBundleSupport'. Add the entry \"pod 'OCSlimProjectTestBundleSupport'\" to your Podfile configuration."
#endif

/* Copy and paste this entry to your projects Podfile and run 'pod install' or 'pod update' as necessary

 target 'AcceptanceUnitTests' do
    platform :osx, '10.8'
    pod 'OCSlimProjectTestBundleSupport', '~> 1.3'
 end
 
  https://cocoapods.org/?q=OCSlimProjectTestBundleSupport

*/
