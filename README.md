# LovePlay
## 背景：

- 为了对APP性能进行优化，学习使用ASyncDisplayKit，是建立这个项目的源头和动力。
- 国内对于ASDK进行讲解分析的文章不少，但是真正用于项目，或比较完整的开源项目还是不多。在网上四处寻觅，终于找到了 [**LovePlayNews**](https://github.com/12207480/LovePlayNews)（作者是个牛人），精仿 **网易爱玩** APP，项目结构清晰，用于学习是个非常不错的选择。

* 网易《爱玩》的优点，为什么选择《爱玩》？

```
1. 网易《爱玩》是个非常有代表性的项目，无论是模块划分，还是控件布局，中规中矩，没有太多酷炫的功能（精仿酷炫的APP，UI上会花费过多时间和精力），符合我们日常开发中的大部分情况，实在是练手最佳APP之一！
2. 同时，网易提供的接口和数据非常清晰，也没有对开发者做过多限制（验证、加密等），不但可以更方便地用于开发，还可以学习大厂API的优点。
3. 正是基于以上特点，极大地节约了对模块划分、接口理解所需时间，让我们有更多精力投入到功能开发当中。
```

* 为什么又会有ASDK版本以外的RAC、组件化、Swift等版本？

```
1. 对于RAC、组件化等框架或技术的学习，有时需要经过一个比较完整的项目（业务or需求），才能更有地效提升我们的理解。
2. 所以，在开发完ASDK版本项目后，觉得非常有必要把自己学习 RAC、组件化 等知识再次融于项目，反复练习以加深理解。
3. 解析下这里需要UIKit版的原因：ASDK毕竟是一个比较重量级的框架，项目对其依赖度较大。在开发 RAC版、组件化版 等版本时，同时引入ASDK会增加不必要的学习成本，对于不同技术点读者各取所需就好。
```

## 补充：

由于是用来学习和回顾技术的项目，所以并没有对代码进行过多封装，尽量保证各版本项目结构一致，方便查看和对照

## 建议：

- **UIKit版** 和 **ASDK版** 可以先任意完成一个版本，另一个版本copy一份代码，修改起来是非常快。如果目标不是学习 **ASDK**，直接基于 **UIKit版** 进行练习更好。
- 当前项目中，只取了 **LovePlayNews** 部分界面练习，目的是节约开发时间，但又保留了相对的完整性。
- 当然，读者也可根据实际情况，在日常练习中进行增删。比如：去掉项目中的 **社区** 模块。

## 规划：

该项目是在工作之余进行，所以更新不定期，但会尽量抓紧时间完成。

将会有如下几个（OC）版本：支持iOS8+

#### ASDK版：基于Facebook开源的ASyncDisplayKit框架

- ASDK：[**AsyncDisplayKit**](https://github.com/facebook/AsyncDisplayKit)
- 关于ASDK文章：[新大陆：AsyncDisplayKit](https://segmentfault.com/a/1190000007991853)

#### UIKit版：原生控件

- 自动布局： [**Masonry**](https://github.com/SnapKit/Masonry/issues)

#### RAC版：使用 [**ReactiveCocoa**](https://github.com/ReactiveCocoa/ReactiveCocoa)

- RAC V2.5：[V2.5](https://github.com/ReactiveCocoa/ReactiveCocoa/releases/tag/v2.5)

#### 组件化版：基于casa大神的组件化方案

- casa大神组件化方案文章：[iOS应用架构谈 组件化方案](http://casatwy.com/iOS-Modulization.html) + [在现有工程中实施基于CTMediator的组件化方案](http://casatwy.com/modulization_in_action.html)
- 这个仓库中的组件化工程只是为了立个flag，组件化项目具体实现请移步：[LovePlayModule](https://github.com/LovePlayModule)（持续更新中...）

#### Swift3版本：使用纯swift语言及第三方库

* 网络请求： [**Alamofire**](https://github.com/Alamofire/Alamofire) AFNetworking亲兄弟
* 自动布局： [**Snapkit**](https://github.com/SnapKit/SnapKit) Masonry亲兄弟

#### …...

后续有时间，将会使用其他方式重写以上版本

## 致谢

网易出品，必属精品： http://play.163.com

[**LovePlayNews**](https://github.com/12207480/LovePlayNews) 

[**AsyncDisplayKit**](https://github.com/facebook/AsyncDisplayKit)

[**Masonry**](https://github.com/SnapKit/Masonry/issues)

[**SDAutoLayout**](https://github.com/gsdios/SDAutoLayout)

[**ReactiveCocoa**](https://github.com/ReactiveCocoa/ReactiveCocoa)

http://casatwy.com

---



## 2017-02-19 更新：

* 周末两天，使用Masonry重写了 **UIKit-SDAutoLayout版** 中的布局，并补上了 **UIKit-SDAutoLayout版** 未能完成的 **评论+子评论** 布局

* 使用Masonry重写布局并没有花多少时间，比预计的时间要少，尤其是cell高度计算这部分的代码，这完全得归功于 iOS8+ 对cell动态高度的处理（前提是你必须正确地设置好约束）

  ```
  tableView.rowHeight = UITableViewAutomaticDimension;
  tableView.estimatedRowHeight = 100;
  ```

  注意点：当cell中存在webView这种异步加载，获取高度后需要返回固定高度的情况。用到的代理方法和处理方式如下：

  ```
  #pragma mark - tableView delegate
  - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
  {
      if (indexPath.row == 0) {
          return _webViewHeight;
      }
      return UITableViewAutomaticDimension;
  }
  ```

  ​

## 2017-02-15 更新：

* 前几天，才夸了为什么使用SDAutoLayout，主要是轻量、易上手、自动计算cell的高度等，今天就 piapia～ 打脸了
* 第一个问题：第一个cell高度显示不全，也有开发者遇到了同样的问题[https://github.com/gsdios/SDAutoLayout/issues/116](https://github.com/gsdios/SDAutoLayout/issues/116)，希望作者有时间解决下，以下是我的问题截图：[SDAutoLayout第一个cell高度显示不全](https://github.com/YunsChou/YsResource/blob/master/SDAutoLayout第一个cell高度显示不全.gif)
* 还有一个问题：当评论下还有子评论时（也就是盖楼），这个布局本身就稍微复杂，使用ASDK去实现真的是爽到爆，但用SDAutoLayout感觉不太好实现（项目中的 **UIKit-SDAutoLayout版** 目前还没有实现）。当然，子评论的布局也可以用frame手写，但（使用SDAutoLayout）父评论中的控件和子评论之间又如何添加和更新约束呢？可能作者提供了一些方法，匆忙上手的我还没用熟悉吧。
* 既然开始了，就要把它做好，SDAutoLayout没办法轻松解决以上问题，我又极力想要功能和界面得跟ASDK版保持一致，只能另选布局框架替换，还是用回Masonry吧。
* 拷贝一份 **UIKit-SDAutoLayout版** 代码重命名为 **UIKit版**，当使用Masonry替换SDAutoLayout时（pod引入），报错真是惨不忍睹。没办法，只能同时引入两个布局框架，再使用Masonry一步一步替换。




## 2017-02-12更新：

* 在这个时间线，基本上完了**UIKit-SDAutoLayout版** 和 **ASDK版** 的主要界面和功能，但有部分细节和遗留问题待解决

#### ~~UIKit-SDAutoLayout版：原生控件~~

- ~~自动布局： [**SDAutoLayout**](https://github.com/gsdios/SDAutoLayout)~~


- ~~为什么选择 **SDAutoLayout** ？~~

1. ~~因为其他自动布局框架解决cell自适应高度过于麻烦（比如：Masonry + UITableView-FDTemplateLayoutCell），尤其是在尝到 ASDK 布局带来的便利后，让我转向了一直关注但没有机会使用的 SDAutoLayout。实际使用过程中，SDAutoLayout 的语法使用易读、易懂、易维护、易上手，提供了非常简单（一句话）的方法，解决cell自适应高度问题。~~
2. ~~轻量级，对比masonry真的是非常非常轻量级。我选择第三方库的要求：能解决问题 + 易用、易维护 + 轻量级，功能如此强大却如此简洁，完全满足了我对第三方库的所有幻想。~~