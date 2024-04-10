# Controller objects
## ReplicaSet
A ReplicaSet controller ensures that a collection of identical Pods are running at the same time.
Deployments manage their own ReplicaSets under the hood, and let you make declarative updates to them.

## Deployment
Deployments let you:
1. Create
1. Update
1. Rollback
1. Scale
Pods, using ReplicaSets as needed.
E.g. when you perform a rolling upgrade, the Deployment creates a second ReplicaSet and increases the number of Pods in the new ReplicaSet as it decreases the number of Pods in the original ReplicaSet.

## Replication controller
These perform a similar role to Deployments, but their use is no longer recommended.

## StatefulSet
Similar to a Deployment in that the Pods all share the same spec.
However, Pods created by the StatefulSet are given persistent identities with stable:
1. Network identity (i.e. IP)
1. Persistent disk storage
A StatefulSet is useful for applications that maintain local state.

## DaemonSet
Ensures that a specific Pod is always running on all/some subset of the nodes.
If new nodes are added, the DaemonSet will automatically set up Pods in those nodes.
Use a DaemonSet when you need to run certain Pods on all/a selection of nodes.
E.g. a logging agent like fluentd.

## Job
The Job controller creates pods as necessary to run a task.
When the task is completed, the Pods are terminated.
A related controller is the CronJob, which runs Pods on a time-based schedule.
