---
layout: page
title: ""
---

## BMI 585 - Topics in Biomedical Informatics

# Kalman Filtering: Principles and Applications in Time Series Analysis and Forecasting

---

### Course Description
Sixty-five years after its invention, the **Kalman filter** remains one of the most powerful analysis tools across many disciplines, ranging from electrical, biomedical, and control engineering to artificial intelligence, with vast applications in signal processing, navigation, object tracking, robotics, weather forecasting, and financial market analysis.

Despite dramatic advances in machine learning and deep learning, Kalman filters and their nonlinear extensions (such as the **Extended Kalman Filters** and **Particle Filters**) have stood the test of time and continue to be among the most trusted techniques for time-series analysis and forecasting.

This graduate-level course offers a deep dive into Kalman filtering theory and its broad applications in analyzing dynamic systems and forecasting time-series data.

#### Core Topics
* Mathematical modeling of dynamic systems
* State-space modeling of time-series data
* Estimation theory review
* Recursive Bayesian estimation and filtering
* Noise characterization
* Wiener filters
* Implementation and optimization strategies
* Hyperparameter selection for linear and nonlinear Kalman filters

Students will gain a deep understanding of both theoretical foundations and practical implementations, including hands-on coding (in Python or MATLAB), applied filtering, state estimation, and forecasting under uncertainty and noise.

#### Course Goals
By the end of the course, students will be able to:

* Formulate and analyze state-space models for dynamic systems and real-world data
* Implement, fine-tune, compare, and diagnose various Kalman filter algorithms
* Apply filtering techniques in domains such as biomedical time-series analysis
* Understand the strengths, limitations, and trade-offs of Kalman filtering in real-world applications

#### Deliverables

* Homework assignments
* A mini-project on an approved application

---

#### Evaluation

| Component                              | Weight |
| -------------------------------------- | ------ |
| Homework                               | 65%    |
| Attendance, Punctuality, Participation | 10%    |
| Final Project                          | 25%    |

---
### Prerequisites

Students must have completed or have strong knowledge in:

* Probability or stochastic processes
* Signal processing or time-series analysis
* Ordinary differential/difference equations
* Programming proficiency (e.g., Python, MATLAB, C/C++, R, Julia)

*Students without formal coursework should contact the instructor before registering.*

---


### Books, Materials, and Readings

Readings and papers will be assigned throughout the course. Suggested foundational texts include:

* Grewal & Andrews (2014). *Kalman Filtering: Theory and Practice Using MATLAB (4th ed.).* Wiley
* Simon, D. J. (2006). *Optimal State Estimation.* Wiley
* Haykin, S. (2001). *Kalman Filtering and Neural Networks.* Wiley
* Kay, S. M. (1993). *Estimation Theory.* Prentice Hall PTR
* Chui & Chen (2017). *Kalman Filtering: With Real-Time Applications (5th ed.).* Springer
* Anderson & Moore (1979). *Optimal Filtering.* Dover
* Van Trees, H. L. (2004). *Detection, Estimation, and Modulation Theory (Part I).* Wiley
* Bierman, G. J. (2006). *Factorization Methods for Discrete Sequential Estimation.* Dover
* Papoulis & Pillai (2002). *Probability, Random Variables, and Stochastic Processes (4th ed.).* McGraw-Hill
* Candy, J. V. (2005). *Model-Based Signal Processing.* Wiley-IEEE
* Grewal et al. (2007). *Global Positioning Systems, Inertial Navigation, and Integration.* Wiley
* Schweppe, F. C. (1973). *Uncertain Dynamic Systems.* Prentice-Hall
* Jazwinski, A. H. (1970). *Stochastic Processes and Filtering Theory.* Elsevier

---

### Weekly Schedule and Learning Objectives

| Week | Topics                                                             | Learning Objectives                                                                          |
| ---- | ------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| 1    | Introduction to Kalman Filtering and its Applications | The big picture; Kalman filtering history, filtering, forecasting, and applications          |
| 2    | Overview of Estimation Theory, Recursive Filtering and Forecasting | Estimation frameworks: least squares, ML, Bayesian, recursive estimation                     |
| 3    | Modeling Dynamic Systems; State Variables and State-Space Models   | Model dynamic systems using difference/differential equations and state-space representation |
| 4    | Linear Kalman Filter Theory                                        | Classical KF, parameter tuning, and applications to ECG/EEG                                  |
| 5    | Kalman Filter Intuition, Steady-State Behavior, Smoothing          | Insights into filter equations; steady-state (Wiener filter), fixed-lag/interval smoothing   |
| 6    | Kalman Filter Engineering                                          | Monitoring health and tuning of KF in practice                                               |
| 7    | Extended Kalman Filters (EKF)                                      | Nonlinear systems, system linearization, EKF steps                                           |
| 8    | Continuous-time Kalman Filters                                     | Filtering for continuous-time systems with discrete observations                             |
| 9    | Other Extensions                                                   | H-infinity, Unscented KF, Particle Filters for non-Gaussian or nonlinear systems             |
| 10   | Application 1: Adult and Fetal ECG Processing                      | Dynamic ECG models, adaptive fetal ECG extraction from maternal recordings                   |
| 11   | Application 2: EEG Analysis and Forecasting                        | Time-varying AR models, sleep staging via EEG frequency tracking                             |
| 12   | Application 3: Pandemic Trend Forecasting                          | SIR models + KF for COVID-19 trend forecasting                                               |
| 13   | Application 4: Technical Trading                                   | Forecasting stocks/FOREX markets using Kalman filters                                        |
| 14   | Wrap-Up and Review                                                 | Mini-project presentations or discussion                                                     |

---