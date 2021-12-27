---
title: 变换
date: 2021-12-23 17:45:18
tags:
---
<script type="text/javascript" async
  src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML">
  MathJax.Hub.Config({
    extensions: ["tex2jax.js"],
    jax: ["input/TeX", "output/HTML-CSS"],
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
      processEscapes: true
    },
    "HTML-CSS": { fonts: ["TeX"] }
  });
</script>



### 变换的种类

常见的基础图形变换可以分为一下几类

- 旋转 rotate
- 缩放 scale
- 切变 shear
- 平移 translate
- 仿射 affine（线性变换 + 平移）

1. 旋转 rotation

   1. 二维空间

      在二维空间中，如果要对一个点进行旋转的话，（这个旋转的参照点就是笛卡尔坐标系中的原点，当然这个进行旋转的点也必须要在笛卡尔坐标系中），我们可以通过一个二维矩阵1.0（旋转矩阵）与这个点的坐标进行乘法运算之后可以实现（推倒过程忽略）

   $$
   R_\theta = \begin{pmatrix}
      cos\theta & -sin\theta \\
      sin\theta & cos\theta
      \end{pmatrix}
      \tag{1.0}
   $$

   2. 三维空间

      但是在三维空间中，如果涉及到旋转，那就是针对任一物体绕某个轴进行旋转，因为在三维空间中，有这样的旋转规律： 如果对某个刚体在三维空间中进行任意次的旋转，只要旋转中心保持不变，这些旋转都能通过绕空间中的某个轴旋转一次实现。

      可以用[**欧拉角**](https://zh.wikipedia.org/wiki/%E6%AC%A7%E6%8B%89%E8%A7%92)来描述刚体在三维欧几里得空间的取向。对于任何参考系，一个刚体的取向，是依照顺序，从这个参考系，做三个欧拉角的旋转而设定的。所以，刚体的取向可以用三个基本的旋转矩阵来决定，任何刚体的旋转矩阵是由三个基本旋转矩阵复合而成的。

      <img src="https://upload.wikimedia.org/wikipedia/commons/8/85/Euler2a.gif" alt="刚体旋转" title="刚体旋转" style="zoom:50%;" />

      三维空间的旋转矩阵定义为$R_x(\theta), R_y(\theta), R_z(\theta)$，它们分别可以把一个向量绕$x, y, z$轴旋转$\theta$弧度：
      $$
      R_x(\theta) = 
      \begin{pmatrix}
      1 & 0 & 0 & 0 \\
      0 & cos\theta & -sin\theta & 0 \\
      0 & sin\theta & cos\theta & 0 \\
      0 & 0 & 0 & 1
      \end{pmatrix}
      \tag{1.2}
      $$

      $$
      R_y(\theta) = 
      \begin{pmatrix}
      cos\theta & 0 & sin\theta &0 \\
      0 & 1 & 0 & 0 \\
      -sin\theta & 0 & cos\theta & 0\\
      0 & 0 & 0 & 1
      \end{pmatrix}
      \tag{1.3}
      $$

      $$
      R_z(\theta) = 
      \begin{pmatrix}
      cos\theta & -sin\theta & 0 & 0 \\
      sin\theta & cos\theta & 0 & 0 \\
      0 & 0 & 1 & 0 \\
      0 & 0 & 0 & 1
      \end{pmatrix}
      \tag{1.4}
      $$

      所以任意3D旋转可以表示为$R_xyz(\alpha, \beta, \gamma) = R_x(\alpha)R_y(\beta)R_z(\gamma)$ 

2. 缩放

   **缩放矩阵S** 对缩放目标分别在x,y,z方向缩放$ s_x，s_y，s_z $倍

     
   $$
   S=\begin{pmatrix}
   s_x & 0 & 0 & 0\\
   0 & s_y & 0  & 0\\
   0 & 0 & s_z & 0 \\
   0 & 0 & 0 & 1
   \end{pmatrix}
   \tag{1.5}
   $$

3. 切变

   

4. 平移

   在介绍平移之前，可以先对上面三种变换做个总结，就是它们都是通过一个矩阵的乘法运算得出了最终变换的结果，可以将这种变换统称为**线性变换**。但是一般平移的运算公式为：
   $$
   \begin{pmatrix} x'\\ y'\end{pmatrix}\tag{1.6} = 
   \begin{pmatrix} x \\ y \end{pmatrix} + 
   \begin{pmatrix} t_x \\ t_y \end{pmatrix}
   $$
   这种就不属于线性变换，当然就需要一种方法让它变成线性变换从而能够统一变换的运算方式。

   于是可以通过增加一个维度的方式，将需要运算的数据包括进一个矩阵中，比如点$(x, y)$ 就可以用$(x, y, 1)$来表示，更抽象一点的表示就是$(x, y, w) (w\not=0)$，而这表示的具体的点就是$(x/w, y/w)$。所以平移的线性表示方式为：
   $$
   \begin{pmatrix} x' \\ y' \\ 1 \end{pmatrix} = 
   \begin{pmatrix} 
   1 & 0 & t_x \\
   0 & 1 & t_y \\
   0 & 0 & 1
   \end{pmatrix}
   \begin{pmatrix} x \\ y \\ 1 \end{pmatrix} \tag{1.7}
   =\begin{pmatrix} x + t_x \\ y + t_y \\ 1 \end{pmatrix}
   $$
   我们称这个变换矩阵为**齐次矩阵**，这个矩阵除了能表示平移变换之外还能区分点和向量，当$w=0$时表示的就是向量，不为零表示的就是点。

5. 仿射变换

   仿射变换 = 线性变换 + 平移

   用齐次矩阵可表示为
   $$
   \begin{pmatrix} x' \\ y' \\ 1 \end{pmatrix} = 
   \begin{pmatrix} 
   a & b & t_x \\
   c & d & t_y \\
   0 & 0 & 1
   \end{pmatrix}
   \begin{pmatrix} x \\ y \\ 1 \end{pmatrix} \tag{1.8}
   $$

观测变换 viewing transformation

- view（视图）/ camera transformation
- projection transformation 投影变换
  - Orthographic projection 正交投影
  - Perspective projection 透视投影

1. 视图变换

   



### 变换的规律

1. 变换与逆变换

   经过变换之后的图形，如果要恢复其原来的样子，可以经过逆变换来实现，而在线性代数中，逆变换矩阵就是变换矩阵的逆矩阵。

2. 复杂变换

   可分解为多个基础变换，但是基础变换顺序不同最终的结果也会不同，对应到矩阵乘法，**矩阵的应用是从右到左的**。

   复杂变换的分解，可以先将图形移动到中心原点，然后再做变换，最后再移动回初始点





