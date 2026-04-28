# 📱 App Store Screenshot Resize Guide

Having trouble getting the correct size screenshots for App Store Connect? This guide provides **multiple methods** to resize your screenshots properly.

## App Store Requirements

For **iPhone 15 Pro Max** (6.7" display):
- **Width:** 1290 pixels
- **Height:** 2796 pixels  
- **Format:** PNG or JPEG
- **Max file size:** 500 KB per screenshot (typically not an issue)

---

## Method 1: Automatic Script (Easiest!) ⭐

I've created a script that automatically resizes all your screenshots.

### Steps:

1. **Make the script executable:**
```bash
cd /path/to/your/project
chmod +x resize_screenshots.sh
```

2. **Run the script:**
```bash
./resize_screenshots.sh
```

3. **Find your resized screenshots:**
```
~/Desktop/AppStore_Screenshots/
```

That's it! The script finds all simulator screenshots on your Desktop and resizes them to the correct dimensions.

### What the script does:
- ✅ Finds all screenshots on your Desktop
- ✅ Resizes them to 1290 × 2796 pixels
- ✅ Saves them in `AppStore_Screenshots` folder
- ✅ Names them `AppStore_0.png`, `AppStore_1.png`, etc.
- ✅ Shows file sizes and dimensions

---

## Method 2: Terminal Commands (Quick)

If you prefer doing it manually, use these commands:

### Resize a single screenshot:

```bash
cd ~/Desktop

# Replace the filename with your actual screenshot name
sips -z 2796 1290 "Simulator Screenshot - iPhone 15 Pro Max - 2026-04-08 at 19.14.37.png" \
  --out "AppStore_Screenshot_1.png"
```

### Resize multiple screenshots at once:

```bash
cd ~/Desktop

# Resize all simulator screenshots
for file in Simulator*.png; do
  sips -z 2796 1290 "$file" --out "AppStore_${file}"
done
```

### Verify the size:

```bash
sips -g pixelWidth -g pixelHeight AppStore_Screenshot_1.png
```

Should show:
```
pixelWidth: 1290
pixelHeight: 2796
```

---

## Method 3: Preview App (Visual)

If you prefer a GUI:

### Steps:

1. **Open screenshot in Preview** (double-click the PNG file)

2. **Tools → Adjust Size...** (or ⌘⌥I)

3. **Enter exact dimensions:**
   - Width: `1290` pixels
   - Height: `2796` pixels
   - ⚠️ **UNCHECK** "Scale proportionally" 
   - Resolution: `72` pixels/inch (default)

4. **Click OK**

5. **File → Export...** (or ⇧⌘E)
   - Format: PNG
   - Name: `AppStore_Screenshot_1.png`
   - Save to Desktop

6. **Repeat for each screenshot**

---

## Method 4: Using Xcode (If available)

Xcode can generate properly sized screenshots automatically:

### Steps:

1. **Open your project in Xcode**

2. **Product → Test** (or ⌘U)

3. **Use UI Testing to capture screenshots:**

```swift
// In your UI tests:
let app = XCUIApplication()
app.launch()

// Navigate to the screen
// ...

// Take screenshot
let screenshot = app.screenshot()
let attachment = XCTAttachment(screenshot: screenshot)
attachment.lifetime = .keepAlways
add(attachment)
```

Xcode saves these at the correct resolution for each device.

---

## Method 5: Online Tools (No Terminal Needed)

If you're not comfortable with Terminal, use these websites:

### Recommended Sites:

1. **ResizeImage.net**
   - Go to: https://resizeimage.net
   - Upload your screenshot
   - Enter: 1290 × 2796 pixels
   - Download resized image

2. **ILoveIMG**
   - Go to: https://iloveimg.com/resize-image
   - Upload screenshot
   - Select "By pixels"
   - Enter: Width: 1290, Height: 2796
   - Download

3. **TinyPNG** (for compression if needed)
   - Go to: https://tinypng.com
   - Upload screenshot
   - Downloads compressed version

---

## Common Issues and Solutions

### Issue 1: "Invalid Screenshot Dimensions"

**Problem:** App Store Connect rejects your screenshots

**Solution:**
```bash
# Verify exact dimensions
sips -g pixelWidth -g pixelHeight your_screenshot.png

# Should show EXACTLY:
# pixelWidth: 1290
# pixelHeight: 2796
```

If not exact, resize again using Method 1 or 2.

---

### Issue 2: "Screenshot is portrait but should be in landscape orientation"

**Problem:** You uploaded a landscape screenshot to portrait slot

**Solution:**
- Make sure your screenshots are **portrait mode** (tall, not wide)
- Dimensions should be 1290 × 2796 (width × height)
- Not 2796 × 1290

**Fix wrong orientation:**
```bash
# Rotate if needed
sips -r 90 wrong_orientation.png --out correct_orientation.png

# Then resize
sips -z 2796 1290 correct_orientation.png --out final.png
```

---

### Issue 3: "File size too large"

**Problem:** Screenshot is over 500 KB (rare but possible)

**Solution 1 - Using Terminal:**
```bash
# Compress PNG
pngquant --quality=85-95 large_screenshot.png --output compressed.png
```

**Solution 2 - Using Preview:**
1. Open in Preview
2. File → Export
3. Format: PNG
4. Quality: Reduce slider slightly
5. Save

**Solution 3 - Using TinyPNG.com:**
- Upload your PNG
- It compresses automatically
- Download compressed version

---

### Issue 4: "Screenshot shows wrong device frame"

**Problem:** Screenshot has device bezels/frame around it

**Solution:**
- Don't use "Save Screenshot" from Simulator menu with device frame
- Use **⌘S** in Simulator for frameless screenshots
- Or crop out the device frame before resizing

---

### Issue 5: "I took screenshots on a real device"

**Problem:** Real device screenshots might be different sizes

**Solution:**

**iPhone 15 Pro Max (real device):**
- Native size: 1290 × 2796 ✅ (already correct!)
- No resize needed

**iPhone 14 Pro Max:**
- Native size: 1290 × 2796 ✅ (already correct!)

**iPhone 13 Pro Max:**
- Native size: 1284 × 2778 ❌ (needs resize)
- Resize to: 1290 × 2796

**To resize:**
```bash
sips -z 2796 1290 real_device_screenshot.png --out resized.png
```

---

## Complete Workflow Example

Here's a complete workflow from taking screenshots to uploading:

### Step 1: Take Screenshots in Simulator

```bash
# Launch your app in Xcode
⌘R (Run)

# In Simulator:
1. Navigate to your main screen
2. Press ⌘S (saves to Desktop)
3. Navigate to paywall
4. Press ⌘S
5. Take 3-5 different screenshots
```

### Step 2: Check What You Have

```bash
cd ~/Desktop
ls -lh Simulator*.png
```

You should see files like:
```
Simulator Screenshot - iPhone 15 Pro Max - 2026-04-08 at 19.14.37.png
Simulator Screenshot - iPhone 15 Pro Max - 2026-04-08 at 19.14.43.png
```

### Step 3: Run the Resize Script

```bash
cd /path/to/your/project
./resize_screenshots.sh
```

### Step 4: Verify Resized Screenshots

```bash
cd ~/Desktop/AppStore_Screenshots
ls -lh

# Check dimensions of first one
sips -g pixelWidth -g pixelHeight AppStore_0.png
```

Should show:
```
pixelWidth: 1290
pixelHeight: 2796
```

### Step 5: Upload to App Store Connect

1. Go to: https://appstoreconnect.apple.com
2. My Apps → [Your App]
3. App Store tab
4. Scroll to **App Previews and Screenshots**
5. Select **iPhone 6.7" Display**
6. **Drag and drop** your `AppStore_*.png` files
7. **Reorder** them as desired (drag to rearrange)
8. Click **Save**

---

## Screenshot Order Best Practices

### Recommended Order:

1. **Main Feature** - Show your app's core value immediately
2. **Key Feature 1** - Second most important feature
3. **Key Feature 2** - Third most important
4. **Premium/Pricing** - Show what's available (if applicable)
5. **Additional Features** - Supporting features

### For Your Contacts App:

```
Screenshot 1: Main contact list with dates visible
  Caption: "Track when you added each contact"

Screenshot 2: Search in action with results
  Caption: "Find contacts instantly with powerful search"

Screenshot 3: Sort overlay showing options
  Caption: "Organize contacts by name, newest, or oldest"

Screenshot 4: Paywall top (premium features)
  Caption: "Unlock unlimited contacts and advanced features"

Screenshot 5: Paywall pricing
  Caption: "7-day free trial, then just $19.99/year"
```

---

## Quick Reference: Required Sizes by Device

| Device | Size (pixels) | Notes |
|--------|---------------|-------|
| iPhone 15 Pro Max | 1290 × 2796 | ✅ Your target |
| iPhone 15 Plus | 1290 × 2796 | Same as Pro Max |
| iPhone 14 Pro Max | 1290 × 2796 | Same as 15 Pro Max |
| iPhone 14 Plus | 1290 × 2796 | Same as above |
| iPhone 13 Pro Max | 1284 × 2778 | Slightly different |
| iPhone 11 Pro Max | 1242 × 2688 | 6.5" display |
| iPhone 8 Plus | 1242 × 2208 | 5.5" display |

**You only need ONE size** (1290 × 2796) to submit. Apple scales for other devices.

---

## Testing Your Screenshots

Before uploading, verify:

### Checklist:

```
□ Dimensions are EXACTLY 1290 × 2796 pixels
□ File format is PNG or JPEG
□ File size is under 500 KB (usually automatic)
□ Screenshots are portrait orientation (tall, not wide)
□ Content is clear and readable
□ No personal information visible (if applicable)
□ Status bar shows good signal/battery (cosmetic)
□ Time shows 9:41 AM (Apple convention, optional)
□ Screenshots show your app in best light
```

### Verify Command:

```bash
cd ~/Desktop/AppStore_Screenshots

for file in *.png; do
  echo "Checking: $file"
  sips -g pixelWidth -g pixelHeight -g format "$file" | grep -E "pixelWidth|pixelHeight|format"
  echo ""
done
```

Expected output for each:
```
pixelWidth: 1290
pixelHeight: 2796
format: png
```

---

## Still Having Issues?

### Symptom: "The image asset must be..." error

**Most common causes:**

1. **Wrong dimensions**
   - Solution: Use exact dimensions 1290 × 2796

2. **Wrong orientation**
   - Solution: Portrait (tall), not landscape (wide)

3. **Wrong file format**
   - Solution: Use PNG or JPEG, not HEIC or other formats

4. **Corrupted file**
   - Solution: Re-export from Preview or re-take screenshot

### Debug Steps:

```bash
# 1. Check file type
file your_screenshot.png

# Should show: PNG image data, 1290 x 2796, ...

# 2. Check dimensions
sips -g pixelWidth -g pixelHeight your_screenshot.png

# 3. Check file size
ls -lh your_screenshot.png

# 4. If all else fails, convert and resize fresh
sips -s format png original.png --out temp.png
sips -z 2796 1290 temp.png --out final.png
```

---

## Alternative: Use App Store Screenshots Template

Apple provides official templates with device frames:

### Download:

1. Go to: https://developer.apple.com/app-store/marketing/guidelines/
2. Scroll to **Product Pages**
3. Download **App Store Screenshots Templates**
4. Use Photoshop/Sketch to place your screenshots in frames

This ensures perfect dimensions but requires design software.

---

## Summary

### Fastest Method (Recommended):

```bash
# 1. Navigate to your project
cd /path/to/your/contacts/project

# 2. Make script executable (first time only)
chmod +x resize_screenshots.sh

# 3. Run the script
./resize_screenshots.sh

# 4. Upload files from ~/Desktop/AppStore_Screenshots
```

### Manual Method (If script doesn't work):

```bash
cd ~/Desktop

# Resize each screenshot
sips -z 2796 1290 "your-screenshot.png" --out "AppStore_1.png"
```

### GUI Method (If you prefer visual):

1. Open screenshot in Preview
2. Tools → Adjust Size
3. Enter: 1290 × 2796
4. Save

---

## Need More Help?

Common issues:
- **"Permission denied"** → Run: `chmod +x resize_screenshots.sh`
- **"Command not found"** → Use Preview method instead (works on all Macs)
- **"Wrong size"** → Double-check you entered 1290 × 2796 (not 2796 × 1290)
- **"Can't upload"** → Try different browser or clear cache

Still stuck? Check:
1. Screenshot file isn't corrupted (open it in Preview)
2. You're uploading to correct device size slot (6.7")
3. File is PNG or JPEG format
4. Dimensions are exact (use `sips -g` to verify)

---

**Ready to upload!** 🚀

Your screenshots will look great in the App Store!
