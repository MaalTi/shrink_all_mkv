#!/bin/bash
# shrink_all_mkv - Example Usage Script
# Version: 1.0.0
# 
# This script demonstrates various usage patterns and features.
# Choose a scenario that matches your needs!

set -e  # Exit on error

# Colors
C_BOLD="\033[1m"
C_GREEN="\033[32m"
C_CYAN="\033[36m"
C_YELLOW="\033[33m"
C_RESET="\033[0m"

echo -e "${C_BOLD}╔═══════════════════════════════════════════════════════════╗${C_RESET}"
echo -e "${C_BOLD}║       shrink_all_mkv - Example Usage Scenarios           ║${C_RESET}"
echo -e "${C_BOLD}║                  Version 1.0.0                            ║${C_RESET}"
echo -e "${C_BOLD}╚═══════════════════════════════════════════════════════════╝${C_RESET}"
echo ""

# Find the script
SCRIPT=""
if [ -f "./shrink_all_mkv" ]; then
    SCRIPT="./shrink_all_mkv"
elif command -v shrink_all_mkv &> /dev/null; then
    SCRIPT="shrink_all_mkv"
else
    echo "❌ shrink_all_mkv not found!"
    echo "   Place this example script in the same directory as shrink_all_mkv"
    echo "   Or install shrink_all_mkv to your PATH"
    exit 1
fi

echo -e "${C_GREEN}✓${C_RESET} Found script: $SCRIPT"
echo ""

# Make it executable if local
if [ -f "./shrink_all_mkv" ]; then
    chmod +x ./shrink_all_mkv
fi

# Show scenarios
echo -e "${C_BOLD}Choose a usage scenario:${C_RESET}"
echo ""
echo -e "${C_CYAN}Basic Scenarios:${C_RESET}"
echo "  1) Quick Start - Interactive mode (recommended for beginners)"
echo "  2) Single Directory - Process one folder"
echo "  3) Dry Run - Preview what would be done"
echo ""
echo -e "${C_CYAN}Common Use Cases:${C_RESET}"
echo "  4) Anime Collection - Recursive, 10-bit, film grain"
echo "  5) Large Batch - Fast processing with hardware acceleration"
echo "  6) High Quality Archive - Slow preset, 10-bit, preserve quality"
echo "  7) Organized Library - Recursive with subdirectories"
echo ""
echo -e "${C_CYAN}Advanced Scenarios:${C_RESET}"
echo "  8) Skip Efficient Codecs - Only convert old formats"
echo "  9) Test Hardware Acceleration - Check your GPU support"
echo "  10) Custom Configuration - Fine-tune all parameters"
echo ""
echo -e "${C_CYAN}Diagnostic Tools:${C_RESET}"
echo "  11) List Codecs - Scan directory and show codec statistics"
echo "  12) Show Help - Display all available options"
echo ""
echo -e "  ${C_YELLOW}q)${C_RESET} Quit"
echo ""

read -p "$(echo -e "${C_BOLD}Select scenario [1-12]:${C_RESET} ")" choice
echo ""

case "$choice" in
    1)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 1: Quick Start - Interactive Mode${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Interactive mode guides you through all options:"
        echo "  • Visual file selection with fzf"
        echo "  • Codec analysis and skip selection"
        echo "  • Guided parameter configuration"
        echo "  • No need to memorize CLI flags!"
        echo ""
        read -p "Target directory [default: current directory]: " target_dir
        target_dir="${target_dir:-.}"
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET} $SCRIPT --interactive \"$target_dir\""
        echo ""
        $SCRIPT --interactive "$target_dir"
        ;;
    
    2)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 2: Single Directory - Basic Processing${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Simple processing with auto-detection:"
        echo "  • Auto-detect encoder (SVT-AV1 preferred)"
        echo "  • Auto-detect CRF per file"
        echo "  • Preset 6 (balanced)"
        echo "  • 4 parallel jobs"
        echo ""
        read -p "Target directory [default: current directory]: " target_dir
        target_dir="${target_dir:-.}"
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET} $SCRIPT \"$target_dir\""
        echo ""
        $SCRIPT "$target_dir"
        ;;
    
    3)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 3: Dry Run - Preview Mode${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Preview what would be done without encoding:"
        echo "  • Shows files that would be processed"
        echo "  • Shows files that would be skipped"
        echo "  • Safe - no modifications"
        echo ""
        read -p "Target directory [default: current directory]: " target_dir
        target_dir="${target_dir:-.}"
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET} $SCRIPT --dry-run \"$target_dir\""
        echo ""
        $SCRIPT --dry-run "$target_dir"
        ;;
    
    4)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 4: Anime Collection${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Optimized for anime/animation:"
        echo "  • Recursive processing (all subdirectories)"
        echo "  • Force 10-bit (better gradients, less banding)"
        echo "  • Film grain optimization (preserve texture)"
        echo "  • Hardware decode (15-25% faster)"
        echo "  • Preset 4 (higher quality)"
        echo "  • Desktop notification when done"
        echo ""
        read -p "Anime collection directory: " target_dir
        if [ -z "$target_dir" ]; then
            echo "❌ Directory required for this scenario"
            exit 1
        fi
        echo ""
        read -p "Number of parallel jobs [default: 8]: " jobs
        jobs="${jobs:-8}"
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET}"
        echo "  $SCRIPT \\"
        echo "    --recursive \\"
        echo "    --force-10bit \\"
        echo "    --tune-grain \\"
        echo "    --hw-decode \\"
        echo "    --preset 4 \\"
        echo "    --jobs $jobs \\"
        echo "    --notify \\"
        echo "    \"$target_dir\""
        echo ""
        read -p "Proceed? [Y/n] " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            $SCRIPT --recursive --force-10bit --tune-grain --hw-decode --preset 4 --jobs "$jobs" --notify "$target_dir"
        fi
        ;;
    
    5)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 5: Large Batch - Speed Optimized${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Fast processing for large collections:"
        echo "  • Recursive processing"
        echo "  • Hardware decode (GPU offloading)"
        echo "  • Preset 8 (faster encoding)"
        echo "  • Auto-calculate optimal job count"
        echo "  • Desktop notification"
        echo "  • Quiet mode (errors only)"
        echo ""
        read -p "Video library directory: " target_dir
        if [ -z "$target_dir" ]; then
            echo "❌ Directory required for this scenario"
            exit 1
        fi
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET}"
        echo "  $SCRIPT \\"
        echo "    --recursive \\"
        echo "    --hw-decode \\"
        echo "    --preset 8 \\"
        echo "    --auto-jobs \\"
        echo "    --notify \\"
        echo "    --quiet \\"
        echo "    \"$target_dir\""
        echo ""
        read -p "Proceed? [Y/n] " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            $SCRIPT --recursive --hw-decode --preset 8 --auto-jobs --notify --quiet "$target_dir"
        fi
        ;;
    
    6)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 6: High Quality Archive${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Maximum quality for archival:"
        echo "  • Force 10-bit (better color precision)"
        echo "  • Preset 3 (very slow but excellent quality)"
        echo "  • CRF 25 (high quality setting)"
        echo "  • Fewer jobs for stability"
        echo "  • Hardware decode for speed boost"
        echo ""
        read -p "Archive directory: " target_dir
        if [ -z "$target_dir" ]; then
            echo "❌ Directory required for this scenario"
            exit 1
        fi
        echo ""
        echo -e "${C_YELLOW}Warning:${C_RESET} Preset 3 is very slow!"
        echo "Estimated time: ~1-2 hours per file (1080p)"
        echo ""
        read -p "Proceed? [y/N] " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo ""
            echo -e "${C_GREEN}Running:${C_RESET}"
            echo "  $SCRIPT \\"
            echo "    --force-10bit \\"
            echo "    --preset 3 \\"
            echo "    --crf 25 \\"
            echo "    --hw-decode \\"
            echo "    --jobs 4 \\"
            echo "    --notify \\"
            echo "    \"$target_dir\""
            echo ""
            $SCRIPT --force-10bit --preset 3 --crf 25 --hw-decode --jobs 4 --notify "$target_dir"
        fi
        ;;
    
    7)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 7: Organized Library - Recursive Processing${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Process directory tree with subdirectories:"
        echo "  Example structure:"
        echo "    /videos/"
        echo "      ├── anime/show1/"
        echo "      ├── anime/show2/"
        echo "      ├── movies/action/"
        echo "      └── tv-shows/series1/"
        echo ""
        echo "Settings:"
        echo "  • Recursive mode (all subdirectories)"
        echo "  • Hardware decode"
        echo "  • Balanced preset (6)"
        echo "  • Optimal job count"
        echo ""
        read -p "Root directory: " target_dir
        if [ -z "$target_dir" ]; then
            echo "❌ Directory required for this scenario"
            exit 1
        fi
        echo ""
        echo "First, let's preview what would be processed..."
        echo ""
        $SCRIPT --recursive --dry-run "$target_dir"
        echo ""
        read -p "Proceed with actual processing? [y/N] " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo ""
            echo -e "${C_GREEN}Running:${C_RESET}"
            echo "  $SCRIPT --recursive --hw-decode --auto-jobs --notify \"$target_dir\""
            echo ""
            $SCRIPT --recursive --hw-decode --auto-jobs --notify "$target_dir"
        fi
        ;;
    
    8)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 8: Skip Efficient Codecs${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Only convert old/inefficient formats:"
        echo "  • Skip AV1 (already optimal)"
        echo "  • Skip HEVC (already efficient)"
        echo "  • Skip VP9 (already efficient)"
        echo "  • Convert H.264, MPEG-2, etc."
        echo ""
        read -p "Target directory [default: current directory]: " target_dir
        target_dir="${target_dir:-.}"
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET}"
        echo "  $SCRIPT \\"
        echo "    --skip-codec av1 \\"
        echo "    --skip-codec hevc \\"
        echo "    --skip-codec vp9 \\"
        echo "    --hw-decode \\"
        echo "    --jobs 8 \\"
        echo "    \"$target_dir\""
        echo ""
        $SCRIPT --skip-codec av1 --skip-codec hevc --skip-codec vp9 --hw-decode --jobs 8 "$target_dir"
        ;;
    
    9)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 9: Test Hardware Acceleration${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Check hardware support:"
        echo ""
        $SCRIPT --hw-detect
        echo ""
        echo "Hardware decode support:"
        echo "  • AMD GPUs: VAAPI (most Radeon cards)"
        echo "  • NVIDIA GPUs: CUDA (GTX 900+)"
        echo "  • Intel GPUs: QSV (HD Graphics 500+)"
        echo ""
        echo "Hardware AV1 encoding support:"
        echo "  • NVIDIA: RTX 40-series (Ada Lovelace)"
        echo "  • Intel: ARC A-series (Alchemist/Battlemage)"
        echo "  • AMD: RX 7000-series (RDNA3)"
        echo ""
        read -p "Test hardware decode on a file? [y/N] " -n 1 -r
        echo ""
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo ""
            read -p "Path to test file: " test_file
            if [ -n "$test_file" ] && [ -f "$test_file" ]; then
                echo ""
                echo "Testing with hardware decode..."
                $SCRIPT --hw-decode --jobs 1 "$test_file"
            else
                echo "❌ File not found: $test_file"
            fi
        fi
        ;;
    
    10)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 10: Custom Configuration${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Build a custom command with your preferred settings:"
        echo ""
        
        read -p "Target directory: " target_dir
        if [ -z "$target_dir" ]; then
            target_dir="."
        fi
        
        read -p "Recursive? [y/N]: " -n 1 -r recursive
        echo ""
        
        read -p "Encoder [libsvtav1/libaom-av1/librav1e] (Enter for auto): " encoder
        
        read -p "Preset [0-13] (Enter for 6): " preset
        preset="${preset:-6}"
        
        read -p "CRF [0-63] (Enter for auto): " crf
        
        read -p "Parallel jobs (Enter for 4): " jobs
        jobs="${jobs:-4}"
        
        read -p "Force 10-bit? [y/N]: " -n 1 -r force_10bit
        echo ""
        
        read -p "Hardware decode? [y/N]: " -n 1 -r hw_decode
        echo ""
        
        read -p "Film grain mode? [y/N]: " -n 1 -r tune_grain
        echo ""
        
        read -p "Desktop notification? [y/N]: " -n 1 -r notify
        echo ""
        
        # Build command
        cmd="$SCRIPT"
        [[ $recursive =~ ^[Yy]$ ]] && cmd="$cmd --recursive"
        [ -n "$encoder" ] && cmd="$cmd --encoder $encoder"
        cmd="$cmd --preset $preset"
        [ -n "$crf" ] && cmd="$cmd --crf $crf"
        cmd="$cmd --jobs $jobs"
        [[ $force_10bit =~ ^[Yy]$ ]] && cmd="$cmd --force-10bit"
        [[ $hw_decode =~ ^[Yy]$ ]] && cmd="$cmd --hw-decode"
        [[ $tune_grain =~ ^[Yy]$ ]] && cmd="$cmd --tune-grain"
        [[ $notify =~ ^[Yy]$ ]] && cmd="$cmd --notify"
        cmd="$cmd \"$target_dir\""
        
        echo ""
        echo -e "${C_GREEN}Your custom command:${C_RESET}"
        echo "  $cmd"
        echo ""
        read -p "Execute this command? [Y/n] " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            eval $cmd
        fi
        ;;
    
    11)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 11: List Codecs - Directory Analysis${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        echo "Scan directory and show codec statistics:"
        echo "  • Shows all video codecs present"
        echo "  • File counts per codec"
        echo "  • Total size per codec"
        echo "  • Helps plan conversion strategy"
        echo ""
        read -p "Target directory [default: current directory]: " target_dir
        target_dir="${target_dir:-.}"
        echo ""
        echo -e "${C_GREEN}Running:${C_RESET} $SCRIPT --list-codecs \"$target_dir\""
        echo ""
        $SCRIPT --list-codecs "$target_dir"
        ;;
    
    12)
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo -e "${C_BOLD}Scenario 12: Show Help${C_RESET}"
        echo -e "${C_BOLD}═══════════════════════════════════════════════════════════${C_RESET}"
        echo ""
        $SCRIPT --help
        ;;
    
    q|Q)
        echo "Goodbye!"
        exit 0
        ;;
    
    *)
        echo "❌ Invalid selection: $choice"
        exit 1
        ;;
esac

echo ""
echo -e "${C_GREEN}✓${C_RESET} Scenario complete!"
echo ""

