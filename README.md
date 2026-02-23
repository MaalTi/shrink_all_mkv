# shrink_all_mkv - AV1 Video Compression Tool

High-performance batch video compression script that converts MKV files to AV1 format with intelligent quality optimization and hardware acceleration support.

---

## ✨ Key Features

### Core Capabilities

- **Auto-detects best AV1 encoder** (SVT-AV1, libaom-av1, rav1e)
- **Adaptive CRF** - Automatically adjusts quality based on resolution and source
- **Smart codec detection** - Skips files already in AV1 format
- **Parallel processing** - Process multiple files simultaneously
- **Recursive mode** - Process subdirectories with `--recursive` flag
- **Real-time progress** - Live progress bars with ETA
- **Hardware acceleration** - GPU decoding support (AMD/NVIDIA/Intel)
- **Interactive mode** - Visual file selection with fzf
- **Resume capability** - Continue interrupted batch jobs

### Quality Optimizations

- **Variance boost** - 3-8% quality improvement (enabled by default)
- **Content-aware CRF** - Smarter quality decisions based on source
- **10-bit encoding support** - Auto-detect and preserve bit depth
- **Force 10-bit mode** - Encode 8-bit sources as 10-bit for better quality
- **Film grain mode** - Optimized for grainy content (--tune-grain)
- **Auto keyframe interval** - Better seeking performance
- **Closed GOP** - Improved compatibility

### Performance Features

- **GNU Parallel auto-detection** - Enhanced parallelization when available
- **Hardware decode** - Offload decoding to GPU (15-25% faster)
- **Optimized ffprobe** - 67% faster file analysis
- **Auto-calculate optimal jobs** - Smart job count based on content
- **Batch ETA estimation** - Know how long your batch will take

### Workflow Tools

- **Dry-run mode** - Preview what will be done
- **Desktop notifications** - Alert when batch completes
- **Interrupted summary** - See progress when manually stopped (Ctrl+C)
- **Skip log (resume)** - Files that grew after encode or are already AV1 are logged in the target folder (`.skipped_shrink_mkv.log`); on re-run they are skipped without reading metadata. Log removed on normal exit unless you use `--keep-skip-log` or choose to keep it when prompted in interactive mode.
- **VMAF quality analysis** - Measure output quality (optional)
- **Disk space checking** - Prevent failures from full disk
- **Memory limit** - Cap RAM per ffmpeg process with `--memory-limit` (e.g. `2G`); Linux only, uses systemd-run + cgroups. On some environments (e.g. user session, SSH, insufficient rights), the limit may be automatically disabled with a warning.
- **Configuration file** - Save your preferred settings

---

## 🚀 Quick Start

### Basic Usage

```bash
# Process current directory (auto-detect everything)
shrink_all_mkv

# Process specific directory
shrink_all_mkv /path/to/videos

# Use 8 parallel jobs
shrink_all_mkv --jobs 8 /path/to/videos

# Interactive mode with file selection
shrink_all_mkv --interactive /path/to/videos
```

### Recommended Commands

```bash
# Balanced: Quality + Speed with hardware decode
shrink_all_mkv --hw-decode --preset 6 --jobs 8 /videos

# Maximum Speed: Faster preset with auto-jobs
shrink_all_mkv --hw-decode --preset 8 --auto-jobs /videos

# High Quality: Slower preset for best results
shrink_all_mkv --preset 4 --jobs 4 /videos

# Background Processing: Quiet with notification
shrink_all_mkv --quiet --notify --jobs 8 /videos
```

---

## 📋 Requirements

### Essential

- **ffmpeg** with AV1 encoder support (libsvtav1, libaom-av1, or librav1e)
- **ffprobe** (usually included with ffmpeg)
- **bash** 4.0 or higher
- **bc** (for calculations)

### Optional (but recommended)

- **GNU Parallel** - Better parallelization (auto-detected)
- **fzf** - Interactive file selection
- **notify-send** - Desktop notifications
- **vainfo** - Hardware acceleration verification (AMD/Intel)
- **nvidia-smi** - Hardware acceleration verification (NVIDIA)

### Installation

```bash
# Arch Linux
sudo pacman -S ffmpeg bc gnu-parallel fzf libnotify

# Ubuntu/Debian
sudo apt install ffmpeg bc parallel fzf libnotify-bin

# macOS (Homebrew)
brew install ffmpeg bc parallel fzf
```

---

## 🎮 Hardware Acceleration

### Hardware Decode (Recommended!)

Offload video decoding to GPU, freeing CPU for encoding:

```bash
# Auto-detect GPU
shrink_all_mkv --hw-decode --jobs 8 /videos

# Force specific decoder
shrink_all_mkv --hw-decode=vaapi --jobs 8 /videos  # AMD/Intel
shrink_all_mkv --hw-decode=cuda --jobs 8 /videos   # NVIDIA
```

**Supported GPUs:**

- **AMD**: Most Radeon GPUs (RDNA1+, GCN)
- **NVIDIA**: Most GeForce/Quadro GPUs (GTX 900+)
- **Intel**: Most integrated GPUs (HD Graphics 500+)

**Benefit:** 15-25% faster encoding by freeing up CPU resources

### Hardware Encode (If Available)

Full GPU encoding (requires newer GPUs):

```bash
# Check if your GPU supports AV1 encoding
shrink_all_mkv --hw-detect

# Use hardware encoding (50-100x faster!)
shrink_all_mkv --hw-encoder --jobs 8 /videos
```

**Supported for AV1 encoding:**

- **NVIDIA**: RTX 40-series or newer (Ada Lovelace)
- **Intel**: ARC A-series or newer (Alchemist/Battlemage)
- **AMD**: RX 7000-series or newer (RDNA3)

---

## 📖 Usage Guide

### Options

```bash
--encoder <name>         AV1 encoder (libsvtav1, libaom-av1, librav1e)
                         Default: auto-detect (prefers libsvtav1)

--preset <value>         Encoding preset
                         SVT-AV1: 0-13 (default: 6, higher=faster)
                         libaom-av1: 0-8 (default: 6, higher=faster)
                         rav1e: 0-10 (default: 6, higher=faster)

--crf <value>            CRF for compression (0-63, lower=better quality)
                         Default: auto-detect based on source quality

--jobs <num>             Parallel jobs (default: 4)

--skip-codec <codec>     Skip files with specific codec
                         Can be repeated: --skip-codec hevc --skip-codec vp9

--interactive, -i        Interactive mode with fzf file selection

--list-codecs            Show codec statistics for all files

--dry-run                Preview what would be done

--notify                 Send desktop notification when complete

--vmaf                   Calculate VMAF quality scores (slower)

--check-space            Check disk space before encoding

--hw-decode              Enable hardware video decoding
--hw-decode=<device>     Force specific decoder (vaapi, cuda, qsv)

--hw-encoder             Enable hardware AV1 encoding (auto-detect)
--hw-encoder=<name>      Force specific encoder (av1_nvenc, av1_qsv, av1_vaapi)

--hw-detect              Show available hardware encoders and exit

--no-varboost            Disable variance boost

--tune-grain             Optimize for film grain retention

--auto-jobs              Auto-calculate optimal job count

--force-10bit            Force 10-bit encoding (even if source is 8-bit)
                         Better quality and compression, slight compatibility tradeoff

--recursive, -r          Process files recursively in subdirectories
                         Default: only current directory

--quiet, -q              Suppress output (errors only)

--keep-skip-log          Do not remove .skipped_shrink_mkv.log at end
                         (in interactive mode, you can also choose at the end)

--memory-limit <size>    Limit RAM per ffmpeg process (e.g. 2G, 512M)
                         Linux only: uses systemd-run + cgroups; fallback without limit if scope fails (e.g. Access denied)

--help, -h               Show help message
```

### Examples

```bash
# Scan directory to see codecs
shrink_all_mkv --list-codecs /videos

# Skip already efficient codecs
shrink_all_mkv --skip-codec hevc --skip-codec vp9 /videos

# Dry-run to preview
shrink_all_mkv --dry-run /videos

# Process with VMAF quality analysis
shrink_all_mkv --vmaf --jobs 1 /videos

# Optimize for grainy old films
shrink_all_mkv --tune-grain --preset 4 /videos

# Force 10-bit encoding for better quality
shrink_all_mkv --force-10bit --preset 6 /videos

# Process entire directory tree recursively
shrink_all_mkv --recursive --jobs 8 /videos

# Recursive processing with hardware acceleration
shrink_all_mkv --recursive --hw-decode --auto-jobs /videos

# Maximum automation
shrink_all_mkv --hw-decode --auto-jobs --notify /videos
```

---

## 🎯 Preset Guide

| Preset | Speed | Quality | Use Case |
|--------|-------|---------|----------|
| 0-3 | Very Slow | Excellent | Archival, masters |
| 4 | Slow | Very Good | High quality encodes |
| **6** | **Balanced** | **Good** | **Recommended default** |
| 8 | Fast | Good | Large batches |
| 10-13 | Very Fast | Acceptable | Quick conversions |

**Recommendation:** Use preset 6 for best balance. Use 4 for high quality, 8 for speed.

---

## 💾 CRF Guide (Auto-detected by default)

| CRF | Quality | Typical Use |
|-----|---------|-------------|
| 20-25 | Excellent | High quality, larger files |
| 26-30 | Very Good | Balanced (typical auto-detect range) |
| 31-35 | Good | Space savings priority |
| 36-40 | Acceptable | Maximum compression |

**Note:** Script auto-detects CRF based on source resolution and quality. Manual override available if needed.

---

## 🔧 Configuration File

Save your preferences in `~/.config/shrink_mkv/config`:

```bash
# Example configuration
ENCODER="libsvtav1"
PRESET=6
JOBS=8
ENABLE_VARBOOST=true
HW_DECODE=true
```

---

## 📊 Performance Tips

### For Best Speed

```bash
shrink_all_mkv --hw-decode --preset 8 --auto-jobs /videos
```

### For Best Quality

```bash
shrink_all_mkv --preset 4 --crf 25 --jobs 4 /videos
```

### For Large Batches (1000+ files)

```bash
shrink_all_mkv --hw-decode --preset 6 --auto-jobs --notify --quiet /videos
```

### For Anime/Grainy Content

```bash
shrink_all_mkv --tune-grain --preset 4 --jobs 4 /videos
```

---

## 🐛 Troubleshooting

### Files Fail to Encode

**Check for multiple video tracks:**

```bash
ffprobe file.mkv 2>&1 | grep "Stream.*Video"
```

If multiple video tracks, the script now handles this automatically (only encodes first track).

**Check encoder availability:**

```bash
ffmpeg -encoders 2>&1 | grep av1
```

### Hardware Acceleration Not Working

**Check hardware decode support:**

```bash
shrink_all_mkv --hw-detect
ffmpeg -hwaccels
```

**AMD/Intel VAAPI:**

```bash
vainfo
ls -la /dev/dri/
```

**NVIDIA CUDA:**

```bash
nvidia-smi
```

### Performance Issues

**CPU at 100% but slow encoding:**

- Try fewer jobs: `--jobs 4`
- Check if using slowest preset (0-3)

**CPU not at 100%:**

- Increase jobs: `--jobs 16`
- Enable hardware decode: `--hw-decode`

---

## 📈 Expected Results

### Typical Compression Ratios

| Source Codec | Quality | Typical Savings |
|--------------|---------|-----------------|
| H.264 (x264) | High | 30-40% |
| H.264 (x264) | Medium | 40-50% |
| H.265 (x265) | High | 10-20% |
| VP9 | High | 5-15% |
| MPEG-2 | Any | 60-70% |

### Encoding Speed (CPU, preset 6, 1080p)

| CPU Cores | Expected Speed |
|-----------|----------------|
| 4 cores | ~10-15 fps |
| 8 cores | ~20-30 fps |
| 16 cores | ~40-60 fps |

**With hardware decode:** Add 15-25% to speeds above

---

## 🏆 Best Practices

1. **Start with defaults** - The script is optimized out of the box
2. **Use hardware decode** - Free 15-25% speed boost if available
3. **Match jobs to content** - More jobs for small files, fewer for large 4K files
4. **Let CRF auto-detect** - Usually produces best results
5. **Use --dry-run first** - Preview before committing to large batches
6. **Enable notifications** - Know when long batches complete: `--notify`
7. **Check disk space** - Use `--check-space` for safety

---

## 🎓 Advanced Usage

### Batch Processing with Find

```bash
# Process all MKV files recursively
find /videos -type f -name "*.mkv" -exec shrink_all_mkv --jobs 8 {} +
```

### Custom CRF for Different Content

```bash
# High motion sports (higher CRF acceptable)
shrink_all_mkv --crf 32 /sports

# Anime/animation (lower CRF for quality)
shrink_all_mkv --crf 28 --tune-grain /anime
```

### Process and Move

```bash
# Process, then move originals to backup
shrink_all_mkv --jobs 8 /videos && mv /videos /backup
```

---

## 📝 Output Format

Files are encoded with:

- **Video:** AV1 codec (libsvtav1 by default)
- **Audio:** Copied (no re-encoding)
- **Subtitles:** Copied (no re-encoding)
- **Container:** MKV (Matroska)
- **Metadata:** Preserved

**Original files are replaced** after successful encoding. A backup temp file is created during encoding and only deleted after verification.

---

## 🌟 Real-World Example

**Scenario:** 1000 anime episodes, H.264 encoded, ~300MB each

```bash
shrink_all_mkv --hw-decode --preset 6 --auto-jobs --notify /anime

# Results:
# - Original: 300GB total
# - Compressed: 180GB total (40% savings)
# - Time: ~3-5 days (8 core CPU)
# - Quality: Visually transparent
```

---

## 📚 Feature Deep-Dive

### Force 10-bit Encoding (`--force-10bit`)

Forces encoding to 10-bit even when source is 8-bit.

**Benefits:**

- Better color precision (1024 vs 256 shades per channel)
- Eliminates banding in gradients and smooth areas
- Better compression efficiency at same visual quality
- Future-proofing (10-bit becoming standard)

**Use cases:**

- ✅ Anime/animation (flat colors, gradients)
- ✅ Archival/preservation encodes
- ✅ Content with visible banding in 8-bit
- ✅ High-quality source material

**Trade-offs:**

- ⚠️ Older devices (pre-2018) may not support 10-bit
- ~5-10% slower encoding (negligible)

**Example:**

```bash
# Force 10-bit for anime collection
shrink_all_mkv --force-10bit --tune-grain --preset 4 /anime

# With hardware acceleration
shrink_all_mkv --force-10bit --hw-decode --jobs 8 /videos
```

---

### Recursive Mode (`--recursive` or `-r`)

Process files in subdirectories, not just the target folder.

**Default behavior:** Non-recursive (only current directory) for safety

**Why non-recursive by default?**

- Prevents accidentally processing thousands of files
- Safer for testing and experimentation
- User explicitly opts into recursive processing

**Perfect for organized collections:**

```document
/videos/
  ├── anime/
  │   ├── show1/ (51 episodes)
  │   ├── show2/ (26 episodes)
  │   └── show3/ (40 episodes)
  ├── movies/
  │   └── various folders...
  └── tv-shows/
      └── various folders...
```

**Usage:**

```bash
# Non-recursive (default) - only /videos/*.mkv
shrink_all_mkv /videos

# Recursive - entire tree
shrink_all_mkv --recursive /videos
shrink_all_mkv -r /videos  # short form

# Dry-run first to see what would be processed
shrink_all_mkv -r --dry-run /videos

# Then process with optimal settings
shrink_all_mkv -r --hw-decode --auto-jobs --notify /videos
```

---

### Interactive Mode (`--interactive` or `-i`)

Visual file selection and configuration without memorizing CLI flags.

**Features:**

1. **Folder selection** - With recursive mode indicator
2. **Codec analysis** - See what's in your directory
3. **Codec skip selection** - Multi-select with fzf (skip AV1, HEVC, etc.)
4. **Encoding settings:**
   - Encoder (auto-detect or manual)
   - Preset (0-13, with recommendations)
   - CRF (auto-detect or manual)
   - Parallel jobs (1-N)
   - **Force 10-bit** - Better quality
   - **Hardware decode** - 15-25% faster
   - **Film grain mode** - Preserve texture
   - **Desktop notifications** - Alert when done
5. **Final summary** - Review before proceeding

**Example flow:**

```bash
# Start interactive mode
shrink_all_mkv --interactive

# With recursive
shrink_all_mkv --recursive --interactive
shrink_all_mkv -r -i  # short form
```

**Guided configuration:**

```bash
📂 Folder Selection
Enter path or press Enter for current directory

🔍 Analyzing codecs...
📋 Codecs Found:
   • H.264/AVC: 120 files, 45G
   • AV1: 8 files, 2.5G

🎯 Codec Skip Selection
[fzf multi-select interface]
✓ Selected to skip: AV1 (already optimal)

⚙️  Configure Encoding Settings
Encoder: [Enter for auto-detect] → libsvtav1
Preset: 6
CRF: [Enter for auto] → auto-detect
Jobs: 8
Force 10-bit? y → ✓ Will encode in 10-bit
Hardware decode? y → ✓ Enabled
Film grain mode? n → ✗ Standard
Notifications? y → ✓ Will notify

📊 Final Summary
   Files to process: 120
   Encoder: libsvtav1
   Preset: 6
   Bit depth: 10-bit (forced)
   Hardware decode: Enabled
   Jobs: 8
   Notification: Enabled

Proceed? [Y/n]
```

**Perfect for:**

- Beginners who want guidance
- Complex configurations without remembering flags
- Exploring what's in a directory before processing
- One-time encoding jobs

---

### Hardware Acceleration Details

**Hardware Decode (`--hw-decode`):**

- Offloads video decoding to GPU
- Frees CPU for encoding
- 15-25% faster overall
- Works with: AMD (VAAPI), NVIDIA (CUDA), Intel (QSV)
- No quality loss (lossless decode)

**Hardware Encode (`--hw-encoder`):**

- Full GPU encoding (50-100x faster!)
- Only for: NVIDIA RTX 40+, Intel ARC, AMD RX 7000+
- Quality trade-off: Slightly lower than CPU encoding
- Use for: Speed over quality, preview encodes, testing

**Check compatibility:**

```bash
shrink_all_mkv --hw-detect
```

---

### Variance Boost (Auto-Enabled)

Improves perceptual quality by 3-8% with minimal speed impact.

**What it does:**

- Allocates more bits to areas with high visual variance
- Reduces artifacts in complex scenes
- Enabled by default (recommended)

**Disable if needed:**

```bash
shrink_all_mkv --no-varboost /videos
```

---

### Film Grain Mode (`--tune-grain`)

Optimizes encoder for grainy content.

**When to use:**

- Old films with natural film grain
- Grainy anime transfers
- Content where preserving grain texture is important

**Example:**

```bash
shrink_all_mkv --tune-grain --preset 4 /old-films
```

---

### Auto-CRF Detection (Default)

Analyzes each file and sets optimal CRF based on:

- Resolution (720p, 1080p, 4K)
- Source quality (bitrate, encoding)
- Content complexity

**Manual override if needed:**

```bash
# High quality (lower CRF)
shrink_all_mkv --crf 25 /videos

# More compression (higher CRF)
shrink_all_mkv --crf 35 /videos
```

---

### Interrupted Summary

When you hit Ctrl+C after processing at least one file, you'll see:

```bash
🚨 Interrupted! Cleaning up...

╔════════════════════════════════════════╗
║     INTERRUPTED - PARTIAL SUMMARY      ║
╚════════════════════════════════════════╝
✅ Completed before interruption: 15 files
📊 Original size: 4.2G
📊 Compressed: 2.6G
💾 Saved: 1.6G (38.1%)
⏱️  Time: 01:23:45

💡 Progress saved! Run again to continue.
```

**Benefit:** Know what was accomplished even if stopping early

**Resume:** Two types of skips are logged in the target folder (`.skipped_shrink_mkv.log`): files whose encoded version was larger than the original, and files already in AV1 (so the next run can skip them without reading metadata). On the next run these files are skipped automatically. By default the log is removed when the script finishes normally. You can keep it with the **`--keep-skip-log`** option, or in **interactive mode** you will be asked at the end: "Conserver .skipped_shrink_mkv.log pour le prochain passage ? (o/N)". Format: one entry per line, either `av1|path` or `larger|path` (legacy lines with path only are treated as "larger").

---

## 🤝 Contributing

Issues and improvements welcome! This script is designed to be a practical tool for batch video compression.

---

## 📜 License

Free to use and modify. No warranty provided.

---

## 🙏 Credits

Built with:

- **FFmpeg** - The multimedia framework that does the actual work
- **SVT-AV1** - Default encoder (Intel's AV1 encoder)
- **GNU Parallel** - Enhanced parallelization (optional)

---

## 📞 Support

For issues specific to:

- **Encoding quality:** Adjust `--preset` and `--crf`
- **Performance:** Try `--hw-decode` and `--auto-jobs`
- **Compatibility:** Check FFmpeg version and encoder availability
- **Hardware acceleration:** Run `shrink_all_mkv --hw-detect`

---

**Version:** 1.0.0
**Last Updated:** February 2026
