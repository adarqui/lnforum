build:
	stack build --fast

clean:
	stack clean

tests:
	stack test --fast

ghci:
	stack ghci

ghcjs-build:
	stack --stack-yaml stack.ghcjs.yaml build

ghcjs-build-until:
	until make ghcjs-build; do echo eek; done

ghcjs-build-web: ghcjs-build
	find . -name "ln-ui-ghcjs-exe.jsexe" -exec rsync -av {}/ ../ln-ui-ghcjs/static/dist/ \;
	# fake min.js just so we don't have to change anything in dev mode
	cp ../ln-ui-ghcjs/static/dist/all.js ../ln-ui-ghcjs/static/dist/all.min.js

ghcjs-production: build-web
	ccjs ../ln-ui-ghcjs/static/dist/all.js --compilation_level=ADVANCED_OPTIMIZATIONS > ../ln-ui-ghcjs/static/dist/all.min.js
	zopfli -i1000 ../ln-ui-ghcjs/static/dist/all.min.js > ../ln-ui-ghcjs/static/dist/all.min.js.gz
