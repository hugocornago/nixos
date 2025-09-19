{ pkgs, ... }:
{
  # https://wiki.archlinux.org/title/Gaming#Tweaking_kernel_parameters_for_response_time_consistency
  systemd.tmpfiles.settings = {
    "consistent-response-time-for-gaming.conf" = {
      "/proc/sys/vm/compaction_proactiveness".w = {
        argument = "0";
      };
      "/proc/sys/vm/watermark_boost_factor".w = {
        argument = "1";
      };
      "/proc/sys/vm/min_free_kbytes".w = {
        argument = "1048576";
      };
      "/proc/sys/vm/watermark_scale_factor".w = {
        argument = "500";
      };
      "/proc/sys/vm/swappiness".w = {
        argument = "10";
      };
      "/sys/kernel/mm/lru_gen/enabled".w = {
        argument = "5";
      };
      "/proc/sys/vm/zone_reclaim_mode".w = {
        argument = "0";
      };
      "/sys/kernel/mm/transparent_hugepage/enabled".w = {
        argument = "madvise";
      };
      "/sys/kernel/mm/transparent_hugepage/shmem_enabled".w = {
        argument = "advise";
      };
      "/sys/kernel/mm/transparent_hugepage/defrag".w = {
        argument = "never";
      };
      "/proc/sys/vm/page_lock_unfairness".w = {
        argument = "1";
      };
      "/proc/sys/kernel/sched_child_runs_first".w = {
        argument = "0";
      };
      "/proc/sys/kernel/sched_autogroup_enabled".w = {
        argument = "1";
      };
      "/proc/sys/kernel/sched_cfs_bandwidth_slice_us".w = {
        argument = "3000";
      };
      "/sys/kernel/debug/sched/base_slice_ns".w = {
        argument = "3000000";
      };
      "/sys/kernel/debug/sched/migration_cost_ns".w = {
        argument = "500000";
      };
      "/sys/kernel/debug/sched/nr_migrate".w = {
        argument = "8";
      };
    };
  };
}
