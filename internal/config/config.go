package config

import (
	"fmt"
	"os"
)

type Config struct {
	APIKey    string
	ProjectID string
	Location  string
	OutputDir string
	Transport string // "stdio" or "sse"
	SSEPort   int
}

func Load() (*Config, error) {
	config := &Config{
		APIKey:    os.Getenv("GOOGLE_API_KEY"),
		ProjectID: os.Getenv("GOOGLE_PROJECT_ID"),
		Location:  getEnvOrDefault("GOOGLE_LOCATION", "us-central1"),
		OutputDir: getEnvOrDefault("OUTPUT_DIR", "./output"),
		Transport: getEnvOrDefault("TRANSPORT", "stdio"),
		SSEPort:   8080,
	}

	if config.APIKey == "" {
		return nil, fmt.Errorf("GOOGLE_API_KEY environment variable is required")
	}

	// Create output directory if it doesn't exist
	if err := os.MkdirAll(config.OutputDir, 0755); err != nil {
		return nil, fmt.Errorf("failed to create output directory: %w", err)
	}

	return config, nil
}

func getEnvOrDefault(key, defaultValue string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return defaultValue
}
