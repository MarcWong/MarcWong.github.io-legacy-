---
layout: post
title:  "Jekyll语法总结"
date:   2018-08-25
excerpt: "Jekyll 是一个静态网站生成器.
Jekyll 通过 标记语言 markdown 或 textile 和 模板引擎 liquid 转换生成网页."
tags: "jekyll"
---

# 1.文件介绍
> _config.yml

jekyll 的全局配置在 _config.yml 文件中配置.
比如网站的名字, 网站的域名, 网站的链接格式等等.

> _includes

对于网站的头部, 底部, 侧栏等公共部分, 为了维护方便, 我们可能想提取出来单独编写, 然后使用的时候包含进去即可.
这时我们可以把那些公共部分放在这个目录下.
使用时只需要引入即可.

``` ruby
{ % include filename % }
```

> _layouts

对于网站的布局,我们一般会写成模板的形式,这样对于写实质性的内容时,比如文章,只需要专心写文章的内容, 然后加个标签指定用哪个模板即可. 对于内容,指定模板了模板后,我们可以称内容是模板的儿子.
为什么这样说呢? 因为这个模板时可以多层嵌套的, 内容实际上模板,只不过是叶子节点而已.

在模板中, 引入儿子的内容.
``` ruby
{ { content } }
```
在儿子中,指定父节点模板

注意:必须在子节点的顶部.

``` ruby
---
layout: post
---
```

> _posts

写的内容,比如博客,常放在这里面, 而且一般作为叶子节点.

> _data

也用于配置一些全局变量,不过数据比较多,所以放在这里。

比如这个网站如果是多人开发, 我们通常会在这里面定义一个 members.yml 文件.

文件内容为
``` yml
- name: 袁小康
  github: tiankonguse
  oldnick : shen1000
  nick : skyyuan
```
然后在模板中我们就可以通过下面语法使用这些数据了.

```
site.data.members
```

> _site

jekyll 生成网站输出的地方, 一般需要在 .gitignore 中屏蔽掉这个目录.

> index.html

主页文件, 后缀有时也用 index.md 等.
这个需要根据自己的需要来写, 因为不同的格式之间在某些情况下还是有一些细微的差别的.

## 配置全局变量
虽然全局变量都有自己的默认配置, 但是我们往往会手动配置为自己心中最好的效果.

- 源代码的位置
这个一般不配置, 默认即可.
```
source: DIR
```
当然编译的时候也可以指定,但是使用 github 我们是不能指定参数的.

```
-s, --source DIR
```
- 输出网站位置
这个一般也默认.

```
# 编译参数 -d, --destination DIR
destination: DIR #配置语法
```

- Safe开关
官方文档上就一句话.
``
Disable custom plugins, and ignore symbolic links.
``
大概意思是禁用常用的插件,忽略符号链接.

``` ruby
# 编译参数  --safe
safe: BOOL
```

- 忽略文件
这个很有用, 有时候你写了一个文件, 里面的一个东西可能会被 jekyll 处理, 但是你不想让 jekyll 处理的话, 就使用这个语法忽略那些文件吧.
```
exclude: [DIR, FILE, ...]
```

- 强制处理文件
有时候我们的一些文件的名字由于不在 jekyll 处理的文件名字范围内,这时候就需要强制处理这些文件了.
比如 .htaccess 文件.
```
include: [DIR, FILE, ...]
```

- 时区
我们模板中经常会对时间进行转换,这个时候如果至指定时区的话,可能得到的时间会和我们想要的时间错几个小时.

```
# timezone: Asia/Shanghai
timezone: TIMEZONE
```

- 编码
``` ruby
# encoding : utf-8
encoding: ENCODING
```

# 2.模板语法
模板语法实际上分两部分, 一部分是头部定义,另一部分是语法.

## 2.1 头部定义
头部定义主要用于指定模板(layout)和定义一些变量, 比如 标题(title), 描述(description), 分类(category/categories), tags, 是否发布(published), 自定义变量.

``` ruby
---
layout:     post
title:      title
category: blog
description: description
published: true # default true
---
```

## 2.2 语法

### 使用变量

所有的变量是都一个树节点, 比如模板中定义的头部变量,需要使用下面的语法获得

```
page.title
```

page 是当前页面的根节点.

- 其中全局根结点有
```
site _config.yml 中配置的信息
page 页面的配置信息
content 模板中,用于引入子节点的内容
paginator 分页信息
```
- site 下的变量
```
site.time 运行 jekyll 的时间
site.pages 所有页面
site.posts 所有文章
site.related_posts 类似的10篇文章,默认最新的10篇文章,指定lsi为相似的文章
site.static_files 没有被 jekyll 处理的文章,有属性 path, modified_time 和 extname.
site.html_pages 所有的 html 页面
site.collections 新功能,没使用过
site.data _data 目录下的数据
site.documents 所有 collections 里面的文档
site.categories 所有的 categorie
site.tags 所有的 tag
site.[CONFIGURATION_DATA] 自定义变量
```
- page 下的变量
```
page.content 页面的内容
page.title 标题
page.excerpt 摘要
page.url 链接
page.date 时间
page.id 唯一标示
page.categories 分类
page.tags 标签
page.path 源代码位置
page.next 下一篇文章
page.previous 上一篇文章
```
- paginator 下的变量
```
paginator.per_page 每一页的数量
paginator.posts 这一页的数量
paginator.total_posts 所有文章的数量
paginator.total_pages 总的页数
paginator.page 当前页数
paginator.previous_page 上一页的页数
paginator.previous_page_path 上一页的路径
paginator.next_page 下一页的页数
paginator.next_page_path 下一页的路径
```
### 字符转义
有时候想输出 { 了,怎么办,使用 \ 转义即可.

``` ruby
\{ => {
```

### 输出变量
输出变量直接使用两个大括号括起来即可.

``` ruby
{{ page.title }}
```

### 循环
``` ruby
{ % for post in site.posts % }
    <a href="http://blog/2014/11/10/jekyll-study/{ { post.url } }">{ { post.title } }</a>
  { % endfor % }
```

### 自动生成摘要
``` ruby
  { % for post in site.posts % }
     { { post.url } } { { post.title } }
      { { post.excerpt | remove: 'test' } }
  { % endfor % }
```

### 删除指定文本
remove 可以删除变量中的指定内容
``` ruby
{ { post.url | remove: 'http' } }
```

### 删除 html 标签
这个在摘要中很有用.
``` ruby
{ { post.excerpt | strip_html } }
```
### 代码高亮
``` ruby
{ % highlight ruby linenos % }
\# some ruby code
{ % endhighlight % }
```

### 数组的大小
``` ruby
{ { array | size } }
```

### 赋值
``` ruby
{ % assign index = 1 % }
```

### 格式化时间
``` ruby
{ { site.time | date_to_xmlschema } } 2008-11-07T13:07:54-08:00
{ { site.time | date_to_rfc822 } } Mon, 07 Nov 2008 13:07:54 -0800
{ { site.time | date_to_string } } 07 Nov 2008
{ { site.time | date_to_long_string } } 07 November 2008
```

### 搜索指定key
``` ruby
# Select all the objects in an array where the key has the given value.
{ { site.members | where:"graduation_year","2014" } } 
```

### 排序
``` ruby
{ { site.pages | sort: 'title', 'last' } }
```

### to json
``` ruby
{ { site.data.projects | jsonify } }
```

### 序列化
把一个对象变成一个字符串
``` ruby
{ { page.tags | array_to_sentence_string } }
```

### 单词的个数
``` ruby
{ { page.content | number_of_words } }
```

### 指定个数
得到数组指定范围的结果集
``` ruby
{ % for post in site.posts limit:20 % }
```