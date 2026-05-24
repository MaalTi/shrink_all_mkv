# Changelog

All notable changes to shrink_all_mkv are documented in this file.

---

## [1.0.1] - 2026-05-23

### Fixed
- **Cleanup**: Fixed a bug where temporary files in subdirectories were not cleaned up when the script was interrupted in recursive mode.
- **Localization**: Translated remaining French hardcoded messages to English for consistency.
- **Dependencies**: Removed `bc` dependency and replaced all math operations with `awk` for better portability.
- **Process Management**: Improved `pkill` target precision during cleanup to avoid accidentally killing unrelated ffmpeg processes on the system.
- **Variables**: Fixed global variable clobbering by making `_fn` local inside `process_file()`.

---

## [1.0.0] - 2026-02-22

First stable release (single-commit history).

### Features

- **AV1 encoding** — Auto-detect encoder (SVT-AV1, libaom-av1, rav1e), adaptive CRF, 10-bit support
- **Skip log** — Resume: skip files already AV1 or larger than original (`.skipped_shrink_mkv.log`), optional `--keep-skip-log`
- **Memory limit** — `--memory-limit <size>` per ffmpeg (Linux, systemd-run + cgroups); fallback without limit if scope fails (e.g. Access denied)
- **Hardware** — GPU decode (VAAPI/NVDEC/CUVID), optional hardware encode
- **Batch** — Parallel jobs, recursive mode, interactive (fzf), notifications, ETA

### Fixed

- **Memory limit** — If `systemd-run --scope` fails (e.g. Access denied), script disables the limit at startup and continues instead of failing every job.
