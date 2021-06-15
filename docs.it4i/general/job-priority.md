# Job Scheduling

## Job Execution Priority

The scheduler gives each job an execution priority and then uses this job execution priority to select which job(s) to run.

Job execution priority is determined by these job properties (in order of importance):

1. queue priority
1. fair-share priority
1. eligible time

### Queue Priority

Queue priority is the priority of the queue in which the job is waiting prior to execution.

Queue priority has the biggest impact on job execution priority. The execution priority of jobs in higher priority queues is always greater than the execution priority of jobs in lower priority queues. Other properties of jobs used for determining the job execution priority (fair-share priority, eligible time) cannot compete with queue priority.

Queue priorities can be seen [here][a].

### Fair-Share Priority

Fair-share priority is calculated based on recent usage of resources. Fair-share priority is calculated per project, i.e. all members of a project share the same fair-share priority. Projects with higher recent usage have a lower fair-share priority than projects with lower or no recent usage.

Fair-share priority is used for ranking jobs with equal queue priority.

Fair-share priority is calculated as:

---8<--- "fairshare_formula.md"

where MAX_FAIRSHARE has the value of 1E6

usage<sub>Project</sub> is the usage accumulated by all members of a selected project

usage<sub>Total</sub> is the total usage by all users, across all projects.

Usage counts allocated core-hours (`ncpus x walltime`). Usage decays, halving at intervals of 168 hours (one week).
Jobs queued in the queue qexp are not used to calculate the project's usage.

!!! note
    Calculated usage and fair-share priority can be seen [here][b].

Calculated fair-share priority can also be seen in the Resource_List.fairshare attribute of a job.

### Eligible Time

Eligible time is the amount of eligible time (in seconds) a job accrues while waiting to run. Jobs with higher eligible time gain higher priority.

Eligible time has the least impact on execution priority. Eligible time is used for sorting jobs with equal queue priority and fair-share priority. It is very, very difficult for eligible time to compete with fair-share priority.

Eligible time can be seen in the `eligible_time` attribute of a job.

### Formula

Job execution priority (job sort formula) is calculated as:

---8<--- "job_sort_formula.md"

### Job Backfilling

The scheduler uses job backfilling.

Backfilling means fitting smaller jobs around the higher-priority jobs that the scheduler is going to run next, in such a way that the higher-priority jobs are not delayed. Backfilling allows us to keep resources from becoming idle when the top job (the job with the highest execution priority) cannot run.

The scheduler makes a list of jobs to run in order of execution priority. The scheduler looks for smaller jobs that can fit into the usage gaps around the highest-priority jobs in the list. The scheduler looks in the prioritized list of jobs and chooses the highest-priority smaller jobs that fit. Filler jobs are run only if they will not delay the start time of top jobs.

This means that jobs with lower execution priority can be run before jobs with higher execution priority.

!!! note
    It is **very beneficial to specify the walltime** when submitting jobs.

Specifying more accurate walltime enables better scheduling, better execution times, and better resource usage. Jobs with suitable (small) walltime can be backfilled - and overtake job(s) with a higher priority.

---8<--- "mathjax.md"

### Job Placement

Job [placement can be controlled by flags during submission][1].

[1]: job-submission-and-execution.md#advanced-job-placement

[a]: https://extranet.it4i.cz/rsweb/barbora/queues
[b]: https://extranet.it4i.cz/rsweb/barbora/projects
