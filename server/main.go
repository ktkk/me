package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	fs := http.FileServer(http.Dir("./"))
	http.Handle("/", fs)

	http.HandleFunc("/hello", helloHandler)
	//http.HandleFunc("/world", func(w http.ResponseWriter, r *http.Request) {
	//	fmt.Fprintf(w, "Test")
	//})

	fmt.Printf("Starting server on port 8080\n")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path != "/hello" {
		http.Error(w, "Not found", http.StatusNotFound)
		return
	}

	if r.Method != "GET" {
		http.Error(w, "Method not found", http.StatusNotFound)
		return
	}

	fmt.Fprintf(w, "Hello World!")
}
