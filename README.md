# 🎞️ yt-extract-audio-h265

Este script en Bash automatiza la descarga de vídeos de YouTube, extrayendo el audio en formato MP3 y generando una versión del vídeo sin audio comprimida con el códec H.265. Todo se realiza pasando la URL como argumento.

## ✅ Requisitos

- Linux  
- `ffmpeg` (se instala automáticamente si no está presente)  
- `yt-dlp` (se instala automáticamente en `/usr/local/bin`, requiere `sudo`)

## 🚀 Instalación

```bash
git clone https://github.com/Vikolow/yt-extract-audio-h265.git
cd yt-extract-audio-h265
chmod +x yt-extract-audio-h265.sh
```

## 🧪 Uso

```bash
./yt-extract-audio-h265.sh -u https://www.youtube.com/watch?v=ID_DEL_VIDEO
```

- El script te mostrará los formatos disponibles y te pedirá que elijas uno.  
- A continuación descargará el vídeo, extraerá el audio y generará una versión del vídeo sin sonido.  
- Todos los archivos se guardan en el directorio actual.

### 🧾 Archivos generados

- `video_TIMESTAMP_audio.mp3`: Solo el audio extraído en MP3  
- `video_TIMESTAMP_noaudio.mp4`: Vídeo sin audio, comprimido con códec H.265  

> `TIMESTAMP` corresponde al momento exacto de ejecución garantizando nombres únicos y seguros.

## 📝 Notas

- El script **no utiliza el título del vídeo** en los nombres de archivo, evitando errores por caracteres especiales o nombres excesivamente largos.
- Si `yt-dlp` o `ffmpeg` no están instalados, el script los descargará e instalará automáticamente (requiere `sudo`).
- Compatible con sistemas Debian/Ubuntu. Puede requerir adaptaciones mínimas en otras distribuciones.

## 📄 Licencia

Este proyecto está licenciado bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.
