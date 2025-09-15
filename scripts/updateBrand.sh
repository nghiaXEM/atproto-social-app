#!/usr/bin/env bash
set -euo pipefail

# ======================
# Config
# ======================
SOURCE_DIR="your-brand"
TARGET_DIR="."
LOCALED_DIR="src/locale/locales"

read -rp "🔤 Nhập chuỗi thay thế cho 'Bluesky': " REPLACEMENT

if [ -z "$REPLACEMENT" ]; then
  echo "❌ Bạn chưa nhập chuỗi thay thế!"
  exit 1
fi

# ======================
# Check rsync
# ======================
if ! command -v rsync &> /dev/null; then
  echo "⚠️  rsync chưa được cài. Đang tiến hành cài đặt..."

  if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y rsync
  elif command -v apk &> /dev/null; then
    sudo apk add --no-cache rsync
  elif command -v yum &> /dev/null; then
    sudo yum install -y rsync
  else
    echo "❌ Không tìm thấy package manager phù hợp (apt-get, apk, yum)."
    exit 1
  fi

  echo "✅ Đã cài rsync thành công."
fi

# ======================
# Thực thi
# ======================

echo "🔍 Bắt đầu replace file từ $SOURCE_DIR vào $TARGET_DIR ..."
echo

# Dùng rsync để copy và ghi đè file
rsync -av --progress "$SOURCE_DIR"/ "$TARGET_DIR"/

echo
echo "✅ Hoàn thành replace!"

# Duyệt tất cả messages.po trong subfolder
find "$LOCALED_DIR" -type f -name "messages.po" | while read -r file; do
  echo "🔍 Processing: $file"

  # Chỉ thay trong dòng bắt đầu bằng msgstr
  if grep -q 'msgstr' "$file"; then
    sed -i "s/^\(msgstr[^\"]*\".*\)Bluesky\(.*\"\)/\1$REPLACEMENT\2/g" "$file"
    echo "✅ Updated: $file"
  else
    echo "ℹ️ No match in: $file"
  fi
done
