---
layout: page
title: ""
---

### [BMI 585 - Kalman Filtering: Principles and Applications in Time Series Analysis and Forecasting](https://sameni.info/courses/kalman-filtering/)

---

## Lecture 1: Introduction to Kalman Filtering and Its Applications

### What is a Signal?
A **signal** is a representation of information (such as a physical or physiological quantity) as a function of time or another independent variable like space.

- **Deterministic signals**: fully described and predictable from a mathematical expression (e.g., a sinusoid or a periodic pulse wave).  
- **Stochastic signals**: outcomes of random experiments, described by random variables as a function of time and the random experiment (*stochastic processes*).

In a stochastic setting, any database, no matter how large, comprises or ensembles of the stochastic process.

Stochastic signals, systems, and algorithms working on stochastic processes have specific requirements. We cannot simply use tools and transformations designed for deterministic signals. They are always tied to a random experiment, the outcomes of which are random variables or stochastic processes. This inevitably involves stochastic distributions. All operations and transformations (such as the Fourier transform) should be used appropriately when dealing with stochastic processes. Operations like differential/difference equations, equality/inequality operators, and more generally calculus have been revisited for stochastic processes.

Central to these are **probability distribution functions**, which formalize our knowledge about the stochastic nature of random variables.

---

### What is a System?
In our context, a **system** is a mathematical and/or algorithmic set of steps taken on a deterministic/stochastic input signal to map it to another signal. The systems we study operate on time-series data (sequences of data points) and deliver sequences of data points in their output.

**Filters** are specific types of systems that separate “desired” from “undesired” parts.

Designing a system requires a presumed **data model** for how the signal and noise were originally mixed together. The most common case is the **additive** model,

```
x(t) = s(t) + n(t)
```

but these are not the only types of data models. For instance, consider a **multiplicative (modulatory)** model,

```
z(t) = r(t) * a(t)
```
which occurs in biomedical applications like respiratory modulations on ECG or BP measurements, or in applications like FOREX or the stock market, where brokers often apply varied profit margins and fees as percentages rather than fixed fees.

**How to approach non-additive and nonlinear models?**  
1. Use nonlinear models,
2. Linearize them, or
3. Transform them (e.g., in the above example, take the logarithm and work in the log scale with an additive model)

*Each approach has its applications and implications.*

Filters often look at current, previous, and sometimes future inputs and generate outputs, a.k.a. *finite-impulse-response (FIR)* filters. They can also look at the previous outputs they generated, which can give them more flexibility and memory of the past. This output to input feedback results in an *infinite-impulse response (IIR)*.

If “signal” and “noise” were perfectly separable in some domain (time, frequency, or channel), filtering would be quite trivial; but the most challenging cases we deal with in this course are the nontrivial ones, where the signal and noise partially or entirely overlap in all domains we know. Therefore, **filtering is always a compromise** between how much signal is removed and how much noise remains. We seek an *optimal* compromise.

Filters can have *fixed* or *adaptive*, which adapt based on the incoming signals.

**Example.** Suppose we want to remove powerline noise from biomedical signals, which is very common in data collected in clinics and with wearables outside clinics. Since powerline interference often overlaps in time and frequency with the biosignal, there is always a compromise. And because powerline noise fluctuates, using a fixed-coefficient filter disadvantages clean scenarios (with negligible powerline). An adaptive scheme that updates coefficients as needed is more attractive.

Filters essentially **estimate** the signal embedded in noise. In that sense, they can also be used to estimate (forecast) **future** unseen samples, which is very attractive in real-time systems and in finance (suppose you confidently knew which stock would go up or down, next week!).

When filters look at past and current samples of the inputs and the outputs they generated, they are called **causal**. Sometimes we apply filters retrospectively in a **non-causal** manner, e.g., when we can wait for a few samples and respond in near-real-time (known as **fixed-lag smoothing**), or wait until data collection ends and then process the data in a fully offline manner (**fixed-interval smoothing**).

**Forecasting is always causal.** What will the signal look like at some point in the future? Intuitively, the near future is easier to predict than the far future.

More accurately, this depends on the nature of the signals. If a signal varies “quickly,” the definition of “near” vs. “far” changes significantly (depending on what we mean by near/far). Minutes, hours, and days are negligible for slow events like earth erosion; even **10 ms** can be significant for cardiac or brain waves; in high-frequency applications, microseconds and nanoseconds are also crucial.

---

### Dynamics and States
This brings us to the concept of **dynamics and states**.

While filters can be formulated in terms of relationships between inputs, outputs, and coefficients using difference or differential equations, it is often convenient to use **first-order difference/differential equations** and relate inputs and outputs indirectly through so-called **state variables**. Using state variables, inputs impact states, and states (and inputs) impact outputs. State variables bring more flexibility and stronger mathematical tools for analysing linear and nonlinear systems.

A standard linear, time-discrete state-space model we will frequently use throughout the course is:

```
x_{k+1} = A x_k + B u_k + w_k
y_k     = C x_k + D u_k + v_k
```

with process noise `w_k` and measurement noise `v_k`.


Depending on the case, states may or may not have physical interpretation. In physical and physiological systems, they often do; but from a mathematical perspective they can be abstract variables that do not represent any physical quantity.

---

### Priors and Posteriors
Filtering and filter design is context- and application-dependent and heavily relies on what we know about the signal and noise components. Consider:

- recovering ECG from noisy wearable measurements  
- tracking an individual who’s walking or running  
- predicting the real value of an asset or stock using market instruments to avoid emotional trading  

Even without an actual measurement, we know something about what the waveforms could or could not look like. This prior knowledge about a system and its evolution is known as **priors**. For example, if you have worked enough with ECG, human motion, or markets, you have ideas about typical waveforms, how stochastic they are, how fast/slow they evolve, etc. Waveforms may also have **cyclicalities and seasonalities**, which make far points in time comparable (e.g., monthly weather). Prior knowledge can be updated as data arrive. We call these **posteriors**. Although still imperfect (observations are noisy), posterior knowledge is often more reliable than our prior-only knowledge.

---

### The Kalman Filter
**Kalman filters** are adaptive filters specifically designed for stochastic processes, which *optimally* fuse priors and posteriors. 

**Optimality** will be defined. For random variables it is defined **statistically**-using average measures such as **mean absolute error**, **mean squared error**, or other risk criteria.

The Kalman filter was **invented in 1960 by Rudolf E. Kálmán**. It is among the most elegant engineering tools ever created, and after ~65 years it has stood the test of time.

While the Kalman filtering theory is very well-established, the key to its popularity is its close relationship to mathematical modeling. As new applications arise, new models are created and used for design and implementation of Kalman filters. 

The Kalman filtering theory stands on multiple pillars and combines several disciplines. Its primary users and contributors have been in control theory, telecommunication, and signal processing. Its applications later expanded to astronomy, biomedical signal processing, machine learning, mechanical engineering, finance, and even technical trading. The core idea of Kalman filters—the **optimal, sequential fusion** of priors and posteriors—has inspired a wide range of modern Bayesian estimation methods, machine learning models and even neural network architectures.

---

### Throughout This Course...
We will (per the syllabus) build from fundamentals to applications:

1. **Foundations**: stochastic signals; estimation theory; state-space modeling  
2. **Linear KF**: derivation, insight, steady-state (Wiener) behavior; fixed-lag/interval smoothing  
3. **Engineering**: monitoring filter health; selecting/tuning Q, R, initialization; adaptivity  
4. **Extensions**: extended KF (linearization), unscented KF (sigma points), Particle Filters (non-Gaussian), and H-infinity filters  
5. **Applications**: biosignal analysis and denoising; human motion tracking; epidemic trend forecasting; financial time-series and technical trading  

---