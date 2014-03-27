---
layout: post
title:  "On Multiple Collection Views"
description: Today, I found a strange behavior in UICollectionView and I wanted to share it with you.  
date:   2014-03-27 01:30:00
timeToRead: 5 minutes read
categories: iOS development 
---

Today, I found a strange behavior in UICollectionView and I wanted to share it with you.  

I was trying to force the app I'm working on, [Jackthreads](https://itunes.apple.com/us/app/jackthreads-for-ipad/id640570922?mt=8) to crash when I came into a weird behavior that normally leads to a crash. 

Here's the scenario: 

- You have a view controller with several collection views (or table views).
- You select a cell from each collection view, it can work with two. 
- Strange things happen to your stack. The navigation controller pushes several view controlles but it can't handle them properly, so when it comes back it gets lost or crashes the application.

I've been able to reproduce this scenario in Twitter and Foursquare app. Twitter didn't crash, Foursquare did. It's not a common user behavior, but it's always nice to control these unexpected scenarios. 

The solution is pretty simple. You just "block" the interaction of other cells until you've finished interacting with the first cell. The funny thing is that the documentation is some how misleading. UICollectionViewDelegate says: 

{% highlight Objective-C %}
 // Methods for notification of selection/deselection and 
 // highlight/unhighlight events.
 // The sequence of calls leading to selection from a user touch is:

 // (when the touch begins)
 // 1. -collectionView:shouldHighlightItemAtIndexPath:
 // 2. -collectionView:didHighlightItemAtIndexPath:

 // (when the touch lifts)
 // 3. -collectionView:shouldSelectItemAtIndexPath: or 
 //    -collectionView:shouldDeselectItemAtIndexPath:
 // 4. -collectionView:didSelectItemAtIndexPath: or 
 //    -collectionView:didDeselectItemAtIndexPath:
 // 5. -collectionView:didUnhighlightItemAtIndexPath:
{% endhighlight %}

According to this, if you just block the selection of other cells and unblock it after the selection has been made it should work:

{% highlight Objective-C %}

- (BOOL)        collectionView:(UICollectionView *)collectionView 
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	if (!self.selectionBlocked){
        self.selectionBlocked = YES;
        return YES;
    } else {
        return NO;
    }
}
- (void)  collectionView:(UICollectionView *)collectionView 
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectionBlocked = NO;
    ... 
}

{% endhighlight %}

But it didn't in fact it left other collection views irresponsive after highllighting one cell. I said, well, this is strange. So I made a logical next step: log everthing in the delegate and see if everything was right. 

{% highlight Objective-C %}

2014-03-27 01:14:34.393 MultipleCollectionViews[379:60b] -[EDSViewController 
collectionView:shouldHighlightItemAtIndexPath:]
2014-03-27 01:14:34.396 MultipleCollectionViews[379:60b] -[EDSViewController 
collectionView:didHighlightItemAtIndexPath:]
2014-03-27 01:14:34.399 MultipleCollectionViews[379:60b] -[EDSViewController 
collectionView:didUnhighlightItemAtIndexPath:]
2014-03-27 01:14:34.400 MultipleCollectionViews[379:60b] -[EDSViewController 
collectionView:shouldSelectItemAtIndexPath:]
2014-03-27 01:14:34.404 MultipleCollectionViews[379:60b] -[EDSViewController 
collectionView:didSelectItemAtIndexPath:]

{% endhighlight %}

What was my surprise when I saw that the order claimed by Apple is wrong -collectionView:didUnhighlightItemAtIndexPath: is not being called the last one, it's being called right before -collectionView:shouldSelectItemAtIndexPath: 

My solution was to unblock the new selection on -collectionView:didUnhighlightItemAtIndexPath: method and hold a reference to "something" in case the selection is finally being made. In my case I chose to keep a reference to the collectionview where the selected cell is. 

{% gist 9800975%}

You can also check the [example project in github](https://github.com/EdSancha/MultipleCollectionViews-Bug). 
Have you also found this problem while working with Collection Views? 