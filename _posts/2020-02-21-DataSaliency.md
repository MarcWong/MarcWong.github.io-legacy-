---
layout: post
title:  "Data Saliency"
date:   2020-02-21
excerpt: "Investigations about Data Saliency Modeling"
image: "/images/blog200209/example.png"
tags: "paper"
---

# Data Saliency Modeling


Paper: [Modeling Human Comprehension of Data Visualizations](https://www.osti.gov/servlets/purl/1346474)

为什么要研究抽象数据的显著性？

- 在自然图片中表现较好的方法，在抽象数据中表现不佳（bottom-up models typically do not perform well for abstract visualizations）
- 抽象数据更受top-down因素的影像（Attention largely driven by top-down factors）
- 当前数据不足


Paper: [Data Visualization Saliency Model: A Tool for Evaluating Abstract Data Visualizations](https://www.osti.gov/pages/servlets/purl/1377597)

为什么要对抽象数据的显著性进行分析？

- 对于用户来说，视觉显著性和重要特征重叠度高时，用户能够更高效的完成任务。



# 统计指标

- NSS(Normalized Scanpath Saliency)
标准化扫描路径显著性，预测眼动路径与基准路径的显著性均值，越大越好
$$NSS = \frac{1}{N} \sum_{i=1}^N \bar{S}(i) \times Q(i), where\, N=\sum_i Q(i) \, and \, \bar{S}=\frac{S-\mu(S)}{\sigma{S}}$$


AUC(Area Under ROC) 
ROC:TPR与FPR为x、y轴的曲线
ROC曲线的下部面积，无法区分“错误预测位置离真实显著区域的远近”差异
根据上述问题进行了修正：

- $AUC_{Borji}$: Borji's area under the curve web matlab
- $AUC_{Judd}$: Judd's area under the curve(true positives vs. salient region thresholding) matlab
- $sAUC$ shuffled-AUC matlab

- SIM(Similarity Score) 相同位置像素个数的和

- CC(Linear Correlation Coefficient)
预测与基准的线性相关系数，绝对值越接近1，则越相似
$$CC=\frac{\sum_{x,y}(P(X,Y)-\mu_{p}.(Q(x,y)-\mu_{q}) )}{\sqrt{\mu^2_{P}\sigma^2_{Q}}}$$

- EMD(Earth Mover's Distance)
从预测图变换到基准图的最小转换概率分布 the minimal cost of transforming the probability distribution of the estimated saliency map S to that of the ground truth map G)？越小越好

- SIM(Similarity Metric)
对预测、基准图进行标准化后，计算对应像素最小值的和，值为1代表重合，0代表不重合
$$SIM=\sum_{i=1} min({S}' (i),{G}' (i)), \, where \, \sum_i {S}' (i)=1 \, and \, \sum_i {G}' (i)=1$$