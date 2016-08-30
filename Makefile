core-build:
	stack --stack-yaml stack.core.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure

core-build-watch:
	stack --stack-yaml stack.core.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure --file-watch

core-install:
	stack --stack-yaml stack.core.yaml install

core-clean:
	stack --stack-yaml stack.core.yaml clean

core-tests:
	stack --stack-yaml stack.core.yaml test --fast

core-tests-watch:
	stack --stack-yaml stack.core.yaml test --fast --file-watch

core-ghci:
	stack --stack-yaml stack.core.yaml ghci --main-is ln-api-runner:exe:ln-api-runner-exe



yesod-build:
	stack --stack-yaml stack.yesod.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure

yesod-build-watch:
	stack --stack-yaml stack.yesod.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure --file-watch

yesod-build-watch-fast:
	stack --stack-yaml stack.yesod.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure --file-watch --ghc-options -fobject-code

yesod-install:
	stack --stack-yaml stack.yesod.yaml install

yesod-install-watch:
	stack --stack-yaml stack.yesod.yaml install --file-watch

yesod-clean:
	stack --stack-yaml stack.yesod.yaml clean

yesod-tests:
	stack --stack-yaml stack.yesod.yaml test --fast

yesod-ghci:
	stack --stack-yaml stack.yesod.yaml ghci



ghcjs-build:
	stack --stack-yaml stack.ghcjs.yaml build

ghcjs-build-until:
	until make ghcjs-build; do echo eek; done

ghcjs-build-web: ghcjs-build
	find . -name "ln-ui-ghcjs-exe.jsexe" -exec rsync -av {}/ ../ln-ui-ghcjs/static/dist/ \;
	# fake min.js just so we don't have to change anything in dev mode
	cp ../ln-ui-ghcjs/static/dist/all.js ../ln-ui-ghcjs/static/dist/all.min.js

ghcjs-production: ghcjs-build-web
	ccjs ../ln-ui-ghcjs/static/dist/all.js --compilation_level=ADVANCED_OPTIMIZATIONS > ../ln-ui-ghcjs/static/dist/all.min.js
	zopfli -i1000 ../ln-ui-ghcjs/static/dist/all.min.js > ../ln-ui-ghcjs/static/dist/all.min.js.gz

ghcjs-clean:
	stack --stack-yaml stack.ghcjs.yaml clean

ghcjs-upload:
	rsync -av ../ln-ui-ghcjs/static/dist/ adarq:projects/leuronet/ln-ui-ghcjs/static/dist/


interop-build:
	stack --stack-yaml stack.interop.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure

interop-build-watch:
	stack --stack-yaml stack.interop.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure --file-watch

interop-build-watch-fast:
	stack --stack-yaml stack.interop.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure --file-watch --ghc-options -fobject-code

interop-install:
	stack --stack-yaml stack.interop.yaml install

interop-clean:
	stack --stack-yaml stack.interop.yaml clean

interop-tests:
	stack --stack-yaml stack.interop.yaml test --fast

interop-ghci:
	stack --stack-yaml stack.interop.yaml ghci



smf-build:
	brew install icu4c
	brew link icu4c --force
	stack --stack-yaml stack.smf.yaml install text-icu --extra-lib-dirs=/usr/local/opt/icu4c/lib --extra-include-dirs=/usr/local/opt/icu4c/include
	stack --stack-yaml stack.smf.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure

smf-build-watch:
	stack --stack-yaml stack.smf.yaml build -j 8 --fast --no-library-profiling --no-executable-profiling --no-haddock --no-haddock-deps --no-copy-bins --no-test --no-bench --no-reconfigure --file-watch

smf-install:
	stack --stack-yaml stack.smf.yaml install

smf-install-watch:
	stack --stack-yaml stack.smf.yaml install --file-watch

smf-clean:
	stack --stack-yaml stack.smf.yaml clean

smf-tests:
	stack --stack-yaml stack.smf.yaml test --fast

smf-tests-watch:
	stack --stack-yaml stack.smf.yaml test --fast --file-watch

smf-ghci:
	stack --stack-yaml stack.smf.yaml ghci

smf-clean-redis:
	redis-cli -p 16379 keys "migrate*" | xargs redis-cli -p 16379 del



private-upload:
	rsync -av ../ln-yesod/private/ adarq:projects/leuronet/ln-yesod/private/
