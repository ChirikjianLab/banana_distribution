# The Banana Distribution is Gaussian: A Localization Study with Exponential Coordinates

This repo provides the codes for the paper:
> [**The Banana Distribution is Gaussian: A Localization Study with Exponential Coordinates**](http://roboticsproceedings.org/rss08/p34.pdf)
> Andrew W. Long, Kevin C. Wolfe, Michael J. Mashner, Gregory S. Chirikjian

<img src="/figure/banana.png"  width="600"/>

<font size=2>(a) Distributions for the differential drive robot moving ideally along a straight line with diffusion constant DT=4.
(b) Distributions for the differential drive robot moving ideally along a constant-curvature arc with diffusion constant DT=4.
\(c\) Distributions as a function of exponential coordinates $(v_1, v_2)$ with pdf contours marginalized over the heading for the Gaussian in exponential coordinates for driving along an arc with diffusion constant DT = 4.
(d) Distributions as a function of exponential coordinates $(v_1, v_2)$ with pdf contours marginalized over the heading for the Gaussian in exponential coordinates for driving straight with diffusion constant DT = 4.

## Abstract
Distributions in position and orientation are central to many problems in robot localization. To increase efficiency, a majority of algorithms for planar mobile robots use Gaussians defined on positional Cartesian coordinates and heading. However, the distribution of poses for a noisy two-wheeled robot moving in the plane has been observed by many to be a “bananashaped” distribution, which is clearly not Gaussian/normal in these coordinates. As uncertainty increases, many localization algorithms therefore become “inconsistent” due to the normality assumption breaking down. We observe that this is because the combination of Cartesian coordinates and heading is not the most appropriate set of coordinates to use, and that the banana distribution can be described in closed form as a Gaussian in an alternative set of coordinates via the so-called exponential map. With this formulation, we can derive closed-form expressions for propagating the mean and covariance of the Gaussian in these exponential coordinates for a differential-drive car moving along a trajectory constructed from sections of straight segments and arcs of constant curvature. In addition, we detail how to fuse two or more Gaussians in exponential coordinates together with given relative pose measurements between robots moving in formation. These propagation and fusion formulas utilized here reduce uncertainty in localization better than when using traditional methods. We demonstrate with numerical examples dramatic improvements in the estimated pose of three robots moving in formation when compared to classical Cartesiancoordinate-based Gaussian fusion methods.

## Inplementations
This repo provides implementation in MATLAB. The algorithm was implemented in MATLAB 2022a.  For all the examples in the code, the wheel base $l$ is 0.200 and the radius $r$ of each wheel is 0.033. 

1) Run the main.m.

2) Use 'mode = 1' to control the differential-drive robot moving along a straight line, 'mode = 2' controls the differential-drive robot moving along an arc of radius $a$ = 1 at rate $\dot{\alpha}$ = 1. $D$ is the diffusion constant.

# Additions
All code in this repository is non-source code and was written to reproduce this paper. They could function as a reference for someone interested in this work. The codes are programmed and tested in MATLAB 2022b.

## 1. Introduction
This work was published several years ago and proposed to use of exponential coordinates and Lie groups to represent the robot’s pose. And the results in these coordinates perform better than a Gaussian in Cartesian coordinates. If you are interested in this paper, welcome to click [this link](https://www.roboticsproceedings.org/rss08/p34.pdf) for more details.

## 2. Authors of the paper
Andrew W. Long, Kevin C. Wolfe, Michael J. Mashner, [Gregory S. Chirikjian](https://scholar.google.com/citations?user=qoIuyMoAAAAJ&hl=en&oi=sra)

Thanks for their interesting work. If you find this paper helpful, welcome to cite it to show your thanks to the authors.

```
@article{long2013banana,
  title={The banana distribution is Gaussian: A localization study with exponential coordinates},
  author={Long, Andrew W and Wolfe, Kevin C and Mashner, Michael J and Chirikjian, Gregory S},
  year={2013}
}
```

## 3. Implementation
First, open MATLAB and choose the main directory of this repo as the current folder.

There are two files in the main directory, data and functions. Just work as their name, they store the data and functions used in main programs, just leave them here.

There are several other files that contain different functions, which will be introduced as follows:

### 3.1 data_collect.m
Run this program to collect the data. The stochastic differential equations (SDE) used in this program are provided in the paper. There are already seven different data for straight action and four for curvature action. You can copy and edit the parameter **D**, **w1**, **w2**, and **savename** (For example, `save('data\data_s1.mat', 'data');` -> `save('data\data_xx.mat', 'data');`) to create new data for testing. 

### 3.1 main_straight.m
Run this program to get the left figure 2 of the paper. 

<img src="/fig/figure2_left.png" width="500">

The seventh line could be changed to load different data (data_s1, data_s2, data_s3, data_s4, data_s5, data_s6, data_s7). For example, `load("data_s1.mat");` -> `load("data_s7.mat");`.
Then run again to print a new figure in the case of **DT = 7**.

<img src="/fig/figure2_right.png" width="500">

### 3.2 main_curvature.m
Run this program to get the left figure 3 of the paper.

<img src="/fig/figure3_left.png" width="500">

This program is very similar to the **main_straight.m**, with only a few changes for drawing figures. The seventh line could also be changed to load different data (data_c1, data_c2, data_c3, data_c4). The following figure is an example of running this program with load **data_c4**.

<img src="/fig/figure3_right.png" width="500">

### 3.3 main_exp.m
Run this program to get the left figure 4 of the paper.

<img src="/fig/figure4_left.png" width="500">

Change the seventh line of the program from `load("data_s1.mat");` -> `load("data_c1.mat");`, then get the right figure 4.

<img src="/fig/figure4_right.png" width="500">

### 3.4 data_LL.m
This program is used to calculate the log-likelihood in two different coordinates and store these data. They will be processed to print figure in the next file **main_LL.m**.

### 3.5 main_LL.m
Run this program to get the figure 5 of the paper.

<img src="/fig/figure5.png" width="500">

### 3.6 main_errprop.m
This program is related to section VI, about how to propagate the mean and covariance and demonstrate the accuracy of this propagation method.
