#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/iddixx/diktor_ua.git"
XKB_DIR="/usr/share/X11/xkb"
SYMBOLS_FILE="$XKB_DIR/symbols/ua"
RULES_XML="$XKB_DIR/rules/evdev.xml"
RULES_LST="$XKB_DIR/rules/evdev.lst"
LAYOUT_DESC="Ukrainian (Diktor)"

if [[ $EUID -ne 0 ]]; then
   echo "[!] Запустіть скрипт з root правами: sudo bash $0"
   exit 1
fi

echo "[*] Перевірка залежностей (git, xmlstarlet, x11-xkb-utils)..."
apt-get install -y -qq git xmlstarlet x11-xkb-utils

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "[*] Клонування репозиторія $REPO_URL..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR/diktor_ua"

SRC_FILE=$(grep -rl "xkb_symbols" "$TMP_DIR/diktor_ua" | head -n 1 || true)

if [[ -z "$SRC_FILE" ]]; then
    echo "[!] Не вдалось автоматично знайти блок 'xkb_symbols' у репозиторії."
    echo "Зміст репозиторію:"
    find "$TMP_DIR/diktor_ua" -maxdepth 2 -not -path '*/.*'
    exit 1
fi

VARIANT_NAME=$(sed -n 's/.*xkb_symbols[[:space:]]*"\([^"]*\)".*/\1/p' "$SRC_FILE" | head -n 1)
if [[ -z "$VARIANT_NAME" ]]; then
    VARIANT_NAME="diktor"
fi

echo "[*] Знайденний файл розкладки: $(basename "$SRC_FILE") (вариант: $VARIANT_NAME)"

BACKUP_SUFFIX=".bak.$(date +%Y%m%d_%H%M%S)"
cp "$SYMBOLS_FILE" "${SYMBOLS_FILE}${BACKUP_SUFFIX}"
cp "$RULES_XML" "${RULES_XML}${BACKUP_SUFFIX}"
cp "$RULES_LST" "${RULES_LST}${BACKUP_SUFFIX}"
echo "[*] Резервні копії створені з суффіксом $BACKUP_SUFFIX"

if grep -q "xkb_symbols \"$VARIANT_NAME\"" "$SYMBOLS_FILE"; then
    echo "[*] Варіант '$VARIANT_NAME' вже є в $SYMBOLS_FILE. Пропускаем..."
else
    echo "[*] Додаємо блок символів в $SYMBOLS_FILE..."
    echo -e "\n// --- Added by diktor_ua installer ---" >> "$SYMBOLS_FILE"
    cat "$SRC_FILE" >> "$SYMBOLS_FILE"
fi

if xmlstarlet sel -t -v "//layout[configItem/name='ua']/variantList/variant[configItem/name='$VARIANT_NAME']/configItem/name" "$RULES_XML" | grep -q "$VARIANT_NAME"; then
    echo "[*] Варіант '$VARIANT_NAME' вже зареєстрованний в $RULES_XML."
else
    echo "[*] Реєстрація в $RULES_XML..."
    xmlstarlet ed -L \
        -s "//layout[configItem/name='ua']/variantList" -t elem -n "variant_tmp" -v "" \
        -s "//variant_tmp" -t elem -n "configItem" -v "" \
        -s "//variant_tmp/configItem" -t elem -n "name" -v "$VARIANT_NAME" \
        -s "//variant_tmp/configItem" -t elem -n "description" -v "$LAYOUT_DESC" \
        -r "//variant_tmp" -v "variant" \
        "$RULES_XML"
fi

if grep -qE "^[[:space:]]*$VARIANT_NAME[[:space:]]+ua:" "$RULES_LST"; then
    echo "[*] Варіант '$VARIANT_NAME' вже зареєстрованний в $RULES_LST."
else
    echo "[*] Реєстрація в $RULES_LST..."
    awk -v var="$VARIANT_NAME" -v desc="$LAYOUT_DESC" '
    /^! variant/ { in_var=1 }
    in_var && /^$/ {
        printf "  %-15s ua: %s\n", var, desc
        in_var=0
    }
    { print }
    ' "$RULES_LST" > "${RULES_LST}.tmp" && mv "${RULES_LST}.tmp" "$RULES_LST"
fi

rm -rf /var/lib/xkb/* 2>/dev/null || true

echo "============================================================"
echo "[+] Встановленно!"
echo "    Мова (Layout):     ua"
echo "    Варіант (Variant): $VARIANT_NAME ($LAYOUT_DESC)"
echo "------------------------------------------------------------"
echo "Активувати  X11:"
echo "    setxkbmap -layout us,ua -variant ,$VARIANT_NAME"
echo ""
echo "Щоб воно з'явилось у GUI-налаштуваннях (GNOME / KDE / XFCE) перезапустіть сессію."
echo "============================================================"
