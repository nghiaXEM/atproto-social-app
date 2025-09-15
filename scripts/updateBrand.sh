#!/usr/bin/env bash
set -euo pipefail

# ======================
# Config
# ======================
SOURCE_DIR="your-brand"
TARGET_DIR="."
LOCALED_DIR="src/locale/locales"
ENV_FILE=".env"

# Các chuỗi gốc cần thay
BLUESKY_APP_NAME="Bluesky"
BLUESKY_BSKY_SOCIAL_URL="https://bsky.social"
BLUESKY_APP_URL="https://bsky.app"

APP_NAME_VALUE=Binary
APP_SOCIAL_URL_VALUE=https://www.bsky.global
APP_URL_VALUE=https://bsky.global

# ======================
# Nhập từ người dùng
# ======================
read -rp "🔤 Nhập chuỗi thay thế cho 'Bluesky' trong messages.po: " REPLACEMENT
if [ -z "$REPLACEMENT" ]; then
  echo "❌ Bạn chưa nhập chuỗi thay thế!"
  exit 1
fi

# ======================
# Load biến từ .env
# ======================
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Không tìm thấy file $ENV_FILE"
  exit 1
fi

get_env_value() {
  local var_name="$1"
  local value
  value=$(grep -E "^${var_name}=" "$ENV_FILE" | cut -d '=' -f2- || true)
  if [ -z "$value" ]; then
    echo "❌ Không tìm thấy biến $var_name trong $ENV_FILE"
    exit 1
  fi
  echo "$value"
}

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
# Thực thi copy
# ======================
echo "🔍 Bắt đầu replace file từ $SOURCE_DIR vào $TARGET_DIR ..."
rsync -av --progress "$SOURCE_DIR"/ "$TARGET_DIR"/
echo "✅ Hoàn thành copy!"

# ======================
# Replace trong messages.po
# ======================
find "$LOCALED_DIR" -type f -name "messages.po" | while read -r file; do
  echo "🔍 Processing: $file"
  sed -i "s/^\(msgstr[^\"]*\".*\)Bluesky\(.*\"\)/\1$REPLACEMENT\2/g" "$file"
  echo "✅ Updated: $file"
done

# ======================
# Replace trong HTML
# ======================
echo "🔍 Bắt đầu replace trong .html ..."
find . -type f -name "*.html" | while read -r file; do
  changes=0
  if grep -q "$BLUESKY_BSKY_SOCIAL_URL" "$file"; then
    sed -i "s|${BLUESKY_BSKY_SOCIAL_URL}|${APP_SOCIAL_URL_VALUE}|g" "$file"
    changes=1
  fi
  if grep -q "$BLUESKY_APP_NAME" "$file"; then
    sed -i "s|${BLUESKY_APP_NAME}|${APP_NAME_VALUE}|g" "$file"
    changes=1
  fi
  if grep -q "$BLUESKY_APP_URL" "$file"; then
    sed -i "s|${BLUESKY_APP_URL}|${APP_URL_VALUE}|g" "$file"
    changes=1
  fi
  [[ $changes -eq 1 ]] && echo "✅ Updated: $file" || echo "ℹ️ No match in: $file"
done



LOGO_SOURCE_FILE="assets/logo.png"              # file nguồn
LOGO_TARGET_DIRS=("bskyweb/templates" "web")  # danh sách thư mục đích
# ======================
# Check file tồn tại
# ======================
if [ ! -f "$LOGO_SOURCE_FILE" ]; then
  echo "❌ Không tìm thấy file: $LOGO_SOURCE_FILE"
  exit 1
fi

# ======================
# Thực hiện copy
# ======================
for dir in "${LOGO_TARGET_DIRS[@]}"; do
  # Tạo folder nếu chưa có
  mkdir -p "$dir"
  
  # Copy file
  cp "$LOGO_SOURCE_FILE" "$dir/"
  echo "✅ Đã copy $LOGO_SOURCE_FILE vào $dir/"
done

echo "🎉 Done!"
