# TensorFlow

TensorFlow is an open-source software library for machine intelligence.
For searching available modules type:

```console
$ ml av Tensorflow
```

<!---
## Salomon Modules

Salomon provides (besides other) these TensorFlow modules:

**Tensorflow/1.1.0** (not recommended), module built with:

* GCC/4.9.3
* Python/3.6.1

**Tensorflow/1.2.0-GCC-7.1.0-2.28** (default, recommended), module built with:

* TensorFlow 1.2 with SIMD support. TensorFlow build taking advantage of the Salomon CPU architecture.
* GCC/7.1.0-2.28
* Python/3.6.1
* protobuf/3.2.0-GCC-7.1.0-2.28-Python-3.6.1
-->

## TensorFlow Application Example

After loading one of the available TensorFlow modules, you can check the functionality by running the following Python script.

```python
import tensorflow as tf

c = tf.constant('Hello World!')
sess = tf.Session()
print(sess.run(c))
```

<!---
2021-04-08
It's necessary to load the correct NumPy module along with the Tensorflow one.

2021-03-31
## Notes
As of 2021-03-23, TensorFlow is made available only on the Salomon cluster

Tensorflow-tensorboard/1.5.1-Py-3.6 has not been not tested.
-->
