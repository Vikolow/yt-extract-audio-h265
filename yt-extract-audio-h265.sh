#!/bin/bash
#
# youtube-download.sh
#
# Script para descargar vídeos de YouTube con `yt-dlp`, extraer audio en MP3
# y generar una versión sin audio codificada en H.265.
#
# Uso: ./yt-extract-audio-h265 -u https://www.youtube.com/watch?v=...
#

# =============================
# Comprobación de argumentos
# =============================
if [ "$1" != "-u" ] || [ -z "$2" ]; then
    echo "Uso: $0 -u <URL del vídeo>"
    exit 1
fi

URL=$2

# =============================
# Comprobación de ffmpeg
# =============================
if ! command -v ffmpeg >/dev/null 2>&1; then
    echo "[!] ffmpeg no está instalado. Instalando..."
    sudo apt update && sudo apt install -y ffmpeg
else
    echo "[+] ffmpeg está instalado."
fi

# =============================
# Comprobación de yt-dlp
# =============================
if ! command -v yt-dlp >/dev/null 2>&1; then
    echo "[!] yt-dlp no está instalado. Descargando binario..."

    if [ "$(id -u)" -ne 0 ]; then
        echo "[!] Necesitas permisos de superusuario para instalar en /usr/local/bin"
        echo "[!] Intenta ejecutar el script con: sudo $0 -u $URL"
        exit 1
    fi

    sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp

    if ! command -v yt-dlp >/dev/null 2>&1; then
        echo "[X] Error: yt-dlp no se instaló correctamente."
        exit 1
    else
        echo "[+] yt-dlp instalado correctamente."
    fi
else
    echo "[+] yt-dlp está instalado."
fi

# =============================
# Mostrar título del vídeo
# =============================
echo "[+] Obteniendo título del vídeo..."
RAW_TITLE=$(yt-dlp --get-title $URL)
echo "[i] Título del vídeo: $RAW_TITLE"

# =============================
# Generar nombre base único
# =============================
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BASE="video_${TIMESTAMP}"

# =============================
# Mostrar formatos disponibles
# =============================
echo "[+] Formatos disponibles:"
yt-dlp -F $URL

# =============================
# Solicitar formato al usuario
# =============================
read -p "Introduce el código de formato que deseas descargar: " FORMAT

# =============================
# Descargar vídeo
# =============================
echo "[+] Descargando vídeo con formato $FORMAT..."
yt-dlp -f "$FORMAT" -o "${BASE}.%(ext)s" $URL

# =============================
# Detectar nombre del archivo descargado
# =============================
VIDEO_FILE=$(ls "${BASE}."* | head -n 1)

# =============================
# Extraer audio a MP3
# =============================
echo "[+] Extrayendo audio a MP3..."
ffmpeg -i "$VIDEO_FILE" -q:a 0 -map a "${BASE}_audio.mp3" -y

# =============================
# Crear vídeo sin audio en H.265
# =============================
echo "[+] Generando vídeo sin audio (H.265)..."
ffmpeg -i "$VIDEO_FILE" -an -c:v libx265 -crf 28 "${BASE}_noaudio.mp4" -y

# =============================
# Mostrar info técnica
# =============================
echo -e "\n[i] Info del audio extraído:"
ffmpeg -i "${BASE}_audio.mp3" 2>&1 | grep -E "Duration|Stream.*Audio"

echo -e "\n[i] Info del vídeo sin audio:"
ffmpeg -i "${BASE}_noaudio.mp4" 2>&1 | grep -E "Duration|Stream.*Video"

# =============================
# Final
# =============================
echo -e "\n[+] Proceso completado:"
echo "   - ${BASE}_audio.mp3"
echo "   - ${BASE}_noaudio.mp4"
