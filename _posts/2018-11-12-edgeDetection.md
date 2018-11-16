---
layout: post
title:  "[笔记]edge detection综述"
date:   2018-11-12
excerpt: "edge detection综述,传统滤波,人造特征,基于patch的学习和深度学习"
image: "/images/blog1112/2018-11-16-15-14-40.png"
tags: "edge detection"
---

# 1. 传统边缘检测算子

``...edge points are far more plentiful and often carry important semantic associations.``


## 1.1 a.基于滤波的方法

梯度: 

$$\bm{J}(\bm{x}) = \nabla I(\bm{x}) = \frac{\partial I}{\partial x}$$

![](/images/blog1112/2018-11-16-15-14-40.png)

- roberts 对角差分

![](/images/blog1112/2018-11-16-15-16-11.png)

- prewitt 一阶模版

![](/images/blog1112/2018-11-16-15-16-19.png)

- sobel 一阶模版

![](/images/blog1112/2018-11-16-15-16-25.png)
![](/images/blog1112/2018-11-16-15-41-20.png)

- laplacian 二阶，各向同性

![](/images/blog1112/2018-11-16-15-16-30.png)

- canny 应用最广

1. 高斯滤波平滑图像
2. 一阶偏导求梯度强度及方向
3. 非最大抑制（non-maximum suppression）

![](/images/blog1112/2018-11-16-15-18-13.png)
1. 双阈值边缘连接

## 1.2 其他方法

- [hough变换](http://www.dtic.mil/dtic/tr/fulltext/u2/a457992.pdf)

- [snake(active contour model)](http://graphics.hallym.ac.kr/teach/2009/tcg/src/IJCV98Kass.pdf)

$$\bm{J}(𝑠𝑛𝑎𝑘𝑒) = \bm{J}(int)+\bm{J}(ext)+\bm{J}(cons)$$

$$\bm{J}(int) = \bm{J}(coutin)+\bm{J}(smooth) = \alpha(s)|\frac{dC}{ds}|^2 + \beta(s)|\frac{d^2C}{ds^2}|^2$$

$$\bm{J}(ext) = \gamma(s)|\nabla I^2|$$

# 2. 基于信息论与人造特征的方法

- [statistical edges](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1159946)

- [Pb: Learning to detect natural image boundaries using local brightness, color, and texture cues](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.436.589&rep=rep1&type=pdf)
- [gPb: Contour Detection and Hierarchical Image Segmentation](http://web.archive.org/web/20160306144814/http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/papers/amfm_pami2010.pdf)

# 3. 基于神经网路的边缘检测

## 3.1 patch based

- [N4-field](https://arxiv.org/pdf/1406.6558.pdf)

![](/images/blog1112/2018-11-16-15-25-10.png)

- [DeepEdge](https://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Bertasius_DeepEdge_A_Multi-Scale_2015_CVPR_paper.pdf)

![](/images/blog1112/2018-11-16-15-25-20.png)
#### 对N4-Fields工作的延伸。首先使用Canny edge得到候选轮廓点，然后对这些点建立不同尺度的patch，将这些 patch 输入两路的CNN，一路用作分类，一路用作回归。最后得到每个候选轮廓点的概率。

- [DeepContour](https://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Shen_DeepContour_A_Deep_2015_CVPR_paper.pdf)

![](/images/blog1112/2018-11-16-15-25-54.png)

#### 在训练集上对边缘图像先进行聚类，得到不同类别。 这一个聚类的步骤，正好将边缘检测转换成了图片分类的问题。
#### 利用CNN，训练分类的模型。训练的损失函数由2部分构成，第一部分是常用的Softmax的损失函数；第二部分主要强化：允许错误出现在不同边缘的类之间，但不允许将边缘的正类划分成不含有边缘的负类。

- [HFL](https://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Bertasius_High-for-Low_and_Low-for-High_ICCV_2015_paper.pdf)

![](/images/blog1112/2018-11-16-15-26-23.png)

- [Structed Edge](https://arxiv.org/pdf/1406.5549.pdf)

## 3.2 end-to-end

- [Holistically-nested Edge Detection](https://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Xie_Holistically-Nested_Edge_Detection_ICCV_2015_paper.pdf)

![](/images/blog1112/2018-11-16-15-30-23.png)

#### 本文网络结构，主要思想是每一个卷积层后面增加了一个side output layer，每个side output layer输出一个edge map，然后通过一个fusion layer将各个side output层输出的edge map进行融合，得到最后的边缘检测结果。

![](/images/blog1112/2018-11-16-15-26-37.png)

#### (a) multi-stream网络结构，即多个尺度crop，每个尺度都是一个feature map流，最后整合在一起。基于多kernel size和Dilated convolution的方法使用这种框架的比较多。
#### (b)skip-layer网络结构，所有基于FCN的网络基本都采用这种形式，与multi-stream不同，根据输入的多层次来控制特征响应，再整合到一个feature map中
#### (c)多尺度输入实现方式，类似图像金字塔
#### (d)多网络实现方式，通过调整cnn降采样的次数控制信息的层级
#### (e)本文网络结构，主要思想是每一个卷积层后面增加了一个side output layer，每个side output layer输出一个edge map，然后通过一个fusion layer将各个side output层输出的edge map进行融合，得到最后的边缘检测结果。

![](/images/blog1112/2018-11-16-15-30-07.png)

- [ITERATIVE RESIDUAL NETWORK FOR STRUCTURED EDGE DETECTION ](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8466129)

![](/images/blog1112/2018-11-16-15-29-54.png)
![](/images/blog1112/2018-11-16-15-29-44.png)

- [Semantic Image Segmentation with Task-Specific Edge Detection Using CNNs and a Discriminatively Trained Domain Transform](https://www.cv-foundation.org/openaccess/content_cvpr_2016/papers/Chen_Semantic_Image_Segmentation_CVPR_2016_paper.pdf)
- [RCF: Richer Convolutional Features for Edge Detection](http://mftp.mmcheng.net/liuyun/rcf/cvpr17-rcf.pdf)

![](/images/blog1112/2018-11-16-15-29-35.png)

![](/images/blog1112/2018-11-16-15-40-28.png)

#### 传统方法的问题在于信息利用不充分，相当于只使用了Pooling前最后一个卷积层的信息
#### RCF改造了VGG-16的结构，通过增加side-output来显式地融合多尺度信息


# 4. 数据集
- [标准数据集BSDS](http://web.archive.org/web/20160306144814/http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/papers/amfm_pami2010.pdf)