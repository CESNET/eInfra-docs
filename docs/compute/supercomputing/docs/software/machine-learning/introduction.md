# Machine Learning

This section overviews machine learning frameworks and libraries available on the clusters.

## Keras

Keras is an API designed for human beings, not machines. Keras follows best practices for reducing cognitive load: it offers consistent & simple APIs, it minimizes the number of user actions required for common use cases, and it provides clear & actionable error messages. It also has extensive documentation and developer guides. For more information, see the [official website][c].

For the list of available versions, type:

```console
$ ml av Keras
```

## NetKet

NetKet is an open-source project for the development of machine intelligence for many-body quantum systems.
For more information, see the [official website][d] or [GitHub][e].

## TensorFlow

TensorFlow is an end-to-end open source platform for machine learning. It has a comprehensive, flexible ecosystem of tools, libraries, and community resources that lets researchers push the state-of-the-art in ML and developers easily build and deploy ML powered applications. For more information, see the [official website][a].

For the list of available versions, see the [TensorFlow][1] section:

## Theano

Theano is a Python library that allows you to define, optimize, and evaluate mathematical expressions involving multi-dimensional arrays efficiently. It can use GPUs and perform efficient symbolic differentiation. For more information, see the [official webpage][b] (GitHub).

For the list of available versions, type:

```console
$ ml av Theano
```

[1]: tensorflow.md

[a]: https://www.tensorflow.org/
[b]: https://github.com/Theano/
[c]: https://keras.io/
[d]: http://www.netket.org
[e]: https://github.com/netket

<!---
2021-04-08
It is necessary to load the correct NumPy / SciPy modules along with the Tensorflow one.

Obsolete 2021-03-31
## Todo
Salomon -> Theano/0.9.0-Python-3.6.1 does NOT include several mandatory modules, like NumPy and SciPy
Salomon -> Keras/2.0.5-Theano-1.2.0-Python-3.6.1 loads Theano/0.9.0-Python-3.6.1, meaning it also does not include mandatory librarie

Salomon -> /apps/modules/math/Keras/2.3.0-Tensorflow-1.13.1-Python-3.7.2 works, others miss NumPy or other libraries

What seems to work on Salomon:
for theano:
/apps/modules/python/Theano/1.0.1-Py-3.6, and Keras with this backend

for keras:
/apps/modules/math/Keras/2.3.0-Tensorflow-1.13.1-Python-3.7.2
/apps/modules/python/Keras/2.1.4-Py-3.6-Tensorflow-1.6.0rc0
-->
