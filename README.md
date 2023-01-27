# banana_distribution

This repo provides the source code for the paper:
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
