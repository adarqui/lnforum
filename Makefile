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
