ECHO OFF
cls
	
REM	Lista de Valores: Archivo con los valores que se usaran para el script principal 
rem    	gmt math -T0/40000/250    -o1 T = "temp_col0.txt"
    	gmt math -T0/40000/2500    -o1 T = "temp_col0.txt"

REM	Movie: Crear figuras y animacion
REM	Opciones C: Canvas Size. -Agif -N: Nombre de la carpeta con archivos temporales -T
rem	gmt movie "Upward_FAA_ARG_Spectrum+Map_MainScript.bat" -N"Upward_FAA_ARG_Espectrum+Map2" -T"temp_col0.txt" -C19.22cx21.735cx100 -Fmp4 -D12 -V3	
	gmt movie "Low-Pass_Depth_Spectrum+Map_Animacion.bat" -N"Low-Pass_Espectrum+Map2" -T"temp_col0.txt" -C19.22cx21.735cx100 -Fmp4 -D12 -V3 -Agif

REM	Reusar figuras: con ffmpeg
REM	-framerate: figuras por segundo (fps)
REM	-i: Carpeta con archivos y Archivos 
	REM ffmpeg -loglevel warning -f image2 -framerate 12 -y -i "Upward\Upward_%%03d.png" -vcodec libx264 -pix_fmt yuv420p "Upward.mp4"

REM Reusar figuras: con GraphicsMagick
	REM gm convert  -delay 8 -loop 0 +dither Upward\Upward*.png Upward.gif

REM	Borrar Temporales
	del temp_* gmt.*
	REM pause

REM	Apagar (-s) o Hibernar (/h) PC
rem	shutdown -s 
REM  	shutdown /h
