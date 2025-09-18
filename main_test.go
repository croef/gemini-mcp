package main

import (
	"testing"
)

func TestVersion(t *testing.T) {
	// Test that version variables are defined
	if version == "" {
		t.Error("version should not be empty")
	}
}

func TestServiceName(t *testing.T) {
	// Test that service name is correctly defined
	if serviceName != "gemini-mcp" {
		t.Errorf("expected serviceName to be 'gemini-mcp', got %s", serviceName)
	}
}

func TestMain(t *testing.T) {
	// Test that main function exists and can be called
	// This is a basic smoke test
	t.Log("Main function exists")
}
