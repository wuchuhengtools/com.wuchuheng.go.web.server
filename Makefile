EXECUTABLE=webServer
WINDOWS=$(EXECUTABLE)_$(VERSION)_windows_amd64.exe
LINUX=$(EXECUTABLE)_$(VERSION)_linux_amd64
DARWIN=$(EXECUTABLE)_$(VERSION)_darwin_amd64
VERSION=$(shell git tag  | awk 'END{print}')

# Directory of compiled output archive
OUT_DIRECTOR=dist

build: clean windows linux darwin ## Build binaries
	@echo version: $(VERSION)

windows: $(WINDOWS) ## Build for Windows

linux: $(LINUX) ## Build for Linux

darwin: $(DARWIN) ## Build for Darwin (macOS)

mainFile=./src/main.go

clean:
	rm -f $(OUT_DIRECTOR)/$(EXECUTABLE)*

$(WINDOWS):
	env GOOS=windows GOARCH=amd64 go build -v -o $(OUT_DIRECTOR)/$(WINDOWS) -ldflags="-s -w -X main.version=$(VERSION)" $(mainFile)

$(LINUX):
	env GOOS=linux GOARCH=amd64 go build -v -o $(OUT_DIRECTOR)/$(LINUX) -ldflags="-s -w -X main.version=$(VERSION)"  $(mainFile)

$(DARWIN):
	env GOOS=darwin GOARCH=amd64 go build -v -o $(OUT_DIRECTOR)/$(DARWIN) -ldflags="-s -w -X main.version=$(VERSION)"  $(mainFile)
