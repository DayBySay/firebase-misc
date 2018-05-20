install:
	git submodule init
	git submodule update

deploy:
	firebase deploy

validate:
	ruby validate-hls/validate-hls.rb "https://misc-5542e.firebaseapp.com/hls/index.m3u8"
