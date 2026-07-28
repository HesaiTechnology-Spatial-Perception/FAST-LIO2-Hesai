# Changelog — ROS 1 branch (main)

All notable changes to the ROS 1 branch. The ROS 2 branch keeps its own CHANGELOG.

## [Unreleased]

### Added
- `pcd_save/leaf_size` (default `0.0` = off): voxel-downsample the accumulated save buffer periodically and on write, bounding memory on long runs.
- `trajectory_save/tum_en` (default `false`): export the trajectory to `Log/traj_tum.txt` in TUM format (`timestamp x y z qx qy qz qw`) for external evaluation.
- `config_file` argument on `mapping_jt16.launch` / `mapping_jt128.launch`; point to your own yaml without editing the packaged one.
- Startup config summary log line, plus plausibility warnings: implausible per-scan time span (wrong `preprocess/timestamp_unit`), implausibly large gyro bias after IMU init (wrong `common/imu_gyr_unit`), and a notice that `common/time_sync_en` only takes effect with Livox input.
- GitHub Actions build on `ros:noetic-ros-base-focal`; issue and PR templates.

### Fixed
- Out-of-bounds write in runtime-log buffers after ~20 h of continuous operation (`s_plot11[scan_count]`, `MAXN` overflow).
- Debug record files (`Log/pos_log.txt`, `mat_pre.txt`, `mat_out.txt`, `dbg.txt`, `imu.txt`) were created — and `mat_pre.txt` appended every scan — even with `runtime_pos_log_enable: false`.
- Blind-zone skip loop in feature extraction could read out of bounds when an entire scan was within `blind`.
- `/map_save` reports the actually written point count when downsampling is enabled.

### Changed
- The expected empty scan right after IMU initialization logs as INFO with an explanation instead of `No point, skip this scan!`.
- Runtime-log buffers (~66 MB) are allocated only when `runtime_pos_log_enable` is set.
- Removed the unused matplotlibcpp / Python build dependency.
