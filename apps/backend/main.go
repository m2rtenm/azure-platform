package main

import (
	"context"
	"encoding/json"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

type server struct {
	database *pgxpool.Pool
}

func main() {
	databaseURL := os.Getenv("DATABASE_URL")
	if databaseURL == "" {
		log.Fatal("DATABASE_URL must be configured")
	}

	config, err := pgxpool.ParseConfig(databaseURL)
	if err != nil {
		log.Fatalf("parse DATABASE_URL: %v", err)
	}
	config.MaxConns = 4
	config.MinConns = 1

	database, err := pgxpool.NewWithConfig(context.Background(), config)
	if err != nil {
		log.Fatalf("connect to PostgreSQL: %v", err)
	}
	defer database.Close()

	app := &server{database: database}
	mux := http.NewServeMux()
	mux.HandleFunc("GET /healthz", app.health)
	mux.HandleFunc("GET /api/v1/message", app.message)

	httpServer := &http.Server{
		Addr:              ":8080",
		Handler:           mux,
		ReadHeaderTimeout: 5 * time.Second,
	}
	log.Printf("listening on %s", httpServer.Addr)
	log.Fatal(httpServer.ListenAndServe())
}

func (s *server) health(writer http.ResponseWriter, request *http.Request) {
	ctx, cancel := context.WithTimeout(request.Context(), 2*time.Second)
	defer cancel()
	if err := s.database.Ping(ctx); err != nil {
		http.Error(writer, "database unavailable", http.StatusServiceUnavailable)
		return
	}
	writer.WriteHeader(http.StatusOK)
}

func (s *server) message(writer http.ResponseWriter, request *http.Request) {
	ctx, cancel := context.WithTimeout(request.Context(), 2*time.Second)
	defer cancel()

	var databaseName string
	var now time.Time
	if err := s.database.QueryRow(ctx, "select current_database(), current_timestamp").Scan(&databaseName, &now); err != nil {
		http.Error(writer, "database unavailable", http.StatusServiceUnavailable)
		return
	}

	writer.Header().Set("Content-Type", "application/json")
	_ = json.NewEncoder(writer).Encode(map[string]string{
		"database": databaseName,
		"message":  "Hello from the Azure platform sample backend.",
		"time":     now.UTC().Format(time.RFC3339),
	})
}
