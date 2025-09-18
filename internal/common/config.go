package common

import (
	"fmt"
	"os"
)

type Config struct {
	// Gemini API Configuration
	APIKey    string
	ProjectID string
	Location  string

	// Server Configuration
	Port           string
	Transport      string
	OutputDir      string
	GenmediaBucket string
}

func LoadConfig() *Config {
	config := &Config{
		APIKey:         os.Getenv("GOOGLE_API_KEY"),
		ProjectID:      os.Getenv("GOOGLE_PROJECT_ID"),
		Location:       getEnvOrDefault("GOOGLE_LOCATION", "us-central1"),
		Port:           getEnvOrDefault("PORT", "8080"),
		Transport:      getEnvOrDefault("TRANSPORT", "stdio"),
		OutputDir:      getEnvOrDefault("OUTPUT_DIR", "./output"),
		GenmediaBucket: os.Getenv("GENMEDIA_BUCKET"),
	}

	// Create output directory if it doesn't exist
	if config.OutputDir != "" {
		if err := os.MkdirAll(config.OutputDir, 0755); err != nil {
			fmt.Printf("Warning: Failed to create output directory: %v\n", err)
		}
	}

	return config
}

func getEnvOrDefault(key, defaultValue string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return defaultValue
}

func (c *Config) Validate() error {
	if c.APIKey == "" {
		return fmt.Errorf("GOOGLE_API_KEY environment variable is required")
	}
	return nil
}
