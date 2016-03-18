all:
		go build ./cmd/hmgen
		go build ./cmd/hmview

test:
		go test ./...

clean:
		rm -f cmd/hmgen/hmgen cmd/hmview/hmview
