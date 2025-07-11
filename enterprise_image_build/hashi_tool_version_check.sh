#!/bin/bash
echo "==========================================================================================="
echo "Script to Check if HashiCorp Packer and Terraform are Installed and Verify Their Versions  "
echo "==========================================================================================="
# Ask user what they want to check
echo "Please enter what you want to check ('packer' or 'terraform'): "
read USER_INPUT  # Use read to capture user input
echo "User entered the input as: $USER_INPUT"  # Correctly echo the input

# Use case statement to check the input
case "$USER_INPUT" in
  "packer")
    echo "Checking if Packer is installed and its version..."
    packer --version
    ;;
  "terraform")
    echo "Checking if Terraform is installed and its version..."
    terraform --version
    ;;
  *)
    echo "Invalid input. Please enter 'packer' or 'terraform'."
    ;;
esac
exit 0
