install:
	git submodule init
	git submodule update

deploy:
	firebase deploy

validate:
	ruby validate-hls/validate-hls.rb "http://localhost:8080/stream/index.m3u8"

ffmpeg_list_devices:
	ffmpeg -f avfoundation -list_devices true -i ""

ffmpeg_create_hls:
	ffmpeg -loglevel error \
		-f avfoundation \
		-framerate 30 \
		-i "default" \
		-vcodec libx264 \
		-r 30 \
		-g 60 \
		-s 800x600 \
		-aspect 4:3 \
		-acodec aac \
		-ar 22050 \
		-b:v 1.0M \
		-minrate:v 900k \
		-maxrate:v 1.5M \
		-bufsize:v 2M \
		-b:a 128K \
		-pix_fmt yuv420p \
		-f hls \
		-hls_time 2 -hls_list_size 2 -hls_allow_cache 0 \
		stream/index.m3u8

server:
	php -S localhost:8080

clean:
	rm -rf stream/*
