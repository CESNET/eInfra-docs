# NetKet

Open-source project for the development of machine intelligence for many-body quantum systems.

## Introduction

NetKet is a numerical framework written in Python to simulate many-body quantum systems using variational methods. In general, NetKet allows the user to parametrize quantum states using arbitrary functions, be it simple mean-field ansatz, Jastrow, MPS ansatz or convolutional neural networks. Those states can be sampled efficiently in order to estimate observables or other quantities. Stochastic optimization of the energy or a time-evolution are implemented on top of those samplers.

NetKet tries to follow the functional programming paradigm, and is built around jax. While it is possible to run the examples without knowledge of jax, it is recommended that the users get familiar with it if they wish to extend NetKet.

For more information, see the [NetKet documentation][1].

## Running NetKet

Load the `Python/3.8.6-GCC-10.2.0-NetKet` and `intel/2020b` modules.

### Example for Multi-GPU Node

!!! important
    Set the visible device in the environment variable before loading jax and NetKet, as NetKet loads jax.

```code
# J1-J2 model
# Version with complex Hamiltonian
#
################################################################################

import os
import sys

# detect MPI rank
from mpi4py import MPI
rank = MPI.COMM_WORLD.Get_rank()

# set only one visible device
os.environ["CUDA_VISIBLE_DEVICES"] = f"{rank}"
# force to use gpu
os.environ["JAX_PLATFORM_NAME"] = "gpu"

import jax
import netket as nk
import numpy as np
import json
import mpi4jax

print("NetKet version: {}".format(nk.__version__))
print("Jax devices: {}".format(jax.devices()))
print("Jax version: {}".format(jax.__version__))
print("MPI utils available: {}".format(nk.utils.mpi.available))

# Parameters
L  = 12   # length
J1 = 1.0  # nearest-neighbours exchange interaction
J2 = .50   # next-nearest-neighbours exchange interaction

MSR = 1  # Marshall sign rule (+1/-1)

# ## Hamiltonian

# Hilbert space
g = nk.graph.Chain(L, pbc=True)
hilbert = nk.hilbert.Spin(s=0.5, total_sz=0.0, N=g.n_nodes)

print("Number of graph nodes: {:d}".format(g.n_nodes))
print("Hilbert size: {:d}".format(hilbert.size))

# Pauli matrices
def sigx(i):
    return nk.operator.spin.sigmax(hilbert, i, dtype=np.complex128)

def sigy(i):
    return nk.operator.spin.sigmay(hilbert, i, dtype=np.complex128)

def sigz(i):
    return nk.operator.spin.sigmaz(hilbert, i, dtype=np.complex128)

def heisenberg(i, j, sgn=1):
    """Heisenberg two spin interaction including Marshall sign rule."""
    return sgn * (sigx(i)*sigx(j) + sigy(i)*sigy(j)) + sigz(i)*sigz(j)

# setup local Hamiltonian
Ha = nk.operator.LocalOperator(hilbert, dtype=np.complex128)  # Hamiltonian

# nearest neighbours
for i in range(L - 1):
    Ha += J1 * heisenberg(i, i+1, MSR)

Ha += J1 * heisenberg(L-1, 0, MSR)

# next nearest neighbours
for i in range(L - 2):
    Ha += J2 * heisenberg(i, i+2)

Ha += J2 * ( heisenberg(L-1, 1) + heisenberg(L-2, 0) )

# check Hamiltonian
print("Hamiltonian is hemitian: {}".format(Ha.is_hermitian))
print("Number of local operators: {:d}".format(len(Ha.operators)))
print("Hamiltonian size: {}".format(Ha.to_dense().shape))

# ## Exact diagonalization

ED = nk.exact.lanczos_ed(Ha, compute_eigenvectors=False)
E0 = ED[0]
print("Exact ground state energy: {:.5f}".format(E0))

# ## Restricted Boltzmann Machine

# setup model
model = nk.models.RBM(alpha=1,dtype=np.complex128)

sa = nk.sampler.MetropolisExchange(hilbert, graph=g, d_max=2, n_chains_per_rank=1)
vs = nk.vqs.MCState(sa, model, n_samples=3000)
opt = nk.optimizer.Sgd(learning_rate=0.01)
sr = nk.optimizer.SR(diag_shift=0.01)

gs = nk.VMC(hamiltonian=Ha, optimizer=opt, variational_state=vs, preconditioner=sr)

# run simulations
output_files = "J1J2cplx_L{:d}_J{:.2f}_rbm".format(L, J2)
gs.run(out=output_files, n_iter=3000)

# print energy
Data = json.load(open("{:s}.log".format(output_files)))
E0rbm = np.mean(Data["Energy"]["Mean"]["real"][-500:-1])
print("RBM ground state energy: {:.5f}".format(E0rbm))
```

[1]: https://www.netket.org/docs/getting_started.html#installation-and-requirements
