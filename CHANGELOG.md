# Changelog — ROS 2 branch

All notable changes to the ROS 2 branch. The ROS 1 branch (`main`) keeps its own CHANGELOG.

## [Unreleased]

### Added
- `/map_save` service returns explicit results: saved point count and path, or the reason for failure (save disabled / buffer empty / IO error).
- `pcd_save.leaf_size` (default `0.0` = off): voxel-downsample the accumulated save buffer periodically and on write, bounding memory on long runs.
- `trajectory_save.tum_en` (default `false`): export the trajectory to `Log/traj_tum.txt` in TUM format (`timestamp x y z qx qy qz qw`) for external evaluation.
- `config_file` launch argument on `mapping_jt16.launch.py` / `mapping_jt128.launch.py`; override parameters without editing the packaged yaml.
- Startup config summary log line, plus plausibility warnings: implausible per-scan time span (wrong `preprocess.timestamp_unit`), implausibly large gyro bias after IMU init (wrong `common.imu_gyr_unit`), and a notice that `common.time_sync_en` has no effect in this build.
- GitHub Actions build on `ros:humble-ros-base`; issue and PR templates.

### Fixed
- `pcd_save_en: true` produced no PCD file: the save-buffer accumulation was commented out (inherited from the upstream ROS 2 port), so both the exit-time save and `/map_save` silently wrote nothing.
- Saving no longer depends on `scan_publish_en`, and `/map_save` no longer requires `map_en`.
- Out-of-bounds write in runtime-log buffers after ~20 h of continuous operation (`s_plot11[scan_count]`, `MAXN` overflow).
- Debug record files (`Log/pos_log.txt`, `mat_pre.txt`, `mat_out.txt`, `dbg.txt`, `imu.txt`) were created — and `mat_pre.txt` appended every scan — even with `runtime_pos_log_enable: false`.
- IMU time-jump log message wrongly said "lidar loop back".
- Blind-zone skip loop in feature extraction could read out of bounds when an entire scan was within `blind`.

### Changed
- The expected empty scan right after IMU initialization logs as INFO with an explanation instead of `No point, skip this scan!`.
- IMU subscription uses `SensorDataQoS` (matches the LiDAR subscription; robust against best-effort publishers).
- Runtime-log buffers (~66 MB) are allocated only when `runtime_pos_log_enable` is set.
- Removed the unused matplotlibcpp / Python build dependency.
