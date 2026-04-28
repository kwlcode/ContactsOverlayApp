#!/bin/bash

# Subscription Files Cleanup Script
# This removes all duplicate subscription files and keeps only the correct ones

echo "🚀 Starting cleanup of duplicate subscription files..."
echo ""

# Navigate to project directory
cd /Users/moderncouture/Documents/XCODE/ContactsOverlayApp

# Show current state
echo "📋 Current subscription files:"
find . -name "*Subscription*" -type f
echo ""

# Remove all duplicates
echo "🗑️  Removing duplicate files..."

rm -f ./ContactsOverlayApp/Views/ContactsOverlayAppSubscriptionPaywallView.swift
rm -f ./ContactsOverlayApp/Views/ContactsOverlayAppSubscriptionManager.swift
rm -f ./ContactsOverlayApp.xcodeproj/SubscriptionManager.swift
rm -f ./ContactsOverlayApp.xcodeproj/SubscriptionPaywallView.swift
rm -f ./ContactsOverlayAppSubscriptionManager.swift
rm -f ./ContactsOverlayAppSubscriptionPaywallView.swift

echo "✅ Duplicates removed!"
echo ""

# Show final state
echo "📋 Remaining files (should be exactly 2):"
find . -name "*Subscription*" -type f
echo ""

# Count files
FILE_COUNT=$(find . -name "*Subscription*" -type f | wc -l)

if [ "$FILE_COUNT" -eq 2 ]; then
    echo "✅ SUCCESS! Exactly 2 subscription files remain."
    echo ""
    echo "Expected files:"
    echo "  ✅ ./ContactsOverlayApp/Views/SubscriptionManager.swift"
    echo "  ✅ ./ContactsOverlayApp/Views/SubscriptionPaywallView.swift"
else
    echo "⚠️  WARNING: Found $FILE_COUNT files (expected 2)"
    echo "Please check the files above."
fi

echo ""
echo "🔄 Next steps:"
echo "1. Close Xcode completely"
echo "2. Reopen your project"
echo "3. Clean Build Folder (⇧⌘K)"
echo "4. Build (⌘B)"
echo ""
echo "✅ Cleanup complete!"
