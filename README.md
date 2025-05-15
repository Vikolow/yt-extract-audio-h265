# 🎞️ yt-extract-audio-h265

Este script en Bash automatiza la descarga de vídeos de YouTube, extrayendo el audio en formato MP3 y generando una versión del vídeo sin audio comprimida con el códec H.265.

## ✅ Requisitos

- Linux 
- `ffmpeg` (se instala automáticamente)
- `yt-dlp` (se instala automáticamente en `/usr/local/bin`, requiere `sudo`)

## 🚀 Instalación

```bash
git clone https://github.com/Vikolow/yt-extract-audio-h265.git
cd yt-extract-audio-h265
chmod +x yt-extract-audio-h265.sh
```

## 🧪 Uso
```bash
./yt-extract-audio-h265.sh
```

- Introduce la URL del vídeo de YouTube cuando se solicite.

- Elige el formato del vídeo entre los que se mostrarán.

- El script generará en el directorio actual:

    - NOMBRE_audio.mp3: Solo el audio extraído.

    - NOMBRE_noaudio.mp4: Vídeo sin audio, comprimido en H.265.

## 📝 Notas
El nombre de los archivos se genera automáticamente a partir del título del vídeo.

Si yt-dlp o ffmpeg no está instalado, el script lo descargará automáticamente (requiere permisos sudo).

## 📄 Licencia
Este proyecto está licenciado bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.
