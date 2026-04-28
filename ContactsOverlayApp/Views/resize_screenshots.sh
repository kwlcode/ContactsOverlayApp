#!/bin/bash

# App Store Screenshot Resizer
# Resizes simulator screenshots to App Store Connect requirements

echo "📱 App Store Screenshot Resizer"
echo "================================"
echo ""

# Check if sips is available (built into macOS)
if ! command -v sips &> /dev/null; then
    echo "❌ Error: sips command not found"
    echo "This script requires macOS"
    exit 1
fi

# Screenshot directory (Desktop by default)
SCREENSHOT_DIR="$HOME/Desktop"
OUTPUT_DIR="$HOME/Desktop/AppStore_Screenshots"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "📂 Looking for screenshots in: $SCREENSHOT_DIR"
echo "💾 Saving resized images to: $OUTPUT_DIR"
echo ""

# App Store Connect requirements for different iPhone sizes
# iPhone 6.7" Display (iPhone 15 Pro Max, 15 Plus, 14 Pro Max, etc.)
TARGET_WIDTH=1290
TARGET_HEIGHT=2796

echo "🎯 Target size: ${TARGET_WIDTH} × ${TARGET_HEIGHT} pixels"
echo ""

# Find all PNG files that look like simulator screenshots
count=0
for file in "$SCREENSHOT_DIR"/Simulator*.png "$SCREENSHOT_DIR"/Screenshot*.png; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        output_file="$OUTPUT_DIR/AppStore_${count}.png"
        
        echo "Processing: $filename"
        
        # Get current dimensions
        current_width=$(sips -g pixelWidth "$file" | tail -1 | awk '{print $2}')
        current_height=$(sips -g pixelHeight "$file" | tail -1 | awk '{print $2}')
        
        echo "  Current size: ${current_width} × ${current_height}"
        
        # Resize to App Store requirements
        sips -z $TARGET_HEIGHT $TARGET_WIDTH "$file" --out "$output_file" > /dev/null 2>&1
        
        if [ $? -eq 0 ]; then
            echo "  ✅ Saved: $output_file"
            echo "  New size: ${TARGET_WIDTH} × ${TARGET_HEIGHT}"
            
            # Get file size
            filesize=$(ls -lh "$output_file" | awk '{print $5}')
            echo "  File size: $filesize"
            echo ""
            
            count=$((count + 1))
        else
            echo "  ❌ Failed to resize"
            echo ""
        fi
    fi
done

if [ $count -eq 0 ]; then
    echo "❌ No screenshots found in $SCREENSHOT_DIR"
    echo ""
    echo "💡 Tips:"
    echo "  1. Take screenshots in iOS Simulator (⌘S)"
    echo "  2. Screenshots are saved to Desktop by default"
    echo "  3. Make sure filenames contain 'Simulator' or 'Screenshot'"
    echo ""
    echo "📍 Or drag your screenshots to Desktop and run this script again"
else
    echo "✅ Successfully resized $count screenshot(s)!"
    echo ""
    echo "📁 Your App Store ready screenshots are in:"
    echo "   $OUTPUT_DIR"
    echo ""
    echo "🚀 Next steps:"
    echo "  1. Open $OUTPUT_DIR"
    echo "  2. Go to App Store Connect → Your App → Screenshots"
    echo "  3. Select 'iPhone 6.7\" Display'"
    echo "  4. Drag and drop the AppStore_*.png files"
    echo ""
    echo "✨ Done! Ready to upload to App Store Connect!"
fi


