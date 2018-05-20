install:
	git submodule init
	git submodule update

deploy:
	firebase deploy

validate:
	ruby validate-hls/validate-hls.rb "https://misc-5542e.firebaseapp.com/hls/index.m3u8"

ffmpeg_list_devices:
	ffmpeg -f avfoundation -list_devices true -i ""

ffmpeg_record:
	ffmpeg -f avfoundation -framerate 25 -i "default" input.ts

IP?=192.168.0.0

distribution:
	ffmpeg -i udp://${IP}:35001 -c:v libx264 -crf:v 22 -b:v 500k -preset:v veryfast -c:a libfdk_aac -b:a 64k -f mpegts - | mediastreamsegmenter -b http://localhost/stream -f .//stream/ -t 10 -s 4 -S 1 -D -y id3 -m -M 4242 -l log.txt

ffmpeg_camera_to_udp:
	ffmpeg -loglevel error \
		-f avfoundation \
		-framerate 25 \
		-i "default" \
		-vcodec libx264 \
		-preset ultrafast \
		-tune zerolatency \
		-thread_type slice \
		-slices 1 \
		-intra-refresh 1 \
		-r 30 \
		-g 60 \
		-s 800x600 \
		-aspect 4:3 \
		-acodec aac \
		-ar 44100 \
		-b:v 2.5M \
		-minrate:v 900k \
		-maxrate:v 2.5M \
		-bufsize:v 5M \
		-b:a 128K \
		-pix_fmt yuv420p \
		-f mpegts udp://${IP}:35001?pkt_size=1316

ffmpeg_create_hls:
	ffmpeg -f avfoundation -framerate 25 -i "default" -f hls stream/index.m3u8

server:
	php -S localhost:8080
