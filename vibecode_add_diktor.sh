#!/usr/bin/env bash
# Установка украинской раскладки Diktor (Ukrainian Typewriter) в XKB.
# Запуск:  sudo ./add_diktor.sh   (из корня репозитория)
set -euo pipefail

XKB=/usr/share/X11/xkb
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/linux/diktor"
RAW_URL="https://raw.githubusercontent.com/iddixx/diktor_ua/main/linux/diktor"

if [[ $EUID -ne 0 ]]; then
    echo "Нужны права root. Запустите: sudo $0" >&2
    exit 1
fi

if [[ ! -d $XKB ]]; then
    echo "Не найден каталог $XKB — XKB не установлен?" >&2
    exit 1
fi

# --- 0. Получаем файл раскладки (локально или из GitHub) ---------------------
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

if [[ -f $SRC ]]; then
    cp "$SRC" "$TMP"
elif command -v curl >/dev/null; then
    curl -fsSL "$RAW_URL" -o "$TMP"
elif command -v wget >/dev/null; then
    wget -qO "$TMP" "$RAW_URL"
else
    echo "Не найден $SRC, а curl/wget отсутствуют." >&2
    exit 1
fi

if ! grep -q 'xkb_symbols "diktor"' "$TMP"; then
    echo "В файле раскладки нет блока xkb_symbols \"diktor\" — файл повреждён?" >&2
    exit 1
fi

# --- 1. symbols/ua: добавляем вариант diktor ---------------------------------
if grep -q 'xkb_symbols "diktor"' "$XKB/symbols/ua"; then
    echo "[1/3] symbols/ua: diktor уже есть, пропускаю"
else
    cp -n "$XKB/symbols/ua" "$XKB/symbols/ua.bak-diktor"
    { echo; cat "$TMP"; echo; } >> "$XKB/symbols/ua"
    echo "[1/3] symbols/ua: вариант diktor добавлен"
fi

# --- 2. rules/*.lst: секция "! variant" --------------------------------------
for f in "$XKB"/rules/evdev.lst "$XKB"/rules/base.lst; do
    [[ -f $f ]] || continue
    if grep -q '^ *diktor ' "$f"; then
        echo "[2/3] $(basename "$f"): уже есть, пропускаю"
    else
        cp -n "$f" "$f.bak-diktor"
        sed -i '/^! variant/a\  diktor          ua: Ukrainian (diktor)' "$f"
        echo "[2/3] $(basename "$f"): добавлено"
    fi
done

# --- 3. rules/*.xml: вариант в layout "ua" -----------------------------------
# evdev.xml часто симлинк на base.xml — обрабатываем каждый реальный файл один раз.
declare -A seen=()
for f in "$XKB"/rules/evdev.xml "$XKB"/rules/base.xml; do
    [[ -f $f ]] || continue
    real="$(readlink -f "$f")"
    [[ -n ${seen[$real]:-} ]] && continue
    seen[$real]=1

    if grep -q '<name>diktor</name>' "$real"; then
        echo "[3/3] $(basename "$real"): уже есть, пропускаю"
        continue
    fi

    cp -n "$real" "$real.bak-diktor"
    python3 - "$real" <<'PY'
import re, sys
path = sys.argv[1]
text = open(path, encoding="utf-8").read()

variant = (
    "<variant>\n"
    "          <configItem>\n"
    "            <name>diktor</name>\n"
    "            <description>Ukrainian (diktor)</description>\n"
    "          </configItem>\n"
    "        </variant>\n"
    "        "
)

# Находим <layout> с <name>ua</name> и вставляем сразу после его <variantList>
pattern = re.compile(
    r"(<layout>\s*<configItem>\s*<name>ua</name>.*?<variantList>\s*)",
    re.S,
)
new, n = pattern.subn(lambda m: m.group(1) + variant, text, count=1)
if n != 1:
    sys.exit("Не удалось найти layout 'ua' с <variantList> в " + path)
open(path, "w", encoding="utf-8").write(new)
PY
    echo "[3/3] $(basename "$real"): добавлено"
done

# --- Сброс кэша XKB ----------------------------------------------------------
rm -f /var/lib/xkb/*.xkm 2>/dev/null || true

echo
echo "Готово. Перелогиньтесь (или перезагрузитесь) и выберите"
echo "«Ukrainian (diktor)» в настройках клавиатуры."
echo "Быстрая проверка:  setxkbmap -layout ua -variant diktor"
