---
layout: post
title:  "[笔记]edge detection综述"
date:   2018-11-12
excerpt: "edge detection综述,传统滤波,人造特征,基于patch的学习和深度学习"
tags: "edge detection"
---

# 1. 传统边缘检测算子

``...edge points are far more plentiful and often carry important semantic associations.``


## 1.1 a.基于滤波的方法

梯度: 

$$\bm{J}(\bm{x}) = \nabla I(\bm{x}) = \frac{\partial I}{\partial x}$$

- roberts 对角差分
- prewitt 111
- sobel 121
- laplacian 二阶
- canny 一阶梯度+非极大抑制+双阈值

## 1.2 其他方法

- [hough变换](http://www.dtic.mil/dtic/tr/fulltext/u2/a457992.pdf)
- [snake(active contour model)](http://graphics.hallym.ac.kr/teach/2009/tcg/src/IJCV98Kass.pdf)

# 2. 基于信息论与人造特征的方法

- [statistical edges](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1159946)

- [Pb: Learning to detect natural image boundaries using local brightness, color, and texture cues](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.436.589&rep=rep1&type=pdf)
- [gPb: Contour Detection and Hierarchical Image Segmentation](http://web.archive.org/web/20160306144814/http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/papers/amfm_pami2010.pdf)

# 3. 基于神经网路的边缘检测

## 3.1 patch based

- [N4-field](https://arxiv.org/pdf/1406.6558.pdf)
- [DeepEdge](https://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Bertasius_DeepEdge_A_Multi-Scale_2015_CVPR_paper.pdf)
- [DeepContour](https://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Shen_DeepContour_A_Deep_2015_CVPR_paper.pdf)
- [HFL](https://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Bertasius_High-for-Low_and_Low-for-High_ICCV_2015_paper.pdf)
- [Structed Edge](https://arxiv.org/pdf/1406.5549.pdf)

## 3.2 end-to-end

- [Holistically-nested Edge Detection](https://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Xie_Holistically-Nested_Edge_Detection_ICCV_2015_paper.pdf)
- [ITERATIVE RESIDUAL NETWORK FOR STRUCTURED EDGE DETECTION ](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8466129)
- [Semantic Image Segmentation with Task-Specific Edge Detection Using CNNs and a Discriminatively Trained Domain Transform](https://www.cv-foundation.org/openaccess/content_cvpr_2016/papers/Chen_Semantic_Image_Segmentation_CVPR_2016_paper.pdf)
- [RCF](http://mftp.mmcheng.net/liuyun/rcf/cvpr17-rcf.pdf)

# 4. 数据集
- [标准数据集BSDS](http://web.archive.org/web/20160306144814/http://www.eecs.berkeley.edu/Research/Projects/CS/vision/grouping/papers/amfm_pami2010.pdf)