---
layout: post
title:  "What's in my iOS Toolbox? (2)"
description: After writing the previous article, I realized that there are a lot of tools that I left behind. I've used some of them eventually in projects. Some others are completely new for me but I'll try them in the future.
date:   2014-02-03 23:30:00
timeToRead: 5 minutes read
categories: tools development me
---

*Note: This is the continuation to [What's in my iOS Toolbox?][toolbox] article.*

[toolbox]: http://edsancha.com/blog/2014/01/28/whats-in-my-iOS-toolbox.html

After writing the previous article, I realized that there are a lot of tools that I left behind. I've used some of them eventually in projects. Some others are completely new for me but I'll try them in the future. I also think that it could be useful to write down some interesting 3rd party libraries that have a lot of future and some backend soultions for the every type of project.

## 3rd party libraries and frameworks

This section deserves a detailed article by itself, but there're some libraries that need to be considered in most projects and others that are changing paradigms in the industry.

- [AFNetworking][af] - A great networking framework, with some interesting tools too, AFRocketClient to subscribe to server updates, AFIncrementalStore and OAuth 1 & 2 Clients, among others. 
- [ReactiveCocoa][rac] - Objective-C framework for [Functional Reactive Programming][frc]. It provides APIs for composing and transforming streams of values. I'm following with great interest [ReactiveCocoaLayout][racl], AutoLayout in a reactive way.
- [Typhoon][ty] - There are a lot of Dependency Injection Frameworks for iOS, but Typhoon stands out with great features (I love the way it focus in Obj-C at the same time that supporting XML). 

You'll probably tell me that this list is super sort, but it's intended to be like that. There're other libraries included in other categories and a ton of smaller ones that are worth to be here. These ones are either basic (AFN) or paradigm changers (RAC and Typhoon). Be sure to subscribe to [Cocoa Controls][cocoacontrols] newsletter to get the latest ones.

[af]: http://github.com/AFNetworking
[rac]: https://github.com/ReactiveCocoa
[frc]: http://en.wikipedia.org/wiki/Functional_reactive_programming
[racl]: https://github.com/ReactiveCocoa/ReactiveCocoaLayout
[ty]: http://www.typhoonframework.org 
[cocoacontrols]:  http://cocoacontrols.com

## Core Data

I have a love/hate relationship with [Core Data][CoreData] and I think most iOS Developers will have the same feeling. That said, it's better to have some tools to help working with it.

- [Mogenerator][mo] - Command-line tool that, given an .xcdatamodel file, will generate two classes per entity, making easier to extend the user classes with your own methods.
- [Magical Record][mr] - Wrapper around Core Data that makes simple requests in one line and keeps the power of NSFetchRequest.
- [Liya][liya] - MySQL, PostgreSQL and SQLite3 databases free editor.  
- [Core Data Editor][cde] ($) - Core Data Editor allows the user to read and edit Core Data schemes and create them (with Mogenerator two classes syntax).

Checkout the excellent article about different Core Data frameworks and Libraries in [NSHipster][NSHipsterCD].

[mo]: http://rentzsch.github.io/mogenerator/
[mr]: https://github.com/magicalpanda/MagicalRecord
[liya]: https://cutedgesystems.com/software/Liya/
[cde]: http://thermal-core.com/CoreDataEditor/
[CoreData]: https://developer.apple.com/library/mac/documentation/cocoa/Conceptual/CoreData/cdProgrammingGuide.html
[NSHipsterCD]: http://nshipster.com/core-data-libraries-and-utilities/

## Automated testing

Automated testing is always a hard choice. You need to write scripts or code to interact to your interface, making your work (or your company's) almost the double.

- [UIAutomation][uia] - User interface testing tool included in Instruments. You write the scripts in JavaScript. Check also [Bwoken][bwoken], tool to run UIAutomation Tests from Terminal.
- [appium.io][appium] - Open-source and cross-platform framework to write tests in almost any language. Looks very promising.
- [KIF][kif] - KIF, which stands for Keep It Functional, is an iOS integration test framework. It allows for easy automation of iOS apps by leveraging the accessibility attributes that the OS makes available for those with visual disabilities.
- [Subliminal][subliminal] - Subliminal is an framework for writing iOS integration tests. Subliminal provides a familiar OCUnit/SenTest-like interface to Apple's UIAutomation framework, with tests written entirely in Objective-C.
- [Calabash][calabash] - Calabash enables you to write and execute automated acceptance tests of Android and iOS mobile apps. Test scripts have to be written mainly in [Cucumber][cucumber] and also other Ruby testing frameworks.
- [Frank][frank] - Frank allows you to write structured text test/acceptance tests/requirements (using Ruby/[Cucumber][cucumber]) and have them execute against your iOS application.

[uia]: https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/UsingtheAutomationInstrument/UsingtheAutomationInstrument.html
[bwoken]: https://github.com/bendyworks/bwoken
[appium]: http://appium.io
[kif]: https://github.com/kif-framework/KIF
[subliminal]: https://github.com/inkling/Subliminal
[calabash]: http://calaba.sh
[frank]: http://www.testingwithfrank.com
[cucumber]: http://cukes.info


## Documentation

- [Appledoc][doc] - Appledoc generates official docsets and HTML web sites like Apple's or even better!.
- [Dash][dash] ($) - This tool has become super important in my set up with time. Checking API's super fast and been able to handle the code snippets in the cloud is great.

[doc]: http://gentlebytes.com/appledoc/
[dash]: http://kapeli.com/dash

## Backend Services

- [Parse][parse] - Great Backend-as-a-Servicedrop-in that works along all platforms, it has the easiest to read documentation and sample projects, so it's highly recommeneded for beginners and small projects. 
- [Stackmob][stackmob] - Another great BaaS platform with great free plans. You can import your backend code and it has a free stack of functionalities in their "marketplace". 
- [Helios][helios] - Open-source framework for iOS that provides push-notifications, passbook integration, app-purchases and data synchronization.
- [UrbanAirship][urban] - Easy to integrate push notifications, with limited usage for free.

There are another BaaS options that offer similar services like: [Windows Azure][azure], [Kinvey][kinvey], [Backendless][bless], [Shephertz][shep] ...

[parse]: https://www.parse.com
[stackmob]: https://www.stackmob.com
[helios]: http://helios.io
[urban]: http://urbanairship.com
[azure]: http://www.windowsazure.com/
[kinvey]: http://www.kinvey.com
[bless]: https://backendless.com/
[shep]: http://api.shephertz.com

## Analytics

- [Appsee][appsee] - Appsee enables you to put yourself in the users’ shoes and visually understand exactly how your users interact with your app with user recordings, touch heatmaps and other functionalities. The free segment is a bit short but it's still a tool to consider. 
- [Segment.io][segment] - The idea behind is to have one pipeline for all your data. Send data to any analytics or marketing tool with a single integration. I think it's ideal if you don't know which analytics tool to use in the beginning.
- [Testflight SDK][testflight] - Testfligh offers analytics and crash reports in its SDK too.

Other solutions worth naming are: [Localytics][local], [MobileAppTracking][mat], [keen.io][keen], [Gekkoboard][gekko] ...

[appsee]: http://www.appsee.com
[segment]: https://segment.io
[testflight]: http://testflight.com/
[local]: http://www.localytics.com
[mat]: http://mobileapptracking.com
[keen]: https://keen.io
[gekko]: http://www.gekkoboard.com

## App Sales Reports 

- [AppAnnie][annie] - It gives you free data about the stats of your app. If you create an account fot analytics in your developer portal and connect it you'll also get sales reports.
- [Appfigures][appfigures] - It combines sales & download numbers, world-wide reviews & ranks and it has public API's and other nice features. Track up to 5 apps for free. 

[annie]: http://www.appannie.com
[appfigures]: http://appfigures.com

The article is getting long enough, but it should be a good continuation to the previous post. I still have some sections to fill: iOS books, logging, debugging, reverse engineering (although limited), applications to help marketing the app... But I think it's better to leave it for an upcoming article. As always, I love your suggestions in the comments section and [twitter][twitter]. Thanks!!!

[twitter]: https://twitter.com/edsancha